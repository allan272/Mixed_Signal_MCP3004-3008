//=============================================================================
// File: rtl/spi_slave.sv
// Description: SPI Slave Interface (Mode 0: CPOL=0, CPHA=0) with 16-bit framing
//=============================================================================

`ifndef SPI_SLAVE_SV
`define SPI_SLAVE_SV

`include "adc_config.sv"

module spi_slave #(
  parameter int unsigned ADC_BITS          = adc_pkg::ADC_BITS,
  parameter int unsigned CH_ADDR_BITS      = adc_pkg::CH_ADDR_BITS,
  parameter int unsigned SPI_FRAME_BITS    = adc_pkg::SPI_FRAME_BITS,
  parameter int          MOSI_START_BIT    = adc_pkg::MOSI_START_BIT,
  parameter int          MOSI_SGL_DIFF_BIT = adc_pkg::MOSI_SGL_DIFF_BIT,
  parameter int          MOSI_CH_MSB       = adc_pkg::MOSI_CH_MSB,
  parameter int          MOSI_CH_LSB       = adc_pkg::MOSI_CH_LSB,
  parameter int          MOSI_AUTO_START_BIT = adc_pkg::MOSI_AUTO_START_BIT,
  parameter int          MISO_READY_BIT    = adc_pkg::MISO_READY_BIT,
  parameter int          MISO_BUSY_BIT     = adc_pkg::MISO_BUSY_BIT,
  parameter int          MISO_ERR_BIT      = adc_pkg::MISO_ERR_BIT,
  parameter int          MISO_CH_MSB       = adc_pkg::MISO_CH_MSB,
  parameter int          MISO_CH_LSB       = adc_pkg::MISO_CH_LSB,
  parameter int          MISO_DATA_MSB     = adc_pkg::MISO_DATA_MSB,
  parameter int          MISO_DATA_LSB     = adc_pkg::MISO_DATA_LSB
) (
  // Core clock & reset
  input  logic                    clk,
  input  logic                    rst_n,

  // SPI physical bus
  input  logic                    sclk,
  input  logic                    cs_n,
  input  logic                    mosi,
  output logic                    miso,

  // ADC Core Interface
  input  logic                    adc_busy,
  input  logic                    adc_valid,
  input  logic [ADC_BITS-1:0]     adc_data,
  input  logic [CH_ADDR_BITS-1:0] adc_channel,
  output logic                    conv_start,
  output logic [CH_ADDR_BITS-1:0] conv_channel,
  output logic                    err_flag
);

  //---------------------------------------------------------------------------
  // SPI Domain Registers
  //---------------------------------------------------------------------------
  logic [15:0]             rx_shift_q;
  logic [15:0]             tx_shift_q;
  logic [15:0]             tx_snapshot_q;
  logic [4:0]              bit_count_q;
  logic                    cmd_err_q;
  logic                    abort_err_q;
  logic                    start_toggle_q;
  logic [CH_ADDR_BITS-1:0] req_channel_q;

  assign err_flag = abort_err_q | cmd_err_q;

  // Snapshot active status & data on falling edge of CS_N
  always_ff @(negedge cs_n or negedge rst_n) begin
    if (!rst_n) begin
      tx_snapshot_q <= '0;
    end else begin
      tx_snapshot_q <= {adc_valid, adc_busy, err_flag, adc_channel, adc_data};
    end
  end

  // Premature CS_N abort detector
  always_ff @(posedge cs_n or negedge rst_n) begin
    if (!rst_n) begin
      abort_err_q <= 1'b0;
    end else begin
      if (bit_count_q != 5'd0 && bit_count_q != 5'd16) begin
        abort_err_q <= 1'b1;
      end else begin
        abort_err_q <= 1'b0;
      end
    end
  end

  // Combinational decode of MOSI header bits
  logic                    start_bit_w;
  logic                    sgl_bit_w;
  logic                    auto_start_bit_w;
  logic [CH_ADDR_BITS-1:0] ch_addr_w;

  assign start_bit_w      = rx_shift_q[4];
  assign sgl_bit_w        = rx_shift_q[3];
  assign ch_addr_w        = rx_shift_q[2:0];
  assign auto_start_bit_w = mosi;

  // Bit Counter and MOSI receiver on rising edge of SCLK
  always_ff @(posedge sclk or posedge cs_n or negedge rst_n) begin
    if (!rst_n) begin
      rx_shift_q  <= '0;
      bit_count_q <= '0;
      cmd_err_q   <= 1'b0;
    end else if (cs_n) begin
      bit_count_q <= '0;
      rx_shift_q  <= '0;
      cmd_err_q   <= 1'b0;
    end else begin
      // Sample MOSI
      rx_shift_q  <= {rx_shift_q[14:0], mosi};
      bit_count_q <= bit_count_q + 5'd1;

      // When the 6th bit (bit index 10, AUTO_START) arrives:
      // MOSI bits received so far: [15] START, [14] SGL_DIFF, [13:11] CH[2:0], [10] AUTO_START
      if (bit_count_q == 5'd5) begin
        if (start_bit_w && sgl_bit_w && auto_start_bit_w) begin
          if (adc_busy) begin
            cmd_err_q <= 1'b1; // Conversion request while busy
          end
        end else if (start_bit_w && !sgl_bit_w) begin
          cmd_err_q   <= 1'b1; // Unsupported differential mode
        end
      end
    end
  end

  // Transaction start trigger (CDC)
  always_ff @(posedge sclk or negedge rst_n) begin
    if (!rst_n) begin
      start_toggle_q <= 1'b0;
      req_channel_q  <= '0;
    end else if (!cs_n) begin
      if (bit_count_q == 5'd5) begin
        if (start_bit_w && sgl_bit_w && auto_start_bit_w && !adc_busy) begin
          req_channel_q  <= ch_addr_w;
          start_toggle_q <= ~start_toggle_q;
        end
      end
    end
  end

  // MISO TX Shift Register on Falling Edge of SCLK
  logic miso_bit;

  always_ff @(negedge sclk or posedge cs_n or negedge rst_n) begin
    if (!rst_n) begin
      tx_shift_q <= '0;
    end else if (cs_n) begin
      tx_shift_q <= '0;
    end else begin
      if (bit_count_q == 5'd1) begin
        // First falling edge: load remaining 14 bits from snapshot
        tx_shift_q <= {tx_snapshot_q[14:0], 1'b0};
      end else begin
        // Subsequent falling edges: shift left
        tx_shift_q <= {tx_shift_q[14:0], 1'b0};
      end
    end
  end

  // MISO bit selection:
  // Before first falling edge (bit_count_q == 0), output MSB of snapshot
  // Thereafter, output MSB of tx_shift_q
  assign miso_bit = (bit_count_q == 5'd0) ? tx_snapshot_q[15] : tx_shift_q[15];

  // Tri-state MISO when CS_N is HIGH
  assign miso     = (!cs_n) ? miso_bit : 1'bz;

  //---------------------------------------------------------------------------
  // Clock Domain Crossing (SCLK to clk domain)
  // Dual-flop toggle synchronizer for conv_start request
  //---------------------------------------------------------------------------
  logic sync_toggle_q1, sync_toggle_q2, sync_toggle_q3;
  logic [CH_ADDR_BITS-1:0] channel_sync_q;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sync_toggle_q1 <= 1'b0;
      sync_toggle_q2 <= 1'b0;
      sync_toggle_q3 <= 1'b0;
      conv_start     <= 1'b0;
      conv_channel   <= '0;
      channel_sync_q <= '0;
    end else begin
      sync_toggle_q1 <= start_toggle_q;
      sync_toggle_q2 <= sync_toggle_q1;
      sync_toggle_q3 <= sync_toggle_q2;
      channel_sync_q <= req_channel_q;

      // Pulse conv_start for 1 core clock cycle on toggle detection
      if (sync_toggle_q2 ^ sync_toggle_q3) begin
        conv_start   <= 1'b1;
        conv_channel <= channel_sync_q;
      end else begin
        conv_start   <= 1'b0;
      end
    end
  end

endmodule

`endif // SPI_SLAVE_SV
