# =============================================================================
# Makefile for Educational 10-Bit, 8-Channel SAR ADC IC
# =============================================================================

PYTHON ?= python
IVERILOG ?= iverilog
VVP ?= vvp

.PHONY: all tools lint test-sar test-spi test-rtl test-analog test-models test-all clean help

all: test-all

help:
	@echo "Educational SAR ADC Build Targets:"
	@echo "  make tools        : Check toolchain presence and versions"
	@echo "  make lint         : Run syntax and semantic checks on RTL"
	@echo "  make test-sar     : Run SAR controller core testbench"
	@echo "  make test-spi     : Run SPI slave interface testbench"
	@echo "  make test-rtl     : Run all digital RTL testbenches"
	@echo "  make test-analog  : Run SPICE behavioural analogue tests"
	@echo "  make test-models  : Run Python golden reference and pytest suite"
	@echo "  make test-all     : Run complete automated regression suite"
	@echo "  make clean        : Remove simulation outputs, waveforms, and logs"

tools:
	@$(PYTHON) -c "import sys; print('Python:', sys.version)"
	@bash scripts/check_tools.sh || true

lint:
	@mkdir -p results
	$(IVERILOG) -Wall -g2012 -I rtl -o results/lint_check.vvp rtl/adc_top.sv
	@rm -f results/lint_check.vvp
	@echo "Lint check PASSED: No syntax or elaboration errors found."

test-sar:
	@mkdir -p results
	$(IVERILOG) -g2012 -I rtl -o results/tb_sar_controller.vvp tb/tb_sar_controller.sv
	$(VVP) results/tb_sar_controller.vvp
	@rm -f results/tb_sar_controller.vvp *.vcd

test-spi:
	@mkdir -p results
	$(IVERILOG) -g2012 -I rtl -o results/tb_spi_slave.vvp tb/tb_spi_slave.sv
	$(VVP) results/tb_spi_slave.vvp
	@rm -f results/tb_spi_slave.vvp *.vcd

test-rtl: test-sar test-spi
	@mkdir -p results
	$(IVERILOG) -g2012 -I rtl -o results/tb_adc_rtl.vvp tb/tb_adc_rtl.sv
	$(VVP) results/tb_adc_rtl.vvp
	$(IVERILOG) -g2012 -I rtl -o results/tb_adc_channels.vvp tb/tb_adc_channels.sv
	$(VVP) results/tb_adc_channels.vvp
	@rm -f results/*.vvp *.vcd

test-analog:
	$(PYTHON) tb/analog/test_analog_models.py

test-models:
	$(PYTHON) models/adc_reference.py
	$(PYTHON) models/spi_reference.py
	$(PYTHON) -m pytest models/test_models_pytest.py -v

test-all:
	$(PYTHON) scripts/run_all_tests.py

clean:
	@rm -f *.vvp *.vcd *.fst *.raw *.op.raw *.log *.tmp
	@rm -rf results/*.vvp results/*.vcd __pycache__ .pytest_cache
	@echo "Clean completed."

