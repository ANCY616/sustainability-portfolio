# emissions_analysis.py
# Calculates Scope 2 emissions and carbon intensity for a UAE office building
# using the same energy dataset behind the Power BI dashboard and SQL queries.

import pandas as pd
import matplotlib.pyplot as plt

# STEP 1 — Load the existing energy dataset (same CSV used in Power BI and SQL)
df = pd.read_csv('energy_data.csv')

# STEP 2 — Calculate Scope 2 emissions using the official DEWA 2025 grid emission factor
# (0.3833 kg CO2e per kWh)
df['Scope2_Emissions_kgCO2e'] = df['Total_kWh'] * 0.3833

# STEP 3 — Calculate monthly carbon intensity (per m^2, for a 5,000 m^2 building)
df['Intensity_kgCO2_m2'] = df['Scope2_Emissions_kgCO2e'] / 5000

# STEP 4 — Chart 1: Monthly Scope 2 emissions bar chart -> monthly_emissions.png
plt.figure(figsize=(10, 5))
plt.bar(df['Month'], df['Scope2_Emissions_kgCO2e'], color='steelblue')
plt.title('Monthly Scope 2 CO2 Emissions - UAE Office Building')
plt.xlabel('Month')
plt.ylabel('CO2 (kg)')
plt.tight_layout()
plt.savefig('monthly_emissions.png')

# STEP 5 — Chart 2: Carbon intensity line chart vs EGBC benchmark -> intensity_vs_benchmark.png
# EGBC benchmark = 55 kg CO2/m2/year, shown here as a monthly-equivalent line
benchmark = 55 / 12
plt.figure(figsize=(10, 5))
plt.plot(df['Month'], df['Intensity_kgCO2_m2'], marker='o', label='Actual')
plt.axhline(y=benchmark, color='red', linestyle='--', label='EGBC Benchmark')
plt.title('Monthly Carbon Intensity vs EGBC Benchmark')
plt.xlabel('Month')
plt.ylabel('kg CO2 / m2')
plt.legend()
plt.tight_layout()
plt.savefig('intensity_vs_benchmark.png')

# Print a quick summary so the numbers can be checked against Power BI / SQL
print("Total annual Scope 2 emissions (kg CO2e):", round(df['Scope2_Emissions_kgCO2e'].sum(), 2))
print(df[['Month', 'Total_kWh', 'Scope2_Emissions_kgCO2e', 'Intensity_kgCO2_m2']])
