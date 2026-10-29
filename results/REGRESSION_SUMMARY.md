# Regression Test Execution Summary

- **Execution Date:** 2026-10-29 20:35:35
- **Total Test Suites:** 8
- **Passed:** 8
- **Failed:** 0
- **Total Duration:** 2.64s

| Suite Name | Test Category | Status | Runtime | Log File |
|---|---|---|---|---|
| **SAR Controller Core** | RTL (iverilog) | `PASSED` | 0.10s | [`results/tb_sar_controller.log`](results/tb_sar_controller.log) |
| **SPI Slave Interface** | RTL (iverilog) | `PASSED` | 0.09s | [`results/tb_spi_slave.log`](results/tb_spi_slave.log) |
| **Top-Level RTL Integration** | RTL (iverilog) | `PASSED` | 0.10s | [`results/tb_adc_rtl.log`](results/tb_adc_rtl.log) |
| **8-Channel Selection & Isolation** | RTL (iverilog) | `PASSED` | 0.12s | [`results/tb_adc_channels.log`](results/tb_adc_channels.log) |
| **Analogue Behavioural Models** | SPICE / LTspice | `PASSED` | 0.17s | [`results/analog_models.log`](results/analog_models.log) |
| **Golden SAR ADC Reference Model** | Python Model | `PASSED` | 0.51s | [`results/adc_reference.log`](results/adc_reference.log) |
| **Golden SPI Protocol Reference Model** | Python Model | `PASSED` | 0.06s | [`results/spi_reference.log`](results/spi_reference.log) |
| **Pytest Suite (Exhaustive & Parameterized)** | Pytest | `PASSED` | 1.46s | [`results/pytest_models.log`](results/pytest_models.log) |

## Test Coverage Summary

1. **SAR Controller:** Verified 100% of trial sequence states, reset abort, busy request rejection, and 100 random code vectors.
2. **SPI Interface:** Mode 0 CPOL=0/CPHA=0 verified, active-low CS_N, tri-state MISO, all 8 channel decodes, premature frame abort detection, and back-to-back framing.
3. **System Integration:** End-to-end conversions requested over SPI and results read back with matching channel tags and bit-exact codes.
4. **Multi-Channel Isolation:** Forward sweep, reverse sweep, interleaved pseudo-random hopping, and repeat conversions across all 8 channels.
5. **Analogue Models:** 8:1 MUX routing, S&H acquisition/hold settling, 10-bit DAC transfer curve, and comparator threshold decisions verified in LTspice.
6. **Reference Models:** Exhaustive test of all 1024 codes, microvolt boundary thresholds, clamping endpoints, and randomized vectors.
