//=============================================================================
// File: tb/tb_adc_rtl.sv
// Description: End-to-End System Integration Testbench for adc_top.sv
//=============================================================================

`timescale 1ns/1ps

`include "adc_config.sv"
`include "adc_top.sv"

module tb_adc_rtl;
  import adc_pkg::*;

  logic        clk;
  logic        rst_n;
  logic        sclk;
  logic        cs_n;
  logic        mosi;
  wire         miso;

  logic        sample_en;
  logic [2:0]  channel_sel;
  logic [9:0]  dac_code;
  logic        cmp_out;

  logic        busy;
  logic        conv_done;
  logic [9:0]  result_data;
  logic [2:0]  result_channel;
  logic        result_valid;
  logic        err_flag;

  // DUT instantiation
  adc_top u_top (
    .clk            (clk),
    .rst_n          (rst_n),
    .sclk           (sclk),
    .cs_n           (cs_n),
    .mosi           (mosi),
    .miso           (miso),
    .sample_en      (sample_en),
    .channel_sel    (channel_sel),
    .dac_code       (dac_code),
    .cmp_out        (cmp_out),
    .busy           (busy),
    .conv_done      (conv_done),
    .result_data    (result_data),
    .result_channel (result_channel),
    .result_valid   (result_valid),
    .err_flag       (err_flag)
  );

  // Core clock: 50 MHz (20ns period)
  always #10 clk = ~clk;

  // Analogue Front-End Behavioural Loop in Testbench
  // 8 Channels with distinct analog code equivalents
  logic [9:0] ch_voltages[0:7];
  logic [9:0] held_voltage;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      held_voltage <= '0;
    end else if (sample_en) begin
      held_voltage <= ch_voltages[channel_sel];
    end
  end

  // Behavioural Comparator: held_voltage >= dac_code
  assign cmp_out = (held_voltage >= dac_code);

  int errors = 0;
  int tests_run = 0;

  // SPI Master Transaction Task (Mode 0: 10 MHz SCLK)
  task automatic spi_transfer(
    input  logic [15:0] tx_frame,
    output logic [15:0] rx_frame
  );
    rx_frame = 16'h0000;
    sclk     = 1'b0;
    mosi     = 1'b0;
    #50;

    cs_n = 1'b0;
    #25;

    for (int i = 15; i >= 0; i--) begin
      mosi = tx_frame[i];
      #25;
      sclk = 1'b1;
      rx_frame[i] = miso;
      #50;
      sclk = 1'b0;
      #25;
    end

    #25;
    cs_n = 1'b1;
    mosi = 1'b0;
    #50;
  endtask

  // Task to request conversion and read back result via SPI
  task automatic test_adc_conversion(
    input logic [2:0] ch,
    input logic [9:0] input_code,
    input string      test_name
  );
    logic [15:0] cmd_frame;
    logic [15:0] rx_resp1, rx_resp2;
    logic [15:0] exp_resp;
    int timeout;

    tests_run++;
    ch_voltages[ch] = input_code;

    // Frame 1: Request conversion on channel 'ch' with AUTO_START=1
    // [15]=1 (START), [14]=1 (SGL), [13:11]=ch, [10]=1 (AUTO_START), [9:0]=0
    cmd_frame = {1'b1, 1'b1, ch, 1'b1, 10'b0};
    $display("\n>>> Initiating Conversion: %s on CH%0d with Code %0d (0x%03h)",
             test_name, ch, input_code, input_code);
    spi_transfer(cmd_frame, rx_resp1);

    // Wait for conversion to complete in core domain (12 cycles * 20ns = 240ns)
    timeout = 0;
    while (!result_valid && timeout < 50) begin
      @(posedge clk);
      timeout++;
    end
    #200; // Allow settling

    // Frame 2: Readback result (NOP frame)
    spi_transfer(16'h0000, rx_resp2);

    // Expected Response: READY=1, BUSY=0, ERR=0, CH=ch, DATA=input_code
    exp_resp = {1'b1, 1'b0, 1'b0, ch, input_code};

    if (rx_resp2 === exp_resp) begin
      $display("[PASS] %s: Expected 0x%04h, Got 0x%04h (CH=%0d, Code=%0d)",
               test_name, exp_resp, rx_resp2, rx_resp2[12:10], rx_resp2[9:0]);
    end else begin
      $display("[FAIL] %s: Mismatch! Expected 0x%04h, Got 0x%04h",
               test_name, exp_resp, rx_resp2);
      errors++;
    end

    // Frame 3: Stability check - repeat read without new conversion request
    spi_transfer(16'h0000, rx_resp2);
    if (rx_resp2 === exp_resp) begin
      $display("[PASS] Result stability verified: multiple reads return identical data 0x%04h", rx_resp2);
    end else begin
      $display("[FAIL] Stale/unstable result observed on repeated read! Got 0x%04h", rx_resp2);
      errors++;
    end
  endtask

  initial begin
    $dumpfile("tb_adc_rtl.vcd");
    $dumpvars(0, tb_adc_rtl);

    clk   = 0;
    rst_n = 0;
    sclk  = 0;
    cs_n  = 1;
    mosi  = 0;

    for (int i = 0; i < 8; i++) ch_voltages[i] = 10'd0;

    // Apply Reset
    #40;
    rst_n = 1;
    #40;

    $display("==========================================================");
    $display("Starting End-to-End System Integration Verification (adc_top)");
    $display("==========================================================");

    // 1. Zero input test on Channel 0
    test_adc_conversion(3'd0, 10'd0,    "Zero Scale (CH0)");

    // 2. 1 LSB test on Channel 1
    test_adc_conversion(3'd1, 10'd1,    "1 LSB (CH1)");

    // 3. Quarter-Scale test on Channel 2
    test_adc_conversion(3'd2, 10'd256,  "Quarter-Scale 1.25V (CH2)");

    // 4. Half-Scale test on Channel 4
    test_adc_conversion(3'd4, 10'd512,  "Half-Scale Mid-Code 2.50V (CH4)");

    // 5. Three-Quarter-Scale test on Channel 6
    test_adc_conversion(3'd6, 10'd768,  "Three-Quarter-Scale 3.75V (CH6)");

    // 6. Full-Scale Max test on Channel 7
    test_adc_conversion(3'd7, 10'd1023, "Full-Scale Max 5.00V (CH7)");

    // Summary
    $display("\n==========================================================");
    $display("System Integration Summary: %0d tests run, %0d errors", tests_run, errors);
    $display("==========================================================");

    if (errors == 0) begin
      $display("RESULT: ALL SYSTEM INTEGRATION TESTS PASSED");
    end else begin
      $display("RESULT: TESTS FAILED WITH %0d ERRORS", errors);
    end

    $finish;
  end

endmodule

