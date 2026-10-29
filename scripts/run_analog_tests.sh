#!/usr/bin/env bash
# =============================================================================
# File: scripts/run_analog_tests.sh
# Description: Automated execution of SPICE behavioural analogue tests
# =============================================================================

set -e

mkdir -p results

echo "=========================================================="
echo "Running Analogue Model Tests (LTspice Batch & Python)"
echo "=========================================================="

python tb/analog/test_analog_models.py | tee results/analog_models.log

echo "=========================================================="
echo "Analogue Model Verification Completed!"
echo "Log saved to results/analog_models.log"
echo "=========================================================="

