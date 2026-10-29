# Specification: Educational 10-Bit, 8-Channel SAR ADC IC

## 1. Scope & Objective

This document formalises the design specification for an educational mixed-signal Successive Approximation Register (SAR) Analogue-to-Digital Converter (ADC) integrated circuit. The design includes:
- A synthesizable SystemVerilog digital core (SAR state machine, trial register, result register, and SPI slave).
- Standard Verilog-A behavioural models for analogue sub-circuits (8-channel MUX, Sample-and-Hold, 10-bit capacitive/resistor-string DAC, and Comparator).
- Equivalent SPICE behavioural models verified in LTspice.
- A golden Python reference model for exact numerical and bit-accurate cross-verification.

**Functional Reference:** Microchip MCP3008 datasheet DS21295D is used as a functional guide for multi-channel SPI SAR ADCs. However, this implementation is an independent, openly documented educational IC architecture.

---

## 2. Key Electrical & Functional Parameters

| Parameter | Specification | Units / Notes |
|---|---|---|
| Architecture | Successive Approximation Register (SAR) | Binary search |
| Resolution | 10 | Bits ($N=10$) |
| Number of Channels | 8 | Single-ended ($CH0 \dots CH7$) |
| Analogue Input Range | $0.0\,\text{V}$ to $V_{\text{REF}}$ | Ground-referenced |
| Reference Voltage ($V_{\text{REF}}$) | $5.0$ (configurable) | Volts |
| Least Significant Bit ($1\,\text{LSB}$) | $V_{\text{REF}} / 1024 \approx 4.8828\,\text{mV}$ | Ideal step size |
| Quantisation Law | Truncation / Floor | $D = \min(1023, \lfloor 1024 \cdot V_{\text{IN}} / V_{\text{REF}} \rfloor)$ |
| Endpoint Convention | $V_{\text{IN}} \ge V_{\text{REF}} \implies 1023$ | Clamped to 10'h3FF |
| Conversion Latency | 11 core clock cycles | 1 sample cycle + 10 trial bit cycles |
| Digital Core Clock | 1 MHz to 50 MHz nominal | Synchronous RTL |
| Digital Output Format | 10-bit unsigned binary | Range: 0 to 1023 |
| Serial Interface | SPI Slave Mode 0 | CPOL = 0, CPHA = 0 |
| SPI Frame Length | 16 bits per transaction | Word aligned |
| Maximum SPI Clock | Up to Core Clock / 2 | Deterministic CDC |
| Supply Voltage ($V_{\text{DD}}$) | 5.0 nominal (behavioural) | Volts |

---

## 3. Quantisation & Conversion Mathematics

### 3.1 Ideal Transfer Function
For an analogue input voltage $V_{\text{IN}}$ where $0 \le V_{\text{IN}} \le V_{\text{REF}}$:
$$D = \min\left(1023, \left\lfloor 1024 \times \frac{V_{\text{IN}}}{V_{\text{REF}}} \right\rfloor\right)$$

- **Code 0:** $0.0\,\text{V} \le V_{\text{IN}} < 1\,\text{LSB}$ ($0.0\,\text{V} \le V_{\text{IN}} < 4.8828\,\text{mV}$)
- **Code $k$ ($1 \le k \le 1022$):** $k \times \text{LSB} \le V_{\text{IN}} < (k+1) \times \text{LSB}$
- **Code 1023:** $1023 \times \text{LSB} \le V_{\text{IN}} \le V_{\text{REF}}$ ($4.9951\,\text{V} \le V_{\text{IN}} \le 5.0000\,\text{mV}$)

### 3.2 DAC Trial Voltage
During SAR bit cycling, the trial register presents code $D_{\text{trial}} \in [0, 1023]$ to the DAC. The ideal DAC output voltage is:
$$V_{\text{DAC}} = V_{\text{REF}} \times \frac{D_{\text{trial}}}{1024}$$

