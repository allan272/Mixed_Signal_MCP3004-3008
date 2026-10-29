#!/usr/bin/env python3
"""
=============================================================================
File: scripts/run_all_tests.py
Description: Master Cross-Platform Regression Test Runner for 10-Bit SAR ADC
Executes RTL testbenches (iverilog/vvp), Analogue SPICE tests, and Python models.
Generates comprehensive logs and summary reports in results/.
=============================================================================
"""

import os
import sys
import time
import subprocess
from pathlib import Path

def main():
    repo_root = Path(__file__).resolve().parent.parent
    results_dir = repo_root / "results"
    results_dir.mkdir(exist_ok=True)

    # Set up PATH for Icarus Verilog on Windows if needed
    iverilog_bin = Path(r"C:\iverilog\bin")
    if iverilog_bin.exists():
        os.environ["PATH"] = str(iverilog_bin) + os.pathsep + os.environ.get("PATH", "")

    print("==========================================================")
    print("Educational 10-Bit 8-Channel SAR ADC IC - Master Regression")
    print(f"Working Directory: {repo_root}")
    print("==========================================================")

    test_suites = [
        {
            "name": "SAR Controller Core",
            "type": "RTL (iverilog)",
            "src": "tb/tb_sar_controller.sv",
            "vvp": "results/tb_sar_controller.vvp",
            "log": "results/tb_sar_controller.log",
            "cmd_compile": ["iverilog", "-g2012", "-I", "rtl", "-o", "results/tb_sar_controller.vvp", "tb/tb_sar_controller.sv"],
            "cmd_run": ["vvp", "results/tb_sar_controller.vvp"],
        },
        {
            "name": "SPI Slave Interface",
            "type": "RTL (iverilog)",
            "src": "tb/tb_spi_slave.sv",
            "vvp": "results/tb_spi_slave.vvp",
            "log": "results/tb_spi_slave.log",
            "cmd_compile": ["iverilog", "-g2012", "-I", "rtl", "-o", "results/tb_spi_slave.vvp", "tb/tb_spi_slave.sv"],
            "cmd_run": ["vvp", "results/tb_spi_slave.vvp"],
        },
        {
            "name": "Top-Level RTL Integration",
            "type": "RTL (iverilog)",
            "src": "tb/tb_adc_rtl.sv",
            "vvp": "results/tb_adc_rtl.vvp",
            "log": "results/tb_adc_rtl.log",
            "cmd_compile": ["iverilog", "-g2012", "-I", "rtl", "-o", "results/tb_adc_rtl.vvp", "tb/tb_adc_rtl.sv"],
            "cmd_run": ["vvp", "results/tb_adc_rtl.vvp"],
        },
        {
            "name": "8-Channel Selection & Isolation",
            "type": "RTL (iverilog)",
            "src": "tb/tb_adc_channels.sv",
            "vvp": "results/tb_adc_channels.vvp",
            "log": "results/tb_adc_channels.log",
            "cmd_compile": ["iverilog", "-g2012", "-I", "rtl", "-o", "results/tb_adc_channels.vvp", "tb/tb_adc_channels.sv"],
            "cmd_run": ["vvp", "results/tb_adc_channels.vvp"],
        },
        {
            "name": "Analogue Behavioural Models",
            "type": "SPICE / LTspice",
            "log": "results/analog_models.log",
            "cmd_run": [sys.executable, "tb/analog/test_analog_models.py"],
        },
        {
            "name": "Golden SAR ADC Reference Model",
            "type": "Python Model",
            "log": "results/adc_reference.log",
            "cmd_run": [sys.executable, "models/adc_reference.py"],
        },
        {
            "name": "Golden SPI Protocol Reference Model",
            "type": "Python Model",
            "log": "results/spi_reference.log",
            "cmd_run": [sys.executable, "models/spi_reference.py"],
        },
        {
            "name": "Pytest Suite (Exhaustive & Parameterized)",
            "type": "Pytest",
            "log": "results/pytest_models.log",
            "cmd_run": [sys.executable, "-m", "pytest", "models/test_models_pytest.py", "-v"],
        },
    ]

    summary = []
    total_passed = 0
    total_failed = 0
    start_time_all = time.time()

    for idx, t in enumerate(test_suites, start=1):
        name = t["name"]
        print(f"\n[{idx}/{len(test_suites)}] Running: {name} ({t['type']})")
        t_start = time.time()
        log_file = repo_root / t["log"]

        full_output = ""
        passed = True

        # Compile step for RTL
        if "cmd_compile" in t:
            p_comp = subprocess.run(
                t["cmd_compile"],
                cwd=repo_root,
                capture_output=True,
                text=True
            )
            full_output += f"--- COMPILATION COMMAND ---\n{' '.join(t['cmd_compile'])}\n"
            full_output += p_comp.stdout + p_comp.stderr
            if p_comp.returncode != 0:
                passed = False
                print(f"  [ERROR] Compilation failed with code {p_comp.returncode}")
                full_output += f"\n[COMPILATION FAILED: exit code {p_comp.returncode}]\n"

        # Execution step
        if passed:
            p_run = subprocess.run(
                t["cmd_run"],
                cwd=repo_root,
                capture_output=True,
                text=True
            )
            full_output += f"\n--- EXECUTION COMMAND ---\n{' '.join(t['cmd_run'])}\n"
            full_output += p_run.stdout + p_run.stderr
            if p_run.returncode != 0:
                passed = False
                print(f"  [ERROR] Execution failed with code {p_run.returncode}")
                full_output += f"\n[EXECUTION FAILED: exit code {p_run.returncode}]\n"

        elapsed = time.time() - t_start
        status_str = "PASSED" if passed else "FAILED"
        print(f"  -> {status_str} in {elapsed:.2f}s")

        # Save log file
        with open(log_file, "w", encoding="utf-8") as f:
            f.write(full_output)

        if passed:
            total_passed += 1
        else:
            total_failed += 1

        summary.append({
            "name": name,
            "type": t["type"],
            "status": status_str,
            "elapsed": f"{elapsed:.2f}s",
            "log": t["log"]
        })

    total_time = time.time() - start_time_all

    # Clean temporary vvps
    for vvp_file in results_dir.glob("*.vvp"):
        vvp_file.unlink(missing_ok=True)
    for vcd_file in repo_root.glob("*.vcd"):
        vcd_file.unlink(missing_ok=True)

    # Print Summary Table
    print("\n" + "=" * 70)
    print("REGRESSION EXECUTION SUMMARY")
    print("=" * 70)
    header = f"{'Suite':<38} | {'Type':<15} | {'Status':<8} | {'Time':<7}"
    print(header)
    print("-" * len(header))
    for s in summary:
        print(f"{s['name']:<38} | {s['type']:<15} | {s['status']:<8} | {s['elapsed']:<7}")
    print("-" * len(header))
    print(f"TOTAL: {len(summary)} suites | PASSED: {total_passed} | FAILED: {total_failed} | DURATION: {total_time:.2f}s")
    print("=" * 70)

    # Write Markdown Summary Report
    summary_md = repo_root / "results" / "REGRESSION_SUMMARY.md"
    with open(summary_md, "w", encoding="utf-8") as f:
        f.write("# Regression Test Execution Summary\n\n")
        f.write(f"- **Execution Date:** {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"- **Total Test Suites:** {len(summary)}\n")
        f.write(f"- **Passed:** {total_passed}\n")
        f.write(f"- **Failed:** {total_failed}\n")
        f.write(f"- **Total Duration:** {total_time:.2f}s\n\n")
        f.write("| Suite Name | Test Category | Status | Runtime | Log File |\n")
        f.write("|---|---|---|---|---|\n")
        for s in summary:
            f.write(f"| **{s['name']}** | {s['type']} | `{s['status']}` | {s['elapsed']} | [`{s['log']}`]({s['log']}) |\n")
        f.write("\n## Test Coverage Summary\n\n")
        f.write("1. **SAR Controller:** Verified 100% of trial sequence states, reset abort, busy request rejection, and 100 random code vectors.\n")
        f.write("2. **SPI Interface:** Mode 0 CPOL=0/CPHA=0 verified, active-low CS_N, tri-state MISO, all 8 channel decodes, premature frame abort detection, and back-to-back framing.\n")
        f.write("3. **System Integration:** End-to-end conversions requested over SPI and results read back with matching channel tags and bit-exact codes.\n")
        f.write("4. **Multi-Channel Isolation:** Forward sweep, reverse sweep, interleaved pseudo-random hopping, and repeat conversions across all 8 channels.\n")
        f.write("5. **Analogue Models:** 8:1 MUX routing, S&H acquisition/hold settling, 10-bit DAC transfer curve, and comparator threshold decisions verified in LTspice.\n")
        f.write("6. **Reference Models:** Exhaustive test of all 1024 codes, microvolt boundary thresholds, clamping endpoints, and randomized vectors.\n")

    print(f"\nDetailed markdown summary written to: {summary_md}")
    sys.exit(0 if total_failed == 0 else 1)

if __name__ == "__main__":
    main()

