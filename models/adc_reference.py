#!/usr/bin/env python3
"""
=============================================================================
File: models/adc_reference.py
Description: Golden Analytical & Bit-Accurate SAR ADC Reference Model
Specification: 10-bit SAR, VREF = 5.0V, 8 Channels
Transfer Function: D = min(1023, floor(1024 * VIN / VREF)) for 0 <= VIN <= VREF
=============================================================================
"""

import math
import sys
import numpy as np

class SarAdcReference:
    """
    Mathematical and architectural model of a 10-bit Successive Approximation Register ADC.
    """
    def __init__(self, resolution_bits=10, vref=5.0, v_offset=0.0, gain_error=0.0):
        self.bits = resolution_bits
        self.num_codes = 2 ** self.bits
        self.vref = float(vref)
        self.lsb = self.vref / self.num_codes  # 5.0 / 1024 = 4.8828125 mV
        self.v_offset = float(v_offset)
        self.gain_factor = 1.0 + float(gain_error)

    def ideal_transfer(self, vin):
        """
        Ideal mathematical transfer function:
        D = min(1023, floor(1024 * VIN / VREF))
        """
        if vin < 0.0:
            return 0
        ratio = (vin * self.gain_factor - self.v_offset) / self.vref
        code = math.floor(self.num_codes * ratio)
        return max(0, min(self.num_codes - 1, int(code)))

    def sar_binary_search(self, vin):
        """
        Emulates cycle-by-cycle SAR binary search hardware:
        - Cycles through bit 9 down to bit 0.
        - Trial code presented to DAC: V_DAC = VREF * D_trial / 1024.
        - Comparator decision: 1 if V_in >= V_DAC, else 0.
        Returns:
            final_code (int): 10-bit resolved result
            trace (list): history of (bit_idx, trial_code, v_dac, cmp_decision)
        """
        v_in_effective = vin * self.gain_factor - self.v_offset
        resolved_code = 0
        trace = []

        for bit in range(self.bits - 1, -1, -1):
            # Assert current trial bit
            trial_code = resolved_code | (1 << bit)
            v_dac = self.vref * (trial_code / float(self.num_codes))

            # Comparator decision (strictly V_in >= V_DAC evaluates to 1)
            # Floating point epsilon (1e-12) used to avoid numerical rounding ambiguities
            if v_in_effective >= (v_dac - 1e-12):
                decision = 1
                resolved_code = trial_code  # Keep bit
            else:
                decision = 0
                resolved_code = resolved_code  # Clear bit

            trace.append((bit, trial_code, v_dac, decision))

        # Clamp output to valid 10-bit range (0 to 1023)
        final_code = max(0, min(self.num_codes - 1, resolved_code))
        return final_code, trace


def test_exhaustive_all_codes():
    """
    Exhaustively test all 1024 code centers:
    For each code k in [0, 1023], test VIN = (k + 0.5) * LSB.
    Verify that ideal_transfer and sar_binary_search produce exactly code k.
    """
    adc = SarAdcReference(resolution_bits=10, vref=5.0)
    print("\n--- Test Suite 1: Exhaustive Verification of All 1024 Codes ---")
    mismatches = 0

    for k in range(1024):
        # Code center voltage
        vin = (k + 0.5) * adc.lsb
        ideal_code = adc.ideal_transfer(vin)
        sar_code, _ = adc.sar_binary_search(vin)

        if ideal_code != k or sar_code != k:
            print(f"[FAIL] Code mismatch at target {k}: ideal={ideal_code}, sar={sar_code}")
            mismatches += 1

    if mismatches == 0:
        print("[PASS] All 1024 codes (0 to 1023) verified with 100% agreement between SAR loop and ideal model.")
    else:
        print(f"[FAIL] {mismatches} mismatches encountered across 1024 codes.")
    return mismatches == 0


