#!/usr/bin/env bash
# =============================================================================
# File: scripts/check_tools.sh
# Description: Environment audit and toolchain discovery script
# =============================================================================

set -e

echo "=========================================================="
echo "Checking Toolchain Availability"
echo "=========================================================="

# Check Icarus Verilog
if command -v iverilog >/dev/null 2>&1; then
    echo "[FOUND] iverilog: $(command -v iverilog)"
    iverilog -V | head -n 2
elif [ -f "/c/iverilog/bin/iverilog.exe" ]; then
    echo "[FOUND] iverilog: /c/iverilog/bin/iverilog.exe"
    /c/iverilog/bin/iverilog.exe -V | head -n 2
else
    echo "[NOT FOUND] iverilog (Digital RTL simulation unavailable)"
fi

# Check VVP
if command -v vvp >/dev/null 2>&1; then
    echo "[FOUND] vvp: $(command -v vvp)"
elif [ -f "/c/iverilog/bin/vvp.exe" ]; then
    echo "[FOUND] vvp: /c/iverilog/bin/vvp.exe"
else
    echo "[NOT FOUND] vvp"
fi

# Check Python 3
if command -v python >/dev/null 2>&1; then
    echo "[FOUND] python: $(command -v python)"
    python --version
else
    echo "[NOT FOUND] python"
fi

# Check LTspice
LTSPICE_WIN="C:\\Users\\HP\\AppData\\Local\\Programs\\ADI\\LTspice\\LTspice.exe"
LTSPICE_BASH="/c/Users/HP/AppData/Local/Programs/ADI/LTspice/LTspice.exe"
if [ -f "$LTSPICE_BASH" ]; then
    echo "[FOUND] LTspice: $LTSPICE_BASH"
else
    echo "[NOT FOUND] LTspice at standard path"
fi

echo "=========================================================="

