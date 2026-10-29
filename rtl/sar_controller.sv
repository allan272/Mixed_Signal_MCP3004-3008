//=============================================================================
// File: rtl/sar_controller.sv
// Description: Successive Approximation Register (SAR) 10-bit FSM Controller
//=============================================================================

`ifndef SAR_CONTROLLER_SV
`define SAR_CONTROLLER_SV

`include "adc_config.sv"
`include "sar_register.sv"

module sar_controller #(
  parameter int unsigned ADC_BITS = adc_pkg::ADC_BITS
) (
  input  logic                    clk,
  input  logic                    rst_n,
  input  logic                    start,        // 1-cycle conversion request
  input  logic                    cmp_out,      // 1 if V_held >= V_dac, 0 if <
  output logic                    sample_en,    // S&H track (1) / hold (0)
  output logic [ADC_BITS-1:0]     dac_code,     // Current DAC trial code
  output logic                    busy,         // Conversion in progress
  output logic                    done,         // 1-cycle conversion valid pulse
  output logic [ADC_BITS-1:0]     result,       // Latched 10-bit conversion code
  output logic [3:0]              bit_ptr       // Bit index currently under trial
);

  typedef logic [3:0] sar_state_t;
  localparam sar_state_t S_IDLE   = 4'd0;
  localparam sar_state_t S_SAMPLE = 4'd1;
  localparam sar_state_t S_BIT9   = 4'd2;
  localparam sar_state_t S_BIT8   = 4'd3;
  localparam sar_state_t S_BIT7   = 4'd4;
  localparam sar_state_t S_BIT6   = 4'd5;
  localparam sar_state_t S_BIT5   = 4'd6;
  localparam sar_state_t S_BIT4   = 4'd7;
  localparam sar_state_t S_BIT3   = 4'd8;
  localparam sar_state_t S_BIT2   = 4'd9;
  localparam sar_state_t S_BIT1   = 4'd10;
  localparam sar_state_t S_BIT0   = 4'd11;
  localparam sar_state_t S_LATCH  = 4'd12;

  sar_state_t state_q, state_d;

  // Control signals to sar_register
  logic clear_reg;
  logic trial_en;
  logic [3:0] trial_idx;
  logic eval_en;
  logic [3:0] eval_idx;
  logic [ADC_BITS-1:0] sar_reg_dac;
  logic [ADC_BITS-1:0] sar_reg_result;
  logic [ADC_BITS-1:0] latched_result_q;

  // Instantiate trial register
  sar_register u_sar_reg (
    .clk          (clk),
    .rst_n        (rst_n),
    .clear        (clear_reg),
    .trial_en     (trial_en),
    .trial_idx    (trial_idx),
    .eval_en      (eval_en),
    .eval_idx     (eval_idx),
    .cmp_decision (cmp_out),
    .dac_code     (sar_reg_dac),
    .sar_result   (sar_reg_result)
  );

  assign dac_code = sar_reg_dac;
  assign result   = latched_result_q;

  // FSM State Register & Output Latching
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state_q          <= S_IDLE;
      latched_result_q <= '0;
    end else begin
      state_q <= state_d;
      // When leaving S_BIT0 for S_LATCH, latch the final 10-bit resolved result
      if (state_q == S_BIT0) begin
        latched_result_q <= {sar_reg_result[9:1], cmp_out};
      end
    end
  end

  // Next-State and Output Combinational Logic
  always_comb begin
    state_d    = state_q;
    clear_reg  = 1'b0;
    trial_en   = 1'b0;
    trial_idx  = 4'd0;
    eval_en    = 1'b0;
    eval_idx   = 4'd0;
    sample_en  = 1'b0;
    busy       = 1'b1;
    done       = 1'b0;
    bit_ptr    = 4'd0;

    case (state_q)
      S_IDLE: begin
        busy = 1'b0;
        if (start) begin
          clear_reg = 1'b1;
          state_d   = S_SAMPLE;
        end
      end

      S_SAMPLE: begin
        sample_en = 1'b1;
        // At the end of sample cycle, set MSB (bit 9) trial bit
        trial_en  = 1'b1;
        trial_idx = 4'd9;
        state_d   = S_BIT9;
      end

      S_BIT9: begin
        bit_ptr   = 4'd9;
        eval_en   = 1'b1;
        eval_idx  = 4'd9;
        trial_en  = 1'b1;
        trial_idx = 4'd8;
        state_d   = S_BIT8;
      end

      S_BIT8: begin
        bit_ptr   = 4'd8;
        eval_en   = 1'b1;
        eval_idx  = 4'd8;
        trial_en  = 1'b1;
        trial_idx = 4'd7;
        state_d   = S_BIT7;
      end

      S_BIT7: begin
        bit_ptr   = 4'd7;
        eval_en   = 1'b1;
        eval_idx  = 4'd7;
        trial_en  = 1'b1;
        trial_idx = 4'd6;
        state_d   = S_BIT6;
      end

      S_BIT6: begin
        bit_ptr   = 4'd6;
        eval_en   = 1'b1;
        eval_idx  = 4'd6;
        trial_en  = 1'b1;
        trial_idx = 4'd5;
        state_d   = S_BIT5;
      end

      S_BIT5: begin
        bit_ptr   = 4'd5;
        eval_en   = 1'b1;
        eval_idx  = 4'd5;
        trial_en  = 1'b1;
        trial_idx = 4'd4;
        state_d   = S_BIT4;
      end

      S_BIT4: begin
        bit_ptr   = 4'd4;
        eval_en   = 1'b1;
        eval_idx  = 4'd4;
        trial_en  = 1'b1;
        trial_idx = 4'd3;
        state_d   = S_BIT3;
      end

      S_BIT3: begin
        bit_ptr   = 4'd3;
        eval_en   = 1'b1;
        eval_idx  = 4'd3;
        trial_en  = 1'b1;
        trial_idx = 4'd2;
        state_d   = S_BIT2;
      end

      S_BIT2: begin
        bit_ptr   = 4'd2;
        eval_en   = 1'b1;
        eval_idx  = 4'd2;
        trial_en  = 1'b1;
        trial_idx = 4'd1;
        state_d   = S_BIT1;
      end

      S_BIT1: begin
        bit_ptr   = 4'd1;
        eval_en   = 1'b1;
        eval_idx  = 4'd1;
        trial_en  = 1'b1;
        trial_idx = 4'd0;
        state_d   = S_BIT0;
      end

      S_BIT0: begin
        bit_ptr  = 4'd0;
        eval_en  = 1'b1;
        eval_idx = 4'd0;
        state_d  = S_LATCH;
      end

      S_LATCH: begin
        done    = 1'b1;
        state_d = S_IDLE;
      end

      default: begin
        state_d = S_IDLE;
      end
    endcase
  end

endmodule

`endif // SAR_CONTROLLER_SV
