# =============================================================================
# File: scripts/run_all_tests.ps1
# Description: PowerShell runner for executing complete SAR ADC test regression
# =============================================================================

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Starting Complete Regression via Python Test Runner" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$pythonExe = (Get-Command python).Source
& $pythonExe scripts/run_all_tests.py

