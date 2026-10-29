# SPI Protocol Specification

## 1. Electrical & Bus Properties

- **Interface standard:** SPI (Serial Peripheral Interface) Slave.
- **SPI Mode:** Mode 0 (CPOL = 0, CPHA = 0).
  - **SCLK Idle Polarity:** LOW (`CPOL = 0`).
  - **MOSI Sampling Edge:** RISING clock edge (`CPHA = 0`).
  - **MISO Shift/Update Edge:** FALLING clock edge.
  - **Chip Select (`CS_N`):** Active LOW.
  - **Tri-State (`MISO`):** High-Impedance (`Z`) whenever `CS_N = 1` (inactive).
- **Frame Size:** Fixed 16-bit word per transaction.
- **Transmission Order:** Most Significant Bit First (MSB first, bit 15 down to bit 0).

---

## 2. Command Frame Format (MOSI, 16 bits)

```text
 15     14     13   12   11      10       9   8   7   6   5   4   3   2   1   0
+-----+------+----+----+----+------------+-------------------------------------+
|START|SGL_D |  CH[2:0]     | AUTO_START |               RESERVED (0)          |
+-----+------+----+----+----+------------+-------------------------------------+
```

| Bit(s) | Name | Direction | Description |
|---|---|---|---|
| **15** | `START` | Input | Frame Start Bit. Must be `1` for a valid transaction. If `0`, frame is treated as NOP / Status Read. |
| **14** | `SGL_DIFF` | Input | Mode Selector: `1` = Single-Ended, `0` = Reserved (Differential mode extension). In this 8-channel IC, single-ended (`1`) is required. |
| **[13:11]**| `CH[2:0]` | Input | 3-bit Channel Address selecting one of eight analogue input channels ($CH0 \dots CH7$):<br>• `3'b000`: CH0<br>• `3'b001`: CH1<br>• `3'b010`: CH2<br>• `3'b011`: CH3<br>• `3'b100`: CH4<br>• `3'b101`: CH5<br>• `3'b110`: CH6<br>• `3'b111`: CH7 |
| **10** | `AUTO_START`| Input | Conversion trigger control:<br>• `1`: Immediately launch SAR conversion on the addressed channel.<br>• `0`: Set channel address without launching a new conversion. |
| **[9:0]** | `RESERVED` | Input | Reserved bits. Drive LOW (`10'b0`). Ignored by receiver. |

---

## 3. Response Frame Format (MISO, 16 bits)

```text
 15     14     13     12   11   10      9   8   7   6   5   4   3   2   1   0
+-----+------+-----+----+----+----+-------------------------------------------+
|READY| BUSY | ERR |   CH_TAG     |                  DATA[9:0]                |
+-----+------+-----+----+----+----+-------------------------------------------+
```

| Bit(s) | Name | Direction | Description |
|---|---|---|---|
| **15** | `READY` | Output | Data Valid Flag. `1` indicates that a conversion has completed since reset and `DATA[9:0]` contains valid data. |
| **14** | `BUSY` | Output | Conversion Status. `1` indicates that the SAR ADC conversion engine is currently busy converting. |
| **13** | `ERR` | Output | Error Flag. `1` if an invalid command was received or transaction was aborted prematurely. |
| **[12:10]**| `CH_TAG[2:0]` | Output | Echoed Channel Address of the conversion result contained in `DATA[9:0]`. Prevents channel confusion. |
| **[9:0]** | `DATA[9:0]` | Output | 10-bit Unsigned Digital Conversion Code ($B_9$ down to $B_0$, where $B_9$ is MSB). |

---

## 4. Operational Semantics and Conversion Timing

### 4.1 Latched vs Newly Requested Results
- In SPI Mode 0, when `CS_N` drops LOW, `MISO` drives Bit 15 immediately prior to the first rising edge of `SCLK`.
- Therefore, the data shifted out during frame $N$ represents the **currently available latched conversion result** (along with its matching channel tag `CH_TAG[2:0]` and `READY` status).
- If `AUTO_START = 1` is sent in frame $N$, the conversion starts after bit 10 is decoded.
  - The conversion completes in **11 core clock cycles**.
  - If `SCLK` is sufficiently slow relative to the internal core `clk` ($f_{\text{SCLK}} \ll f_{\text{clk}} / 11$), the new result is latched into the result register before the end of the frame.
  - In standard multi-MHz SPI operation, a clean **two-frame transaction** pattern is recommended:
    - **Frame 1 (Request):** Send Command with `START=1, AUTO_START=1, CH=X`. Receives status or previous result.
    - **Frame 2 (Collect):** Send Read/NOP frame. Returns `READY=1, CH_TAG=X, DATA=Result(X)`.

### 4.2 Reset, Abort, and Idle Behavior
- **Inactive `CS_N`:** When `CS_N = 1`, the internal SPI bit counter resets to 0. `MISO` is placed in high-impedance (`1'bz`).
- **Premature `CS_N` Deassertion:** If `CS_N` rises before all 16 bits have been clocked, the frame is aborted. No partial commands are executed, and `ERR` flag is raised for the subsequent transaction.
- **Conversion while Busy:** If an `AUTO_START` command is received while `BUSY = 1`, the existing conversion completes uninterrupted, the request is rejected, and `ERR` is set.

