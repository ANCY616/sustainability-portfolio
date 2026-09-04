# Python — Emissions Analysis Script

Calculates Scope 2 emissions from UAE office energy data using the DEWA 
2025 grid emission factor (0.3833 kg CO2e/kWh).

The script reads energy data (Total_kWh by month), multiplies by the 
grid emission factor, and produces two outputs:
- monthly_emissions.png — bar chart of monthly emissions
- intensity_vs_benchmark.png — line chart comparing calculated intensity 
  to a working benchmark of 55 kg CO2e/m²/year (illustrative, not 
  independently sourced)

Dependencies: pandas, matplotlib
To run: python emissions_analysis.py

Files:
- emissions_analysis.py (main script)
- energy_data.csv (source data)
- monthly_emissions.png (bar chart)
- intensity_vs_benchmark.png (line chart)
