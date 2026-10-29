# Verification Evidence & Simulation Logs

This directory contains test outputs, simulation logs, and execution evidence for the Educational 10-Bit 8-Channel SAR ADC IC.

## 1. Directory Contents & Artifacts

| File | Description | Generating Testbench / Script |
|---|---|---|
| `REGRESSION_SUMMARY.md` | Master regression test report with pass/fail matrix and execution runtimes. | `scripts/run_all_tests.py` |
| `tb_sar_controller.log` | RTL simulation log verifying SAR trial state transitions, boundary codes, reset abort, and 100 randomized vectors. | `tb/tb_sar_controller.sv` via `iverilog` |
| `tb_spi_slave.log` | SPI Mode 0 interface test log verifying CS_N framing, tri-state MISO, 8-channel address decoding, and abort detection. | `tb/tb_spi_slave.sv` via `iverilog` |
| `tb_adc_rtl.log` | End-to-end top-level RTL integration log verifying SPI-driven conversions, busy status, and latched data stability. | `tb/tb_adc_rtl.sv` via `iverilog` |
| `tb_adc_channels.log` | Multi-channel isolation test log verifying all 8 input channels in forward, reverse, and interleaved switching sequences. | `tb/tb_adc_channels.sv` via `iverilog` |
| `analog_models.log` | SPICE analogue model simulation log verifying 8:1 MUX routing, S&H tracking/hold, 10-bit DAC transfer curve, and comparator threshold decisions. | `tb/analog/analog_model_tb.cir` via LTspice |
| `adc_reference.log` | Golden Python reference model log verifying all 1024 code centers, microvolt decision boundaries, and 1000 randomized points. | `models/adc_reference.py` |
| `spi_reference.log` | Python SPI frame model log verifying 16-bit command and response word packing and unpacking. | `models/spi_reference.py` |
| `pytest_models.log` | Automated test suite log executed via pytest. | `models/test_models_pytest.py` |

---

## 2. Reproduction

To reproduce all test logs from a clean repository state:

```powershell
python scripts/run_all_tests.py
```
or via PowerShell:
```powershell
.\scripts\run_all_tests.ps1
```
or under Linux/WSL/Git Bash:
```bash
bash scripts/run_all_tests.sh
```

