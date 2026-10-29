#!/usr/bin/env python3
"""
=============================================================================
File: models/spi_reference.py
Description: Golden SPI Mode 0 Command & Response Frame Reference Model
16-Bit Frame Specification:
MOSI: [15] START, [14] SGL_DIFF, [13:11] CH[2:0], [10] AUTO_START, [9:0] RESERVED
MISO: [15] READY, [14] BUSY, [13] ERR, [12:10] CH_TAG[2:0], [9:0] DATA[9:0]
=============================================================================
"""

import sys

def pack_command(channel: int, start: bool = True, single_ended: bool = True, auto_start: bool = True) -> int:
    """
    Encodes 16-bit SPI command word to send over MOSI.
    """
    if channel < 0 or channel > 7:
        raise ValueError(f"Invalid channel address {channel}: must be in range 0..7")

    word = 0
    if start:
        word |= (1 << 15)
    if single_ended:
        word |= (1 << 14)
    word |= ((channel & 0x7) << 11)
    if auto_start:
        word |= (1 << 10)
    return word


def unpack_command(word: int) -> dict:
    """
    Decodes 16-bit command word received on MOSI.
    """
    word &= 0xFFFF
    return {
        "start": bool((word >> 15) & 1),
        "single_ended": bool((word >> 14) & 1),
        "channel": (word >> 11) & 0x7,
        "auto_start": bool((word >> 10) & 1),
        "reserved": word & 0x3FF,
        "raw_hex": f"0x{word:04X}"
    }


def pack_response(data: int, channel: int, ready: bool = True, busy: bool = False, err: bool = False) -> int:
    """
    Encodes 16-bit SPI response word to transmit over MISO.
    """
    if data < 0 or data > 1023:
        raise ValueError(f"Invalid ADC result {data}: must be in 10-bit range 0..1023")
    if channel < 0 or channel > 7:
        raise ValueError(f"Invalid channel tag {channel}: must be in range 0..7")

    word = 0
    if ready:
        word |= (1 << 15)
    if busy:
        word |= (1 << 14)
    if err:
        word |= (1 << 13)
    word |= ((channel & 0x7) << 10)
    word |= (data & 0x3FF)
    return word


def unpack_response(word: int) -> dict:
    """
    Decodes 16-bit response word received from MISO.
    """
    word &= 0xFFFF
    return {
        "ready": bool((word >> 15) & 1),
        "busy": bool((word >> 14) & 1),
        "error": bool((word >> 13) & 1),
        "channel_tag": (word >> 10) & 0x7,
        "data": word & 0x3FF,
        "raw_hex": f"0x{word:04X}"
    }


def test_spi_reference():
    print("==========================================================")
    print("Testing SPI Frame Reference Model (16-Bit Mode 0)")
    print("==========================================================")

    # 1. Test Command Encoding & Decoding for CH0..CH7
    print("--- Test 1: Command Packing/Unpacking for All Channels ---")
    for ch in range(8):
        word = pack_command(channel=ch, start=True, single_ended=True, auto_start=True)
        dec = unpack_command(word)
        assert dec["start"] is True
        assert dec["single_ended"] is True
        assert dec["channel"] == ch
        assert dec["auto_start"] is True
        print(f"[PASS] Channel {ch}: Command Word = {dec['raw_hex']} (CH={dec['channel']})")

    # 2. Test Response Encoding & Decoding
    print("\n--- Test 2: Response Packing/Unpacking ---")
    test_vectors = [
        (0, 0, True, False, False),
        (1, 1, True, False, False),
        (256, 2, True, False, False),
        (512, 4, True, False, False),
        (768, 6, True, False, False),
        (1023, 7, True, False, False),
        (350, 3, False, True, False), # Busy during conversion
        (0, 0, True, False, True),    # Error flag set
    ]

    for data, ch, ready, busy, err in test_vectors:
        word = pack_response(data=data, channel=ch, ready=ready, busy=busy, err=err)
        dec = unpack_response(word)
        assert dec["data"] == data
        assert dec["channel_tag"] == ch
        assert dec["ready"] == ready
        assert dec["busy"] == busy
        assert dec["error"] == err
        print(f"[PASS] Response Word = {dec['raw_hex']}: READY={dec['ready']}, BUSY={dec['busy']}, ERR={dec['error']}, CH={dec['channel_tag']}, DATA={dec['data']}")

    print("\n==========================================================")
    print("SPI Reference Model: ALL CHECKS PASSED")
    print("==========================================================")
    return True


if __name__ == "__main__":
    success = test_spi_reference()
    sys.exit(0 if success else 1)

