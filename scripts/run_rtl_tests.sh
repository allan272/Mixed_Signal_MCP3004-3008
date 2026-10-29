#!/usr/bin/env bash
# =============================================================================
# File: scripts/run_rtl_tests.sh
# Description: Automated execution of all SystemVerilog RTL testbenches
# =============================================================================

set -e

# Add Icarus Verilog to PATH if present in standard C:\iverilog\bin
if [ -d "/c/iverilog/bin" ]; then
    export PATH="/c/iverilog/bin:$PATH"
fi

mkdir -p results

echo "=========================================================="
echo "Running RTL Verification Testbenches (Icarus Verilog)"
echo "=========================================================="

echo "[1/4] Running tb_sar_controller..."
iverilog -g2012 -I rtl -o results/tb_sar_controller.vvp tb/tb_sar_controller.sv
vvp results/tb_sar_controller.vvp | tee results/tb_sar_controller.log

echo "[2/4] Running tb_spi_slave..."
iverilog -g2012 -I rtl -o results/tb_spi_slave.vvp tb/tb_spi_slave.sv
vvp results/tb_spi_slave.vvp | tee results/tb_spi_slave.log

echo "[3/4] Running tb_adc_rtl (Top-Level Integration)..."
iverilog -g2012 -I rtl -o results/tb_adc_rtl.vvp tb/tb_adc_rtl.sv
vvp results/tb_adc_rtl.vvp | tee results/tb_adc_rtl.log

echo "[4/4] Running tb_adc_channels (8-Channel Selection & Isolation)..."
iverilog -g2012 -I rtl -o results/tb_adc_channels.vvp tb/tb_adc_channels.sv
vvp results/tb_adc_channels.vvp | tee results/tb_adc_channels.log

echo "=========================================================="
echo "All RTL Testbenches Successfully Completed!"
echo "Logs saved to results/*.log"
echo "=========================================================="

