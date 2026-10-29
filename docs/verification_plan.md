# Verification Plan and Test Strategy

## 1. Overview and Objectives

The verification strategy guarantees that:
1. The digital RTL (SAR controller, register, result register, and SPI slave) is 100% compliant with the functional specification.
2. The analogue behavioural models accurately reflect the physical transfer functions of their blocks.
3. System integration between digital control, channel selection, and data readout is proven end-to-end.
4. An independent Python reference model verifies every digital output code (0 to 1023) and voltage boundary conditions.

---

## 2. Test Suites and Scopes

```mermaid
flowchart TD
    subgraph Test Suite Breakdown
        T1["tb_sar_controller.sv<br>(SAR Core Verification)"]
        T2["tb_spi_slave.sv<br>(SPI Protocol & Framing)"]
        T3["tb_adc_rtl.sv<br>(Integrated Digital Top)"]
        T4["tb_adc_channels.sv<br>(8-Channel Verification)"]
        T5["analog_model_tb.cir<br>(LTspice Analogue Models)"]
        T6["adc_reference.py<br>(Python Golden & Code Sweeps)"]
    end

    T1 --> RPT["Automated Results & Summary Logs"]
    T2 --> RPT
    T3 --> RPT
    T4 --> RPT
    T5 --> RPT
    T6 --> RPT
```

---

## 3. Detailed Test Matrix

| Test Suite | Module Under Test | Key Test Cases | Pass/Fail Criteria |
|---|---|---|---|
| **`tb_sar_controller`** | `sar_controller.sv` | • Zero input ($D=0$)<br>• 1 LSB ($D=1$)<br>• Quarter-scale ($D=256$)<br>• Half-scale ($D=512$)<br>• Three-quarter-scale ($D=768$)<br>• Full-scale ($D=1023$)<br>• Transition threshold voltages<br>• Asynchronous reset during conversion<br>• Request while busy rejection<br>• Exact 11-cycle timing | All 10-bit output codes match golden reference; state machine does not lock up; busy/done strobes assert correctly. |
| **`tb_spi_slave`** | `spi_slave.sv` | • Mode 0 CPOL=0, CPHA=0 timing<br>• Active LOW CS_N assertion<br>• Tri-state MISO when CS_N=1<br>• 16-bit command decoding (Start bit, Channel address, Auto-start)<br>• Invalid command rejection<br>• Premature CS_N deassertion (frame abort)<br>• Back-to-back transactions | Transmitted MISO frame matches expected bits; error flag asserts on malformed frames; channel tag matches. |
| **`tb_adc_rtl`** | `adc_top.sv` | • Full digital top-level integration<br>• SPI-driven conversions with behavioural comparator feedback<br>• Latched result stability across multiple transactions | Conversion requests over SPI complete and return accurate codes. |
| **`tb_adc_channels`** | `adc_top.sv` | • Channels CH0 through CH7 tested with distinct voltages<br>• Dynamic channel switching between successive conversions<br>• Verify no channel crosstalk or stale data returned | Each channel returns only its assigned conversion value. |
| **`analog_model_tb`** | `tb/analog/*.cir` | • 8:1 MUX address routing<br>• S&H track and hold settling<br>• 10-bit DAC transfer curve and monotonicity<br>• Comparator switching across $V_{\text{DAC}} \pm 1\,\text{mV}$ | SPICE node voltages match theoretical calculations within 0.1% tolerance. |
| **`adc_reference.py`** | `models/adc_reference.py` | • Exhaustive test of all 1024 codes<br>• Quantization threshold boundaries<br>• Reproducible pseudo-random inputs ($N=1000$, fixed seed 42)<br>• Configurable non-idealities (offset, gain error, noise) | 0 bit errors against theoretical transfer function $D = \min(1023, \lfloor 1024 \cdot V_{\text{IN}} / V_{\text{REF}} \rfloor)$. |

