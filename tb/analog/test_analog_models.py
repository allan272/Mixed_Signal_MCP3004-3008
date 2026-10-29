#!/usr/bin/env python3
"""
Test script for verifying SPICE analogue behavioural models using LTspice batch output.
Parses tb/analog/analog_model_tb.log and compares against analytical expectations.
"""

import sys
import re
import os
import subprocess
from pathlib import Path

def run_ltspice():
    repo_root = Path(__file__).resolve().parent.parent.parent
    cir_path = repo_root / "tb" / "analog" / "analog_model_tb.cir"
    log_path = repo_root / "tb" / "analog" / "analog_model_tb.log"

    ltspice_exe = Path(r"C:\Users\HP\AppData\Local\Programs\ADI\LTspice\LTspice.exe")
    if not ltspice_exe.exists():
        print(f"[SKIP] LTspice executable not found at {ltspice_exe}")
        return False

    cmd = [str(ltspice_exe), "-b", "-ascii", str(cir_path)]
    print(f"Executing: {' '.join(cmd)}")
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"[FAIL] LTspice execution failed with code {result.returncode}")
        print(result.stderr)
        return False

    return True

def parse_and_validate_log():
    repo_root = Path(__file__).resolve().parent.parent.parent
    log_path = repo_root / "tb" / "analog" / "analog_model_tb.log"

    if not log_path.exists():
        print(f"[FAIL] Log file not found: {log_path}")
        return False

    with open(log_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    # Pattern for measurement lines: meas_name: ... =value at ...
    pattern = re.compile(r"([a-zA-Z0-9_]+):\s+.*?=\s*([-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?)")
    measurements = {}
    for line in content.splitlines():
        m = pattern.search(line)
        if m:
            meas_name = m.group(1).lower()
            meas_val = float(m.group(2))
            measurements[meas_name] = meas_val

    print("\n--- Parsed LTspice Behavioural Measurements ---")
    for k, v in sorted(measurements.items()):
        print(f"  {k:18s} = {v:12.6f}")

    # Expected values table
    expected = {
        "vmux_ch0": (0.500, 0.01, "MUX CH0 routing"),
        "vmux_ch1": (1.000, 0.01, "MUX CH1 routing"),
        "vmux_ch2": (1.500, 0.01, "MUX CH2 routing"),
        "vmux_ch3": (2.000, 0.01, "MUX CH3 routing"),
        "vmux_ch4": (2.500, 0.01, "MUX CH4 routing"),
        "vmux_ch5": (3.000, 0.01, "MUX CH5 routing"),
        "vmux_ch6": (3.500, 0.01, "MUX CH6 routing"),
        "vmux_ch7": (4.000, 0.01, "MUX CH7 routing"),
        "vheld_track": (2.500, 0.02, "S&H Track CH4 voltage"),
        "vheld_hold1": (2.500, 0.05, "S&H Hold at 45us"),
        "vheld_hold2": (2.500, 0.05, "S&H Hold at 75us"),
        "vdac_code0": (0.000, 0.001, "DAC Code 0 output"),
        "vdac_code1": (5.0 / 1024.0, 0.001, "DAC Code 1 (1 LSB) output"),
        "vdac_code256": (5.0 * 256 / 1024.0, 0.01, "DAC Code 256 (1/4 scale)"),
        "vdac_code512": (5.0 * 512 / 1024.0, 0.01, "DAC Code 512 (1/2 scale)"),
        "vdac_code768": (5.0 * 768 / 1024.0, 0.01, "DAC Code 768 (3/4 scale)"),
        "vdac_code1023": (5.0 * 1023 / 1024.0, 0.01, "DAC Code 1023 (Full scale - 1 LSB)"),
        "cmp_at_code256": (5.0, 0.1, "Comparator decision: Vheld > Vdac"),
        "cmp_at_code512": (5.0, 0.1, "Comparator decision: Vheld == Vdac (equality)"),
        "cmp_at_code768": (0.0, 0.1, "Comparator decision: Vheld < Vdac"),
    }

    errors = 0
    print("\n--- Validation against Analytical Expectations ---")
    for key, (exp_val, tol, desc) in expected.items():
        if key not in measurements:
            print(f"[FAIL] Missing measurement: {key}")
            errors += 1
            continue
        act_val = measurements[key]
        delta = abs(act_val - exp_val)
        if delta <= tol:
            print(f"[PASS] {desc:40s}: Obs={act_val:8.4f} V, Exp={exp_val:8.4f} V (err={delta:7.5f})")
        else:
            print(f"[FAIL] {desc:40s}: Obs={act_val:8.4f} V, Exp={exp_val:8.4f} V (err={delta:7.5f} > tol {tol})")
            errors += 1

    print("\n==========================================================")
    print(f"Analogue Model Summary: {len(expected)} checks, {errors} errors")
    print("==========================================================")
    return errors == 0

def main():
    print("==========================================================")
    print("Starting Analogue Behavioural Model Verification (LTspice)")
    print("==========================================================")
    if not run_ltspice():
        print("[WARN] LTspice run skipped or failed, attempting to read existing log...")
    passed = parse_and_validate_log()
    sys.exit(0 if passed else 1)

if __name__ == "__main__":
    main()

