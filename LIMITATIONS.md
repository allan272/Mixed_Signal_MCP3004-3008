# Project Limitations and Scope Boundaries

## 1. Classification & Educational Boundary

This project is classified as an **Educational Mixed-Signal IC Design and Simulation Prototype**.

It provides a transparent, modular architecture demonstrating how an 8-channel Successive Approximation Register (SAR) ADC functions from mathematical principle to SystemVerilog RTL, behavioural analogue modelling, and SPI communications.

### What This Project IS:
- A verified, synthesizable SystemVerilog RTL implementation of a 10-bit SAR conversion engine and SPI Mode 0 slave interface.
- Standard Verilog-A behavioural descriptions of the analogue front-end and conversion loop.
- A functional SPICE sub-circuit macro-model suite verified using LTspice.
- A golden Python numerical reference model verifying ideal and non-ideal quantization across all 1024 digital codes and boundary transitions.
- An automated, reproducible testbench and verification suite.

### What This Project IS NOT:
- **Not a transistor-level integrated circuit:** There are no transistor netlists (MOSFETs, bias currents, differential pairs, cascade mirrors), layout geometry (GDSII/OASIS), or DRC/LVS decks.
- **Not fabrication-ready:** This design cannot be submitted directly to a silicon foundry without transistor-level schematic capture, sizing, biasing, layout, and post-layout verification in a specific Process Design Kit (PDK).
- **Not an exact silicon replica of the Microchip MCP3008:** The Microchip MCP3008 is used solely as a functional benchmark for multi-channel SPI SAR ADCs. The internal circuitry and proprietary details of the commercial product are neither reverse-engineered nor copied.
- **Not a unified mixed-signal co-simulation:** Due to the absence of an open-source tool capable of simultaneous Verilog-A and SystemVerilog co-simulation on this host (such as Cadence AMS Designer or Synopsys VCS-AMS), digital and analogue domains are simulated via validated, independent, decoupled testbenches connected via an independent golden Python reference harness.

---

## 2. Toolchain Limitations on Windows Host

1. **Verilog-A Simulation:**
   - Icarus Verilog does not interpret Verilog-A continuous-time equations (`@cross`, `V(a,b) <+ ...`).
   - OpenVAF is not installed in the host environment.
   - *Impact:* Verilog-A modules (`analog/*.va`) are provided as standards-compliant reference code for EDA environments with Verilog-A/AMS compilers. Functional analogue verification on this platform is executed through equivalent SPICE netlists (`.cir`) in LTspice and behavioural verification in Python.
2. **Linting:**
   - Verilator is not installed.
   - *Impact:* RTL code quality is verified using strict Icarus Verilog flags (`-Wall -g2012`), SystemVerilog assertions, and extensive testbench assertions.

---

## 3. Physical Non-Idealities Not Included in Initial Models

1. **Thermal and Flicker Noise:**
   - The primary models assume zero thermal noise ($kT/C$) and zero 1/f noise.
2. **Comparator Slew Rate and Metastability:**
   - The comparator model uses an ideal continuous-time step decision. Finite gain, propagation delay, kickback noise, and metastability resolving times are omitted in the baseline models.
3. **Capacitive/Resistor DAC Mismatch:**
   - Baseline DAC is perfectly monotonic with zero Integral Non-Linearity (INL) and zero Differential Non-Linearity (DNL). Mismatch is modeled as an analytical extension in the Python reference model.
4. **Finite Switch On-Resistance ($R_{\text{ON}}$) and Charge Injection:**
   - The analogue multiplexer and sampling switch model an ideal track/hold function. Charge injection and clock feedthrough from switch gate transistors are excluded.

---

## 4. Path to Silicon: Recommended Next Steps

To advance this educational model toward a tapeout-ready physical IC:
1. **PDK Selection:** Select a supported open-source PDK (e.g., SkyWater SKY130 or IHP SG13G2) or commercial foundry PDK.
2. **Transistor-Level Design:**
   - Design a dynamic latched comparator (e.g., StrongARM latch with pre-amplifier).
   - Design a binary-weighted capacitive DAC (CDAC) with unit capacitor arrays and common-centroid layout.
   - Design bootstrapped transmission gates for the analogue MUX and sampling switch to maintain high linearity across the $0\,\text{V}$ to $V_{\text{REF}}$ range.
   - Design an on-chip bandgap reference and buffer.
3. **Physical Synthesis & P&R:**
   - Synthesize the SystemVerilog RTL using OpenROAD / Yosys or commercial synthesis tools.
   - Perform automated placement and routing (P&R), clock tree synthesis (CTS), and timing closure.
4. **Post-Layout Extraction & Co-simulation:**
   - Extract parasitic capacitances and resistances (PEX).
   - Run full mixed-signal transistor-level transient simulations across Process, Voltage, and Temperature (PVT) corners.

