# Timing Diagrams and Cycle-Accurate Specifications

## 1. SPI Mode 0 Timing Diagram (CPOL=0, CPHA=0)

In Mode 0:
- SCLK sits at logic 0 while CS_N is HIGH.
- When CS_N goes LOW, MISO is driven out of High-Z and immediately outputs Bit 15 (`READY`).
- MOSI is sampled on every **RISING** edge of SCLK.
- MISO transitions to the next bit on every **FALLING** edge of SCLK.
- When CS_N returns HIGH, MISO returns to High-Z (`1'bz`).

```text
CS_N  \______________________________________________________________________________/
          |                                                                    |
SCLK  ____/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \________
        Edge 1  Edge 2  Edge 3                  ...                 Edge 16
          ^       ^       ^                                           ^
          |       |       |                                           |
MOSI  ---< Bit 15 | Bit 14| Bit 13>----------- ... -----------------< Bit 0  >--------
         (START)  (SGL/D) (CH2)                                      (RESERVED)
          |       |       |                                           |
MISO  ---< Bit 15 | Bit 14| Bit 13>----------- ... -----------------< Bit 0  >--------
 (Hi-Z)  (READY)  (BUSY)  (ERR)                                      (DATA[0]) (Hi-Z)
```

### 1.1 Interface Timing Parameters

| Parameter | Symbol | Min | Typ | Max | Units |
|---|---|---|---|---|---|
| SCLK Clock Period | $t_{\text{CYC}}$ | $2 \times t_{\text{clk}}$ | — | — | ns |
| SCLK High Pulse Width | $t_{\text{HI}}$ | $0.4 \times t_{\text{CYC}}$ | — | — | ns |
| SCLK Low Pulse Width | $t_{\text{LO}}$ | $0.4 \times t_{\text{CYC}}$ | — | — | ns |
| CS_N Setup to SCLK Rising | $t_{\text{SU\_CS}}$ | 10 | — | — | ns |
| CS_N Hold after SCLK Falling | $t_{\text{HD\_CS}}$ | 10 | — | — | ns |
| MOSI Data Setup to SCLK Rising | $t_{\text{SU\_DAT}}$| 5 | — | — | ns |
| MOSI Data Hold from SCLK Rising| $t_{\text{HD\_DAT}}$| 5 | — | — | ns |
| MISO Propagation Delay from SCLK Falling | $t_{\text{V\_DAT}}$ | — | 4 | 8 | ns |
| MISO Disable Time to High-Z | $t_{\text{DIS}}$ | — | 3 | 6 | ns |

---

## 2. SAR Core Conversion State Timing

```text
clk        ___/ \___/ \___/ \___/ \___/ \___/ ... ___/ \___/ \___/ \___/ \___/
State     |  IDLE   | SAMPLE| BIT_9 | BIT_8 | ... | BIT_0 | LATCH |  IDLE   |
Cycle     |    0    |   1   |   2   |   3   | ... |  11   |  12   |   13    |
start      ___/¯¯¯\__________________________________________________________
sample_en  _________|¯¯¯¯¯¯¯|________________________________________________
busy       _________|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|___________
dac_code  ---(000)--------(1000000000)---- ... -(xxxxxxxxx1)--------(000)---
cmp_out   --------------------[ Decision 9 ]- ... -[ Dec 0 ]-----------------
done       _________________________________________________|¯¯¯¯¯¯¯|________
result    --------------------------------------------------< Valid Result >-
```

### 2.1 Cycle Breakdown
- **Cycle 0:** Core is in `IDLE`. Awaits `start` pulse.
- **Cycle 1 (`SAMPLE`):** `sample_en` asserts. Front-end sampling switch connects held capacitor to selected multiplexer channel.
- **Cycle 2 (`BIT_9`):** `sample_en` de-asserts (Hold mode). Trial code sets bit 9 (`10'b10_0000_0000`). DAC settles.
- **Cycle 3 (`BIT_8`):** Bit 9 comparator decision is evaluated. Bit 9 is retained if `cmp_out == 1`, else cleared. Bit 8 is set to 1.
- ...
- **Cycle 11 (`BIT_0`):** Bit 1 decision evaluated. Bit 0 is set to 1.
- **Cycle 12 (`LATCH`):** Bit 0 decision evaluated. Full 10-bit word is written to `result_register`. `done` asserted.
- **Cycle 13 (`IDLE`):** Core returns to `IDLE` ready for next conversion. Total conversion duration: **11 clock cycles**.

