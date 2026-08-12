Python emissions analysis script.

Calculates Scope 2 emissions from UAE office 
energy data using the DEWA 2025 grid emission 
factor (0.3833 kg CO2e/kWh).

Includes:
- emissions_analysis.py (main script)
- monthly_emissions.png (bar chart)
- intensity_vs_benchmark.png (line chart vs EGBC benchmark)

Dependencies: pandas, matplotlib

To run: python emissions_analysis.py

This folder contains a Python script for calculating Scope 2 emissions from building energy consumption data. 

Dependencies: pandas, matplotlib. 

The script reads energy data (Total_kWh by month), multiplies by the UAE grid emission factor (0.3833 kg CO2/kWh), 
and produces two outputs: monthly_emissions.png (bar chart of monthly emissions), 
and intensity_vs_benchmark.png (line chart comparing calculated intensity to EGBC benchmark of 55 kg CO2/m2/year).

To run: python emissions_analysis.py
