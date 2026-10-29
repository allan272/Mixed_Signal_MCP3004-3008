//=============================================================================
// File: rtl/sar_register.sv
// Description: Successive Approximation Trial & Result Register
//=============================================================================

`ifndef SAR_REGISTER_SV
`define SAR_REGISTER_SV

`include "adc_config.sv"

module sar_register #(
  parameter int unsigned ADC_BITS = adc_pkg::ADC_BITS
) (
  input  logic                    clk,
  input  logic                    rst_n,
  input  logic                    clear,        // Clear all bits to zero
  input  logic                    trial_en,     // Assert new trial bit to 1
  input  logic [3:0]              trial_idx,    // Index of bit to trial
  input  logic                    eval_en,      // Commit or discard evaluated bit
  input  logic [3:0]              eval_idx,     // Index of bit being evaluated
  input  logic                    cmp_decision, // 1 = keep bit, 0 = clear bit
  output logic [ADC_BITS-1:0]     dac_code,     // Trial code driving the DAC
  output logic [ADC_BITS-1:0]     sar_result    // Current resolved bits
);

  logic [ADC_BITS-1:0] reg_q;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      reg_q <= '0;
    end else if (clear) begin
      reg_q <= '0;
    end else begin
      // Evaluate previous trial bit
      if (eval_en && (eval_idx < ADC_BITS)) begin
        reg_q[eval_idx] <= cmp_decision;
      end
      // Set new trial bit to 1
      if (trial_en && (trial_idx < ADC_BITS)) begin
        reg_q[trial_idx] <= 1'b1;
      end
    end
  end

  assign dac_code   = reg_q;
  assign sar_result = reg_q;

endmodule

`endif // SAR_REGISTER_SV
