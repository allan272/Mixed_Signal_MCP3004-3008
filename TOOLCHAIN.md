# Toolchain Discovery and Environment Report

This report documents the software tools discovered in the execution environment, capability checks performed, compatibility issues identified, and the selected simulation workflow.

## 1. Discovered Tools and Status

| Tool | Discovered Location | Version | Status / Capability |
|---|---|---|---|
| **Icarus Verilog (`iverilog`)** | `C:\iverilog\bin\iverilog.exe` | `12.0 (devel) (s20150603-1539-g2693dd32b)` | **Available & Verified**. Supports IEEE 1800-2012 SystemVerilog (`-g2012`). |
| **VVP Runtime (`vvp`)** | `C:\iverilog\bin\vvp.exe` | `12.0 (devel)` | **Available & Verified**. Executes compiled simulation nets and generates VCD traces. |
| **GTKWave (`gtkwave`)** | `C:\iverilog\gtkwave\bin\gtkwave.exe` | GTKWave v3.3.100 | **Available**. Waveform viewer for `.vcd` dumps. |
| **LTspice (`LTspice.exe`)** | `C:\Users\HP\AppData\Local\Programs\ADI\LTspice\LTspice.exe` | `26.0.2` | **Available & Verified**. Supports SPICE circuit simulation in batch mode (`-b -ascii`). |
| **Python 3 (`python`)** | `C:\Users\HP\AppData\Local\Programs\Python\Python312\python.exe` | `3.12.10` | **Available & Verified**. Includes `numpy`, `scipy`, `matplotlib`, `pytest`, `pandas`, `pypdf`. |
| **Git (`git`)** | `C:\Program Files\Git\cmd\git.exe` | Git for Windows | **Available**. Includes Bash shell at `C:\Program Files\Git\bin\bash.exe`. |
| **GNU Make (`make`)** | Not in Windows system PATH | N/A | **Simulated / Wrapped via Python & PowerShell**. Makefile also provided for POSIX environments. |
| **Verilator (`verilator`)** | Not installed | N/A | **Unavailable**. RTL linting handled by `iverilog -Wall` syntax/semantic checks. |
| **ngspice (`ngspice`)** | Not installed | N/A | **Unavailable**. Standalone SPICE simulations execute via batch LTspice. |
| **OpenVAF / Verilog-A Co-simulator** | Not installed | N/A | **Unavailable**. Verilog-A source files are authored per standard IEEE 1800/LRM 2.4, but live mixed-signal co-simulation is not directly executable without an AMS solver. |

---

## 2. Capability Verification Evidence

### 2.1 Icarus Verilog Compilation & Simulation
- Command executed:
  ```powershell
  iverilog -g2012 -o test.vvp test.sv
  vvp test.vvp
  ```
- Result: Successfully compiled and executed SystemVerilog 2012 constructs.

### 2.2 SPICE Analogue Simulation (Batch Mode)
- Command executed:
  ```powershell
  & "C:\Users\HP\AppData\Local\Programs\ADI\LTspice\LTspice.exe" -b -ascii test_rc.cir
  ```
- Result: Successfully executed transient analysis without interactive GUI prompts, generating ASCII format `.raw` and `.log` outputs.

### 2.3 Python Mathematical & Reference Harness
- Command executed:
  ```powershell
  python -c "import numpy, scipy, matplotlib, pytest; print('OK')"
  ```
- Result: Verified all mathematical, plotting, and verification libraries.

---

## 3. Toolchain Limitations and Mitigation Strategy

In accordance with Section 4 and Section 6 of the Project Specification:
1. **Verilog-A Mixed-Signal Limitations:**
   Neither Icarus Verilog nor LTspice natively supports unified Verilog-A/SystemVerilog co-simulation.
   - *Mitigation:* We author authentic, standards-compliant Verilog-A behavioural modules (`.va`) for the analogue blocks (multiplexer, sample-and-hold, DAC, comparator, and reference).
   - In parallel, we provide SPICE behavioral macro-models (`.cir`) executable by LTspice.
   - We test the digital RTL in Icarus Verilog.
   - We implement a golden Python mixed-signal reference model (`models/adc_reference.py`) that models continuous analogue voltages, DAC quantization, sampling error, and digital binary search to cross-verify all 1024 output codes and boundary conditions.
2. **Make Tooling on Windows:**
   Native `make` is absent from Windows PATH.
   - *Mitigation:* In addition to a standard POSIX `Makefile`, we provide portable Python runner scripts (`scripts/run_all_tests.py`) and PowerShell scripts (`scripts/*.ps1`) that execute seamlessly on this host.

---

## 4. Execution Commands Quick Reference

### RTL Simulation (via Icarus Verilog):
```powershell
$env:PATH = "C:\iverilog\bin;$env:PATH"
iverilog -g2012 -o tb_sar_controller.vvp -I rtl rtl/sar_controller.sv rtl/sar_register.sv tb/tb_sar_controller.sv
vvp tb_sar_controller.vvp
```

### SPICE Analogue Simulation (via LTspice Batch):
```powershell
& "C:\Users\HP\AppData\Local\Programs\ADI\LTspice\LTspice.exe" -b -ascii tb\analog\analog_model_tb.cir
```

### Python Verification Suite:
```powershell
python -m pytest models/ -v
python models/adc_reference.py
```

