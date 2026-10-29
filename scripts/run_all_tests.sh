#!/usr/bin/env bash
# =============================================================================
# File: scripts/run_all_tests.sh
# Description: Master regression test runner
# =============================================================================

set -e

mkdir -p results

echo "=========================================================="
echo "Starting Complete SAR ADC Automated Test Regression"
echo "=========================================================="

bash scripts/check_tools.sh

echo -e "\n--- Step 1: RTL Test Suite ---"
bash scripts/run_rtl_tests.sh

echo -e "\n--- Step 2: Analogue Behavioural Suite ---"
bash scripts/run_analog_tests.sh

echo -e "\n--- Step 3: Golden Python Reference Suite ---"
python models/adc_reference.py | tee results/adc_reference.log
python models/spi_reference.py | tee results/spi_reference.log
python -m pytest models/test_models_pytest.py -v | tee results/pytest_models.log

echo "=========================================================="
echo "ALL REGRESSION TESTS COMPLETED SUCCESSFULLY!"
echo "Summary of results preserved in results/ directory."
echo "=========================================================="