### 3.3 Comparator Decision Function
The comparator evaluates:
$$\text{cmp\_out} = \begin{cases} 1, & \text{if } V_{\text{held}} \ge V_{\text{DAC}} \\ 0, & \text{if } V_{\text{held}} < V_{\text{DAC}} \end{cases}$$

- **Equality Behaviour:** When $V_{\text{held}} = V_{\text{DAC}}$, `cmp_out = 1`. This guarantees that an input exactly on a transition boundary retains the trial bit, matching the mathematical floor operation.

---

## 4. SAR Binary Search Algorithm

Conversion proceeds through 12 states:
1. `IDLE`: Awaiting `start` pulse. `busy = 0`.
2. `SAMPLE`: `sample_en = 1`. Input multiplexer connects selected channel to sample-and-hold capacitor. `busy = 1`.
3. `BIT_9` (MSB): Trial code set to `10'b10_0000_0000` (512). If `cmp_out == 1`, bit 9 is kept 1; else bit 9 is set to 0.
4. `BIT_8`: Trial code sets bit 8 to 1 (`{bit9, 1'b1, 8'b0}`). Comparator decision determines bit 8.
5. ...
6. `BIT_0` (LSB): Trial code sets bit 0 to 1. Comparator decision determines bit 0.
7. `LATCH`: Final 10-bit result is committed to `result_register`. `done` asserted for 1 cycle. Return to `IDLE`.

---

## 5. Module Interface Definitions

### 5.1 SAR Controller (`sar_controller.sv`)
- **Inputs:**
  - `clk` (logic): System clock.
  - `rst_n` (logic): Asynchronous active-low reset.
  - `start` (logic): 1-cycle conversion request strobe.
  - `cmp_out` (logic): Comparator decision.
- **Outputs:**
  - `sample_en` (logic): Hold/sample control (active high = sample).
  - `dac_code` (logic [9:0]): Current 10-bit trial code.
  - `busy` (logic): High during sample and conversion.
  - `done` (logic): 1-cycle result-valid strobe.
  - `result` (logic [9:0]): Latched conversion code.
  - `bit_ptr` (logic [3:0]): Current bit index (9 down to 0).

### 5.2 Result Register (`result_register.sv`)
- **Inputs:**
  - `clk`, `rst_n`
  - `latch_en` (logic): Connected to `sar_controller.done`.
  - `data_in` (logic [9:0]): Conversion result.
  - `channel_in` (logic [2:0]): Channel address of completed conversion.
- **Outputs:**
  - `data_out` (logic [9:0]): Stable conversion result.
  - `channel_out` (logic [2:0]): Channel tag of stable result.
  - `data_valid` (logic): Set upon first completed conversion after reset.

### 5.3 SPI Slave (`spi_slave.sv`)
- **Inputs:**
  - `clk`, `rst_n`: Core clock domain.
  - `sclk` (logic): SPI clock (Mode 0: idle low).
  - `cs_n` (logic): SPI chip select (active low).
  - `mosi` (logic): Master Out Slave In.
  - `adc_busy` (logic): Status from SAR core.
  - `adc_valid` (logic): Result validity from `result_register`.
  - `adc_data` (logic [9:0]): Latched result code.
  - `adc_channel` (logic [2:0]): Channel tag of result code.
- **Outputs:**
  - `miso` (logic): Master In Slave Out (tri-stated when `cs_n = 1`).
  - `conv_start` (logic): 1-cycle strobe to launch SAR conversion.
  - `conv_channel` (logic [2:0]): Requested channel address.
  - `err_flag` (logic): Protocol error indicator.

### 5.4 Top-Level (`adc_top.sv`)
Integrates the SPI slave, SAR controller, trial register, result register, and clock-domain synchronization. Exposes analogue behavioural control pins (`sample_en`, `channel_sel[2:0]`, `dac_code[9:0]`, `cmp_out`) alongside SPI and system pins.

