//=============================================================================
// File: tb/tb_adc_channels.sv
// Description: Multi-Channel Cross-Talk and Channel Switching Testbench
//=============================================================================

`timescale 1ns/1ps

`include "adc_config.sv"
`include "adc_top.sv"

module tb_adc_channels;
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

  always #10 clk = ~clk;

  // 8 Channels with distinct, unique voltages
  logic [9:0] channel_voltage_map[0:7];
  logic [9:0] held_voltage;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      held_voltage <= '0;
    end else if (sample_en) begin
      held_voltage <= channel_voltage_map[channel_sel];
    end
  end

  assign cmp_out = (held_voltage >= dac_code);

  int errors = 0;
  int tests_run = 0;

  // SPI Master Transaction Task
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

  // Task to request conversion and assert result
  task automatic convert_and_verify_channel(
    input logic [2:0] ch_to_test,
    input string      phase_desc
  );
    logic [15:0] cmd_frame;
    logic [15:0] dummy_rx, rx_result;
    logic [15:0] exp_resp;
    logic [9:0]  exp_val;
    int timeout;

    tests_run++;
    exp_val = channel_voltage_map[ch_to_test];

    // Frame 1: Request
    cmd_frame = {1'b1, 1'b1, ch_to_test, 1'b1, 10'b0};
    spi_transfer(cmd_frame, dummy_rx);

    timeout = 0;
    while (!result_valid && timeout < 50) begin
      @(posedge clk);
      timeout++;
    end
    #200;

    // Frame 2: Read
    spi_transfer(16'h0000, rx_result);

    exp_resp = {1'b1, 1'b0, 1'b0, ch_to_test, exp_val};

    if (rx_result === exp_resp) begin
      $display("[PASS] %s: CH%0d returned correct code %0d (0x%03h) with matching channel tag",
               phase_desc, ch_to_test, exp_val, exp_val);
    end else begin
      $display("[FAIL] %s: CH%0d mismatch! Exp=0x%04h (CH=%0d, Code=%0d), Got=0x%04h (CH=%0d, Code=%0d)",
               phase_desc, ch_to_test, exp_resp, ch_to_test, exp_val,
               rx_result, rx_result[12:10], rx_result[9:0]);
      errors++;
    end
  endtask

  initial begin
    $dumpfile("tb_adc_channels.vcd");
    $dumpvars(0, tb_adc_channels);

    clk   = 0;
    rst_n = 0;
    sclk  = 0;
    cs_n  = 1;
    mosi  = 0;

    // Unique test voltages assigned to each channel
    channel_voltage_map[0] = 10'd100;
    channel_voltage_map[1] = 10'd220;
    channel_voltage_map[2] = 10'd350;
    channel_voltage_map[3] = 10'd480;
    channel_voltage_map[4] = 10'd610;
    channel_voltage_map[5] = 10'd740;
    channel_voltage_map[6] = 10'd870;
    channel_voltage_map[7] = 10'd1000;

    // Reset
    #40;
    rst_n = 1;
    #40;

    $display("==========================================================");
    $display("Starting 8-Channel Selection & Isolation Verification");
    $display("==========================================================");

    // 1. Forward sweep: Channels 0 through 7
    $display("\n--- Phase 1: Forward Sweep Across All 8 Channels ---");
    for (int ch = 0; ch < 8; ch++) begin
      convert_and_verify_channel(ch[2:0], "Forward Sweep");
    end

    // 2. Reverse sweep: Channels 7 down to 0
    $display("\n--- Phase 2: Reverse Sweep (Testing Channel Switching) ---");
    for (int ch = 7; ch >= 0; ch--) begin
      convert_and_verify_channel(ch[2:0], "Reverse Sweep");
    end

    // 3. Interleaved pseudo-random channel jumping (anti-crosstalk / anti-stale data)
    $display("\n--- Phase 3: Interleaved Dynamic Channel Jumping ---");
    convert_and_verify_channel(3'd3, "Interleaved Jump");
    convert_and_verify_channel(3'd0, "Interleaved Jump");
    convert_and_verify_channel(3'd6, "Interleaved Jump");
    convert_and_verify_channel(3'd2, "Interleaved Jump");
    convert_and_verify_channel(3'd5, "Interleaved Jump");
    convert_and_verify_channel(3'd1, "Interleaved Jump");
    convert_and_verify_channel(3'd7, "Interleaved Jump");
    convert_and_verify_channel(3'd4, "Interleaved Jump");

    // 4. Repeated conversions on a single channel
    $display("\n--- Phase 4: Repeated Conversions on Channel 4 ---");
    for (int rep = 0; rep < 4; rep++) begin
      convert_and_verify_channel(3'd4, $sformatf("Repeat #%0d", rep+1));
    end

    // Summary
    $display("\n==========================================================");
    $display("Channel Verification Summary: %0d tests run, %0d errors", tests_run, errors);
    $display("==========================================================");

    if (errors == 0) begin
      $display("RESULT: ALL 8 CHANNELS FULLY VERIFIED AND ISOLATED");
    end else begin
      $display("RESULT: CHANNEL VERIFICATION FAILED WITH %0d ERRORS", errors);
    end

    $finish;
  end

endmodule