def test_transition_thresholds():
    """
    Test decision thresholds:
    At boundary VIN = k * LSB:
    VIN = k * LSB - 1uV should produce k - 1 (for k > 0)
    VIN = k * LSB + 1uV should produce k
    """
    adc = SarAdcReference(resolution_bits=10, vref=5.0)
    print("\n--- Test Suite 2: Code Transition Boundary Checks ---")
    test_boundaries = [1, 2, 127, 128, 255, 256, 511, 512, 767, 768, 1022, 1023]
    errors = 0
    delta = 1e-6  # 1 uV

    for k in test_boundaries:
        v_thresh = k * adc.lsb

        # Just below boundary
        v_below = v_thresh - delta
        code_below, _ = adc.sar_binary_search(v_below)
        exp_below = k - 1
        if code_below != exp_below:
            print(f"[FAIL] Boundary {k} below: Vin={v_below:.7f}V, exp={exp_below}, got={code_below}")
            errors += 1

        # Exactly at / just above boundary
        v_above = v_thresh + delta
        code_above, _ = adc.sar_binary_search(v_above)
        exp_above = min(1023, k)
        if code_above != exp_above:
            print(f"[FAIL] Boundary {k} above: Vin={v_above:.7f}V, exp={exp_above}, got={code_above}")
            errors += 1

    if errors == 0:
        print(f"[PASS] All {len(test_boundaries)} critical boundary transitions verified within 1uV precision.")
    else:
        print(f"[FAIL] {errors} boundary threshold errors observed.")
    return errors == 0


def test_endpoints_and_clamping():
    """
    Verify endpoint behavior:
    - VIN = 0.0V -> Code 0
    - VIN = -0.1V -> Code 0 (clamped)
    - VIN = 5.0V (VREF) -> Code 1023 (clamped full scale)
    - VIN = 5.1V (>VREF) -> Code 1023 (clamped full scale)
    """
    adc = SarAdcReference(resolution_bits=10, vref=5.0)
    print("\n--- Test Suite 3: Endpoint Clamping & Boundary Conventions ---")
    test_cases = [
        (-0.5, 0, "Negative input under-range"),
        (0.0, 0, "Zero-scale exact ground"),
        (5.0, 1023, "Full-scale exact VREF (clamped to 10'h3FF)"),
        (5.05, 1023, "Over-voltage over-range (clamped)"),
        (10.0, 1023, "High over-voltage (clamped)")
    ]
    errors = 0
    for vin, exp, desc in test_cases:
        code, _ = adc.sar_binary_search(vin)
        if code == exp:
            print(f"[PASS] {desc:45s}: Vin={vin:5.2f}V -> Code {code:4d} (0x{code:03x})")
        else:
            print(f"[FAIL] {desc:45s}: Vin={vin:5.2f}V -> Exp {exp:4d}, Got {code:4d}")
            errors += 1

    return errors == 0


def test_randomized_vectors(num_points=1000, seed=42):
    """
    Reproducible randomized vector sweep across full input dynamic range.
    """
    print(f"\n--- Test Suite 4: Randomized Numerical Cross-Check (N={num_points}, Seed={seed}) ---")
    rng = np.random.default_rng(seed)
    test_voltages = rng.uniform(0.0, 5.0, num_points)

    adc = SarAdcReference(resolution_bits=10, vref=5.0)
    mismatches = 0

    for idx, vin in enumerate(test_voltages):
        ideal = adc.ideal_transfer(vin)
        sar, _ = adc.sar_binary_search(vin)
        if ideal != sar:
            mismatches += 1
            if mismatches <= 5:
                print(f"[FAIL] Mismatch at point {idx}: Vin={vin:.6f}V, Ideal={ideal}, SAR={sar}")

    if mismatches == 0:
        print(f"[PASS] All {num_points} randomized trials matched between SAR search and analytical floor function.")
    else:
        print(f"[FAIL] {mismatches} mismatches encountered across {num_points} random trials.")
    return mismatches == 0


def main():
    print("==========================================================")
    print("Golden SAR ADC Python Reference Model Verification Suite")
    print("Resolution: 10 Bits | Reference Voltage: 5.000 V | LSB: 4.8828 mV")
    print("==========================================================")

    p1 = test_exhaustive_all_codes()
    p2 = test_transition_thresholds()
    p3 = test_endpoints_and_clamping()
    p4 = test_randomized_vectors(1000, seed=42)

    all_passed = p1 and p2 and p3 and p4
    print("\n==========================================================")
    print(f"Overall Reference Model Verification: {'PASSED' if all_passed else 'FAILED'}")
    print("==========================================================")
    sys.exit(0 if all_passed else 1)


if __name__ == "__main__":
    main()

