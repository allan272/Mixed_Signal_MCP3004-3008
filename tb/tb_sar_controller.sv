//=============================================================================
// File: tb/tb_sar_controller.sv
// Description: Testbench for SAR Controller & Trial Register Core
//=============================================================================

`timescale 1ns/1ps

`include "adc_config.sv"
`include "sar_controller.sv"

module tb_sar_controller;
  import adc_pkg::*;

  logic        clk;
  logic        rst_n;
  logic        start;
  logic        cmp_out;
  logic        sample_en;
  logic [9:0]  dac_code;
  logic        busy;
  logic        done;
  logic [9:0]  result;
  logic [3:0]  bit_ptr;

  // DUT instantiation
  sar_controller u_dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .start     (start),
    .cmp_out   (cmp_out),
    .sample_en (sample_en),
    .dac_code  (dac_code),
    .busy      (busy),
    .done      (done),
    .result    (result),
    .bit_ptr   (bit_ptr)
  );

  // Clock generation: 100 MHz (10ns period)
  always #5 clk = ~clk;

  // Model ideal Sample & Hold: track target_code when sample_en is high, hold otherwise
  logic [9:0] target_code;
  logic [9:0] held_code;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      held_code <= '0;
    end else if (sample_en) begin
      held_code <= target_code;
    end
  end

  // Emulated comparator: compare held code against current DAC trial code
  assign cmp_out = (held_code >= dac_code);

  int errors = 0;
  int tests_run = 0;

  // Task to run a single conversion and verify result
  task automatic run_conversion(input logic [9:0] exp_code, input string label);
    int cycle_count;
    tests_run++;
    target_code = exp_code;
    
    @(posedge clk);
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;

    cycle_count = 0;
    while (!done) begin
      @(posedge clk);
      cycle_count++;
      if (cycle_count > 20) begin
        $display("[ERROR] Timeout waiting for done signal! Target: %0d", exp_code);
        errors++;
      end
    end

    // Verify result immediately at done assertion
    if (result !== exp_code) begin
      $display("[FAIL] %s: Expected 10'd%0d (0x%03h), Got 10'd%0d (0x%03h)",
               label, exp_code, exp_code, result, result);
      errors++;
    end else begin
      $display("[PASS] %s: Converted code 10'd%0d (0x%03h) matched in %0d cycles",
               label, result, result, cycle_count);
    end
    @(posedge clk);
  endtask

  initial begin
    $dumpfile("tb_sar_controller.vcd");
    $dumpvars(0, tb_sar_controller);

    clk   = 0;
    rst_n = 0;
    start = 0;
    target_code = 0;

    // Apply Reset
    #20;
    rst_n = 1;
    #20;

    $display("==========================================================");
    $display("Starting SAR Controller Core Verification");
    $display("==========================================================");

    // 1. Directed Code Tests
    run_conversion(10'd0,    "Zero Input");
    run_conversion(10'd1,    "1 LSB");
    run_conversion(10'd2,    "2 LSB");
    run_conversion(10'd255,  "Quarter-Scale - 1");
    run_conversion(10'd256,  "Quarter-Scale (1/4)");
    run_conversion(10'd511,  "Half-Scale - 1");
    run_conversion(10'd512,  "Half-Scale (Mid-Code)");
    run_conversion(10'd768,  "Three-Quarter-Scale (3/4)");
    run_conversion(10'd1022, "Full-Scale - 1");
    run_conversion(10'd1023, "Full-Scale Max (0x3FF)");

    // 2. Conversion Request While Busy (Rejection Check)
    $display("--- Testing Conversion Request while Busy ---");
    tests_run++;
    target_code = 10'd350;
    @(posedge clk);
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    // Wait until midway (e.g. 4 cycles)
    repeat (4) @(posedge clk);
    // Change input voltage on the fly to simulate external activity while busy
    target_code = 10'd999;
    // Attempt invalid re-trigger
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    while (!done) @(posedge clk);
    if (result !== 10'd350) begin
      $display("[FAIL] Busy rejection test failed: result = %0d, expected 350", result);
      errors++;
    end else begin
      $display("[PASS] Request while busy safely ignored; conversion completed for original target 350");
    end
    @(posedge clk);

    // 3. Reset During Active Conversion
    $display("--- Testing Asynchronous Reset During Conversion ---");
    tests_run++;
    target_code = 10'd600;
    @(posedge clk);
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    repeat (5) @(posedge clk);
    // Assert reset midway
    rst_n = 1'b0;
    #15;
    if (busy !== 1'b0 || u_dut.state_q !== S_IDLE || dac_code !== '0) begin
      $display("[FAIL] Reset failed to return core to IDLE: busy=%b, state=%0d", busy, u_dut.state_q);
      errors++;
    end else begin
      $display("[PASS] Asynchronous reset aborted conversion and cleared core cleanly");
    end
    rst_n = 1'b1;
    #20;

    // 4. Automated Sweep across 100 Pseudo-Random Codes
    $display("--- Testing 100 Randomized Codes ---");
    for (int i = 0; i < 100; i++) begin
      logic [9:0] rnd_code;
      rnd_code = $urandom_range(0, 1023);
      run_conversion(rnd_code, $sformatf("Random Vector #%0d", i+1));
    end

    // Summary
    $display("==========================================================");
    $display("Verification Summary: %0d tests run, %0d errors", tests_run, errors);
    $display("==========================================================");

    if (errors == 0) begin
      $display("RESULT: ALL SAR CONTROLLER TESTS PASSED");
    end else begin
      $display("RESULT: TESTS FAILED WITH %0d ERRORS", errors);
    end

    $finish;
  end

endmodule
