//=============================================================================
// File: rtl/adc_config.sv
// Description: Global configuration parameters and package for 10-bit SAR ADC
//=============================================================================

`ifndef ADC_CONFIG_SV
`define ADC_CONFIG_SV

package adc_pkg;

  // Architecture parameters
  parameter int unsigned ADC_BITS       = 10;
  parameter int unsigned NUM_CHANNELS   = 8;
  parameter int unsigned CH_ADDR_BITS   = 3;
  parameter int unsigned VREF_MV        = 5000; // 5.0V reference in mV
  parameter int unsigned SPI_FRAME_BITS = 16;

  // SAR FSM States
  typedef enum logic [3:0] {
    S_IDLE   = 4'd0,
    S_SAMPLE = 4'd1,
    S_BIT9   = 4'd2,
    S_BIT8   = 4'd3,
    S_BIT7   = 4'd4,
    S_BIT6   = 4'd5,
    S_BIT5   = 4'd6,
    S_BIT4   = 4'd7,
    S_BIT3   = 4'd8,
    S_BIT2   = 4'd9,
    S_BIT1   = 4'd10,
    S_BIT0   = 4'd11,
    S_LATCH  = 4'd12
  } sar_state_t;

  // SPI Command bit mappings (16-bit frame)
  // MOSI: [15] START, [14] SGL_DIFF, [13:11] CH[2:0], [10] AUTO_START, [9:0] RESERVED
  parameter int MOSI_START_BIT      = 15;
  parameter int MOSI_SGL_DIFF_BIT   = 14;
  parameter int MOSI_CH_MSB         = 13;
  parameter int MOSI_CH_LSB         = 11;
  parameter int MOSI_AUTO_START_BIT = 10;

  // MISO Response bit mappings (16-bit frame)
  // MISO: [15] READY, [14] BUSY, [13] ERR, [12:10] CH_TAG[2:0], [9:0] DATA[9:0]
  parameter int MISO_READY_BIT      = 15;
  parameter int MISO_BUSY_BIT       = 14;
  parameter int MISO_ERR_BIT        = 13;
  parameter int MISO_CH_MSB         = 12;
  parameter int MISO_CH_LSB         = 10;
  parameter int MISO_DATA_MSB       = 9;
  parameter int MISO_DATA_LSB       = 0;

endpackage

`endif // ADC_CONFIG_SV

