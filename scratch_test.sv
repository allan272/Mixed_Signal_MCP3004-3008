
`include "rtl/adc_config.sv"

module test_spi (
  input  logic clk,
  input  logic rst_n,
  input  logic sclk,
  input  logic cs_n,
  input  logic mosi,
  output logic miso,
  output logic err_flag
);
  logic [15:0] rx_shift_q;
  logic [15:0] tx_shift_q;
  logic [15:0] tx_snapshot_q;
  logic [4:0]  bit_count_q;
  logic        abort_err_q;
  logic        cmd_err_q;
  logic        start_toggle_q;
  logic [2:0]  req_channel_q;

  assign err_flag = abort_err_q | cmd_err_q;

  always_ff @(negedge cs_n or negedge rst_n) begin
    if (!rst_n) tx_snapshot_q <= '0;
    else tx_snapshot_q <= {1'b1, 1'b0, err_flag, 3'd0, 10'd0};
  end

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

  always_ff @(posedge sclk or posedge cs_n or negedge rst_n) begin
    if (!rst_n) begin
      rx_shift_q     <= '0;
      bit_count_q    <= '0;
      start_toggle_q <= 1'b0;
      req_channel_q  <= '0;
      cmd_err_q      <= 1'b0;
    end else if (cs_n) begin
      bit_count_q <= '0;
      rx_shift_q  <= '0;
    end else begin
      rx_shift_q  <= {rx_shift_q[14:0], mosi};
      bit_count_q <= bit_count_q + 5'd1;
    end
  end

  always_ff @(negedge sclk or posedge cs_n or negedge rst_n) begin
    if (!rst_n) begin
      tx_shift_q <= '0;
    end else if (cs_n) begin
      tx_shift_q <= '0;
    end else begin
      tx_shift_q <= {tx_shift_q[14:0], 1'b0};
    end
  end

  assign miso = (!cs_n) ? tx_shift_q[15] : 1'bz;
endmodule
