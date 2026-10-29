//=============================================================================
// File: tb/tb_spi_slave.sv
// Description: Testbench for SPI Slave Interface (Mode 0, 16-bit framing)
//=============================================================================

`timescale 1ns/1ps

`include "adc_config.sv"
`include "spi_slave.sv"

module tb_spi_slave;
  import adc_pkg::*;

  logic        clk;
  logic        rst_n;
  logic        sclk;
  logic        cs_n;
  logic        mosi;
  wire         miso;

  logic        adc_busy;
  logic        adc_valid;
  logic [9:0]  adc_data;
  logic [2:0]  adc_channel;
  logic        conv_start;
  logic [2:0]  conv_channel;
  logic        err_flag;

  // Instantiate SPI Slave DUT
  spi_slave u_dut (
    .clk          (clk),
    .rst_n        (rst_n),
    .sclk         (sclk),
    .cs_n         (cs_n),
    .mosi         (mosi),
    .miso         (miso),
    .adc_busy     (adc_busy),
    .adc_valid    (adc_valid),
    .adc_data     (adc_data),
    .adc_channel  (adc_channel),
    .conv_start   (conv_start),
    .conv_channel (conv_channel),
    .err_flag     (err_flag)
  );

  // Core clock: 50 MHz (20ns period)
  always #10 clk = ~clk;

  int errors = 0;
  int tests_run = 0;

  // SPI Master Transaction Task (Mode 0: CPOL=0, CPHA=0)
  // SCLK period: 100ns (10 MHz)
  task automatic spi_transfer(
    input  logic [15:0] tx_frame,
    output logic [15:0] rx_frame
  );
    rx_frame = 16'h0000;
    sclk     = 1'b0;
    mosi     = 1'b0;
    #50;

    // CS_N active low
    cs_n = 1'b0;
    #25; // Setup time before first rising SCLK

    // Bit 15 is sampled on first rising edge; MISO bit 15 is already driven
    for (int i = 15; i >= 0; i--) begin
      mosi = tx_frame[i];
      #25;
      sclk = 1'b1; // Rising edge: slave samples MOSI, master samples MISO
      rx_frame[i] = miso;
      #50;
      sclk = 1'b0; // Falling edge: slave shifts out next MISO bit
      #25;
    end

    #25;
    cs_n = 1'b1; // De-assert CS_N
    mosi = 1'b0;
    #50;
  endtask

  // Task for premature abort (fewer than 16 bits)
  task automatic spi_transfer_abort(
    input logic [7:0] tx_bytes
  );
    sclk = 1'b0;
    mosi = 1'b0;
    #50;
    cs_n = 1'b0;
    #25;
    for (int i = 7; i >= 0; i--) begin
      mosi = tx_bytes[i];
      #25;
      sclk = 1'b1;
      #50;
      sclk = 1'b0;
      #25;
    end
    #20;
    cs_n = 1'b1; // Premature de-assertion after only 8 bits
    #50;
  endtask

  initial begin
    $dumpfile("tb_spi_slave.vcd");
    $dumpvars(0, tb_spi_slave);

    clk         = 0;
    rst_n       = 0;
    sclk        = 0;
    cs_n        = 1;
    mosi        = 0;
    adc_busy    = 0;
    adc_valid   = 0;
    adc_data    = 10'd0;
    adc_channel = 3'd0;

    // Reset sequence
    #40;
    rst_n = 1;
    #40;

    $display("==========================================================");
    $display("Starting SPI Slave Interface Verification (Mode 0)");
    $display("==========================================================");

    // 1. Check Tri-state on MISO when CS_N is HIGH
    tests_run++;
    if (miso !== 1'bz) begin
      $display("[FAIL] MISO is not Hi-Z when CS_N = 1! Got %b", miso);
      errors++;
    end else begin
      $display("[PASS] MISO verified in High-Impedance (Hi-Z) when CS_N = 1");
    end

    // 2. Transmit valid command for Channel 3 with AUTO_START
    $display("--- Test Case 2: Conversion Request for Channel 3 ---");
    tests_run++;
    fork
      begin
        logic [15:0] rx_resp;
        // START=1, SGL=1, CH=3'b011, AUTO_START=1, PADDING=0 -> 16'b1101_1100_0000_0000 = 0xDC00
        spi_transfer(16'hDC00, rx_resp);
      end
      begin
        // Monitor conv_start pulse on clk domain
        int timeout;
        timeout = 0;
        while (!conv_start && timeout < 50) begin
          @(posedge clk);
          timeout++;
        end
        if (conv_start && conv_channel === 3'd3) begin
          $display("[PASS] conv_start successfully pulsed in clk domain with conv_channel = 3");
        end else begin
          $display("[FAIL] Failed to observe conv_start pulse for channel 3");
          errors++;
        end
      end
    join

    // 3. Response Readout Verification
    $display("--- Test Case 3: Readout Response Verification ---");
    tests_run++;
    // Simulate completed ADC result
    adc_valid   = 1'b1;
    adc_channel = 3'd3;
    adc_data    = 10'h2A5; // 677 decimal
    #100;

    begin
      logic [15:0] rx_resp;
      logic [15:0] exp_resp;
      // Expected MISO: [15]=1 (READY), [14]=0 (BUSY), [13]=0 (ERR), [12:10]=3 (CH), [9:0]=10'h2A5
      // {1'b1, 1'b0, 1'b0, 3'b011, 10'b10_1010_0101} = 16'b1000_1110_1010_0101 = 16'h8EA5
      exp_resp = {1'b1, 1'b0, 1'b0, 3'd3, 10'h2A5};
      spi_transfer(16'h0000, rx_resp); // NOP Read frame
      if (rx_resp === exp_resp) begin
        $display("[PASS] Response frame matched: 0x%04h (READY=1, CH=3, DATA=0x2A5)", rx_resp);
      end else begin
        $display("[FAIL] Response frame mismatch! Got 0x%04h, Expected 0x%04h", rx_resp, exp_resp);
        errors++;
      end
    end

    // 4. Test all 8 Channel Addresses
    $display("--- Test Case 4: Verify Command Framing for All 8 Channels ---");
    for (int ch = 0; ch < 8; ch++) begin
      logic [15:0] cmd_frame;
      logic [15:0] dummy_rx;
      tests_run++;
      cmd_frame = {1'b1, 1'b1, ch[2:0], 1'b1, 10'b0};
      fork
        spi_transfer(cmd_frame, dummy_rx);
        begin
          while (!conv_start) @(posedge clk);
          if (conv_channel === ch[2:0]) begin
            $display("[PASS] Channel %0d address correctly decoded by SPI slave", ch);
          end else begin
            $display("[FAIL] Expected channel %0d, decoded %0d", ch, conv_channel);
            errors++;
          end
        end
      join
    end

    // 5. Malformed Frame Test (Premature CS_N Abort)
    $display("--- Test Case 5: Premature Frame Abort Handling ---");
    tests_run++;
    spi_transfer_abort(8'hFF);
    #100;
    begin
      logic [15:0] rx_resp;
      spi_transfer(16'h0000, rx_resp);
      // Bit 13 should indicate ERR flag
      if (rx_resp[MISO_ERR_BIT] === 1'b1 || err_flag === 1'b1) begin
        $display("[PASS] Premature CS_N abort correctly detected and ERR flag reported (response 0x%04h)", rx_resp);
      end else begin
        $display("[FAIL] Abort failed to raise ERR flag! Got response 0x%04h", rx_resp);
        errors++;
      end
    end

    // 6. Back-to-Back Consecutive Transactions
    $display("--- Test Case 6: Back-to-Back Transactions ---");
    tests_run++;
    begin
      logic [15:0] rx1, rx2;
      adc_channel = 3'd7;
      adc_data    = 10'h3FF; // Full scale
      spi_transfer(16'h0000, rx1);
      // Minimal CS_N high interval
      #20;
      spi_transfer(16'h0000, rx2);
      if (rx1[9:0] === 10'h3FF && rx2[9:0] === 10'h3FF) begin
        $display("[PASS] Back-to-back SPI transactions successful without framing drift");
      end else begin
        $display("[FAIL] Back-to-back transaction failed: rx1=0x%04h, rx2=0x%04h", rx1, rx2);
        errors++;
      end
    end

    // Summary
    $display("==========================================================");
    $display("Verification Summary: %0d tests run, %0d errors", tests_run, errors);
    $display("==========================================================");

    if (errors == 0) begin
      $display("RESULT: ALL SPI SLAVE TESTS PASSED");
    end else begin
      $display("RESULT: TESTS FAILED WITH %0d ERRORS", errors);
    end

    $finish;
  end

endmodule
