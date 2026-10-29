# Behavioural Analogue Models (Verilog-A & SPICE)

## 1. Overview

This directory contains continuous-time analogue behavioural models for the 10-bit SAR ADC IC. The models are implemented in standard Verilog-A (IEEE 1800 / LRM 2.4) and accompanied by equivalent SPICE sub-circuits for simulation on platforms without native AMS co-simulation solvers.

---

## 2. Models Summary

### 2.1 Analogue Input Multiplexer (`adc_mux.va`)
- **Function:** Routes one of eight single-ended analogue input channels ($CH0 \dots CH7$) to the sampling node `mux_out` based on the 3-bit binary channel select vector `sel[2:0]`.
- **Fidelity & Parameters:**
  - `ron` = $100\,\Omega$: Finite switch on-resistance.
  - `roff` = $1\,\text{G}\Omega$: Finite switch off-isolation resistance.
  - `vth` = $2.5\,\text{V}$: Logic threshold for digital channel address lines.
- **Limitations:** Models switch conduction as a voltage-controlled resistor; does not include non-linear $V_{\text{GS}}$ switch body-effect modulation or gate-drain overlap parasitic charge injection.

### 2.2 Sample-and-Hold (`sample_hold.va`)
- **Function:** Tracks the multiplexer output when `sample_en > 2.5V` (active high) and holds the sampled voltage across a hold capacitor when `sample_en < 2.5V`.
- **Fidelity & Parameters:**
  - `c_hold` = $10\,\text{pF}$: Sampling capacitance.
  - `r_switch` = $100\,\Omega$: Serial sampling resistance ($RC = 1\,\text{ns}$ settling bandwidth).
  - `droop_r` = $1\,\text{T}\Omega$: Hold droop leakage resistance.
- **Limitations:** Does not model $kT/C$ thermal sampling noise or pedestal offset error from switch turn-off charge injection.

### 2.3 10-Bit Behavioural DAC (`dac_model.va`)
- **Function:** Computes the trial analogue feedback voltage from the 10-bit digital trial code:
  $$V_{\text{DAC}} = V_{\text{REF}} \times \frac{D_{\text{trial}}}{1024.0}$$
  where $D_{\text{trial}} = \sum_{i=0}^9 D_i 2^i \in [0, 1023]$.
- **Fidelity & Parameters:**
  - Monotonic and linear with $1\,\text{LSB} = V_{\text{REF}} / 1024 = 4.8828\,\text{mV}$.
  - `settling_tau` = $2\,\text{ns}$: First-order settling dynamic model.
- **Limitations:** Assumes perfectly matched unit capacitors/resistors. Device mismatch (DNL/INL) is modeled analytically in the Python reference framework (`models/adc_reference.py`).

### 2.4 Differential Comparator (`comparator.va`)
- **Function:** Compares the held voltage $V_{\text{held}}$ against the DAC trial voltage $V_{\text{DAC}}$:
  $$\text{cmp\_out} = \begin{cases} 5.0\,\text{V} \text{ (logic 1)}, & \text{if } V_{\text{held}} \ge V_{\text{DAC}} + V_{\text{offset}} \\ 0.0\,\text{V} \text{ (logic 0)}, & \text{if } V_{\text{held}} < V_{\text{DAC}} + V_{\text{offset}} \end{cases}$$
- **Fidelity & Parameters:**
  - `v_offset` = $0.0\,\text{V}$ (configurable input-referred offset).
  - `t_prop` = $1.0\,\text{ns}$: Propagation delay.
  - Strict equality convention: Input exactly equal to $V_{\text{DAC}}$ resolves to 1 (preserves bit trial).
- **Limitations:** Continuous-time ideal threshold; does not model regenerative latch metastability, hysteresis, or kickback noise back into the DAC/sampling capacitors.

### 2.5 Voltage Reference (`reference_model.va`)
- **Function:** Provides a stable $5.000\,\text{V}$ DC reference voltage with optional temperature drift parameter `tc1`.

