//=============================================================================
// File: rtl/result_register.sv
// Description: Conversion Result Holding Register with Channel Tag & Validity
//=============================================================================

`ifndef RESULT_REGISTER_SV
`define RESULT_REGISTER_SV

`include "adc_config.sv"

module result_register #(
  parameter int unsigned ADC_BITS     = adc_pkg::ADC_BITS,
  parameter int unsigned CH_ADDR_BITS = adc_pkg::CH_ADDR_BITS
) (
  input  logic                    clk,
  input  logic                    rst_n,
  input  logic                    latch_en,    // Connected to sar_controller done
  input  logic [ADC_BITS-1:0]     data_in,     // Resolved 10-bit conversion code
  input  logic [CH_ADDR_BITS-1:0] channel_in,  // Channel of completed conversion
  output logic [ADC_BITS-1:0]     data_out,    // Stable latched output data
  output logic [CH_ADDR_BITS-1:0] channel_out, // Echoed channel address
  output logic                    data_valid   // High once a valid result is stored
);

  logic [ADC_BITS-1:0]     data_q;
  logic [CH_ADDR_BITS-1:0] channel_q;
  logic                    valid_q;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_q     <= '0;
      channel_q  <= '0;
      valid_q    <= 1'b0;
    end else if (latch_en) begin
      data_q     <= data_in;
      channel_q  <= channel_in;
      valid_q    <= 1'b1;
    end
  end

  assign data_out    = data_q;
  assign channel_out = channel_q;
  assign data_valid  = valid_q;

endmodule

`endif // RESULT_REGISTER_SV

