# Block Diagrams and Signal Routing

## 1. Complete System Architecture

```text
               +-------------------------------------------------------------+
               |                  Educational SAR ADC Top Level             |
               |                                                             |
   CH0 --------+-->[ MUX 8:1 ]                                               |
   CH1 --------+        |                                                    |
   CH2 --------+        | mux_out                                            |
   CH3 --------+        v                                                    |
   CH4 --------+-->[ S/H Unit ]-- V_held --(+)                               |
   CH5 --------+        ^                   |                                |
   CH6 --------+        | sample_en         v                                |
   CH7 --------+        |             [ Comparator ]<-- cmp_out              |
               |        |                   ^                |               |
               |        |                   | V_dac          |               |
               |        |             [ 10-bit DAC ]         |               |
               |        |                   ^                |               |
               |        |                   | dac_code[9:0]  v               |
               |   +----+-------------------+-----------+----+-----------+   |
               |   |                                    |                |   |
               |   |         SAR Controller & FSM       |                |   |
               |   |                                    |                |   |
               |   +----+-------------------------------+---+-----------+   |
               |        |                                   |                |
               |        | done                              | bit_ptr[3:0]   |
               |        v                                   v                |
               |   [ Result Register ]                 [ Status Logic ]      |
               |        |                                   |                |
               |        +-----------------+-----------------+                |
               |                          |                                  |
               |                          v                                  |
               |                  [ SPI Slave Core ]                         |
               |                          |                                  |
               +--------------------------+----------------------------------+
                                          |
                CS_N  <-------------------+ (Chip Select, Active Low)
                SCLK  <-------------------+ (Serial Clock, Mode 0)
                MOSI  <-------------------+ (Master Out Slave In)
                MISO  ------------------->+ (Master In Slave Out)
```

## 2. SAR Controller Finite State Machine (FSM)

```mermaid
stateDiagram-v2
    [*] --> IDLE
    IDLE --> SAMPLE : start == 1
    SAMPLE --> BIT_9 : sample_en = 0, trial B9=1
    BIT_9 --> BIT_8 : evaluate cmp_out, trial B8=1
    BIT_8 --> BIT_7 : evaluate cmp_out, trial B7=1
    BIT_7 --> BIT_6 : evaluate cmp_out, trial B6=1
    BIT_6 --> BIT_5 : evaluate cmp_out, trial B5=1
    BIT_5 --> BIT_4 : evaluate cmp_out, trial B4=1
    BIT_4 --> BIT_3 : evaluate cmp_out, trial B3=1
    BIT_3 --> BIT_2 : evaluate cmp_out, trial B2=1
    BIT_2 --> BIT_1 : evaluate cmp_out, trial B1=1
    BIT_1 --> BIT_0 : evaluate cmp_out, trial B0=1
    BIT_0 --> DONE_STATE : evaluate cmp_out, latch result
    DONE_STATE --> IDLE : done pulse, ready for next
```

## 3. Clock and Reset Domains

- **Asynchronous Global Reset (`rst_n`):** Direct asynchronous clear to all registers; active low.
- **Synchronous Core Clock (`clk`):** Drives SAR state machine, trial register, result register, and CDC logic.
- **Serial Clock (`sclk`):** Driven externally by SPI master. Samples MOSI on rising edges; shifts MISO on falling edges. Dual-rank synchronizers interface SCLK control strobes with the system `clk`.

