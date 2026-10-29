//=============================================================================
// File: rtl/adc_top.sv
// Description: Top-Level Integration of 10-Bit, 8-Channel Educational SAR ADC
//=============================================================================

`ifndef ADC_TOP_SV
`define ADC_TOP_SV

`include "adc_config.sv"
`include "sar_controller.sv"
`include "result_register.sv"
`include "spi_slave.sv"

module adc_top #(
  parameter int unsigned ADC_BITS     = adc_pkg::ADC_BITS,
  parameter int unsigned CH_ADDR_BITS = adc_pkg::CH_ADDR_BITS
) (
  // Core system clock & reset
  input  logic                    clk,
  input  logic                    rst_n,

  // SPI interface (Mode 0: CPOL=0, CPHA=0)
  input  logic                    sclk,
  input  logic                    cs_n,
  input  logic                    mosi,
  output logic                    miso,

  // Analogue Front-End & Mixed-Signal Interface
  output logic                    sample_en,     // Sample (1) / Hold (0) control
  output logic [CH_ADDR_BITS-1:0] channel_sel,   // 8-channel MUX address
  output logic [ADC_BITS-1:0]     dac_code,      // Digital trial code to DAC
  input  logic                    cmp_out,       // Decision input from comparator

  // Digital Status & Monitoring Outputs
  output logic                    busy,          // ADC conversion in progress
  output logic                    conv_done,     // Single-cycle conversion strobe
  output logic [ADC_BITS-1:0]     result_data,   // Latched 10-bit conversion code
  output logic [CH_ADDR_BITS-1:0] result_channel,// Latched channel tag
  output logic                    result_valid,  // Set high once first result is ready
  output logic                    err_flag       // Protocol/timing error flag
);

  // Internal interconnects
  logic                    conv_start_w;
  logic [CH_ADDR_BITS-1:0] conv_channel_w;
  logic                    sar_busy_w;
  logic                    sar_done_w;
  logic [ADC_BITS-1:0]     sar_result_w;
  logic [3:0]              sar_bit_ptr_w;

  logic [ADC_BITS-1:0]     reg_data_w;
  logic [CH_ADDR_BITS-1:0] reg_channel_w;
  logic                    reg_valid_w;

  // Active conversion channel register
  logic [CH_ADDR_BITS-1:0] active_channel_q;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      active_channel_q <= '0;
    end else if (conv_start_w && !sar_busy_w) begin
      active_channel_q <= conv_channel_w;
    end
  end

  assign channel_sel    = active_channel_q;
  assign busy           = sar_busy_w;
  assign conv_done      = sar_done_w;
  assign result_data    = reg_data_w;
  assign result_channel = reg_channel_w;
  assign result_valid   = reg_valid_w;

  // 1. SAR State Machine & Trial Register Core
  sar_controller u_sar_core (
    .clk       (clk),
    .rst_n     (rst_n),
    .start     (conv_start_w),
    .cmp_out   (cmp_out),
    .sample_en (sample_en),
    .dac_code  (dac_code),
    .busy      (sar_busy_w),
    .done      (sar_done_w),
    .result    (sar_result_w),
    .bit_ptr   (sar_bit_ptr_w)
  );

  // 2. Conversion Result Holding Register
  result_register u_result_reg (
    .clk         (clk),
    .rst_n       (rst_n),
    .latch_en    (sar_done_w),
    .data_in     (sar_result_w),
    .channel_in  (active_channel_q),
    .data_out    (reg_data_w),
    .channel_out (reg_channel_w),
    .data_valid  (reg_valid_w)
  );

  // 3. SPI Slave Interface (Mode 0)
  spi_slave u_spi (
    .clk          (clk),
    .rst_n        (rst_n),
    .sclk         (sclk),
    .cs_n         (cs_n),
    .mosi         (mosi),
    .miso         (miso),
    .adc_busy     (sar_busy_w),
    .adc_valid    (reg_valid_w),
    .adc_data     (reg_data_w),
    .adc_channel  (reg_channel_w),
    .conv_start   (conv_start_w),
    .conv_channel (conv_channel_w),
    .err_flag     (err_flag)
  );

endmodule

`endif // ADC_TOP_SV

