"""
Pytest suite for ADC and SPI reference models.
"""

import pytest
from adc_reference import (
    SarAdcReference,
    test_exhaustive_all_codes as run_all_codes,
    test_transition_thresholds as run_thresholds,
    test_endpoints_and_clamping as run_endpoints,
    test_randomized_vectors as run_random_vectors
)
from spi_reference import pack_command, unpack_command, pack_response, unpack_response

def test_adc_all_1024_codes():
    assert run_all_codes() is True

def test_adc_threshold_boundaries():
    assert run_thresholds() is True

def test_adc_endpoints():
    assert run_endpoints() is True

def test_adc_random_sweep():
    assert run_random_vectors(500, seed=123) is True

def test_spi_command_packing():
    for ch in range(8):
        cmd = pack_command(channel=ch, auto_start=True)
        dec = unpack_command(cmd)
        assert dec["channel"] == ch
        assert dec["auto_start"] is True
        assert dec["single_ended"] is True
        assert dec["start"] is True

def test_spi_response_packing():
    resp = pack_response(data=512, channel=4, ready=True, busy=False, err=False)
    dec_resp = unpack_response(resp)
    assert dec_resp["data"] == 512
    assert dec_resp["channel_tag"] == 4
    assert dec_resp["ready"] is True
    assert dec_resp["busy"] is False
    assert dec_resp["error"] is False
