# Power BI — Sustainability Dashboard

12-month UAE office energy dataset. Original dashboard: 4 visuals — monthly 
energy consumption, monthly carbon emissions, energy vs target KPI, total 
CO2e card.

Key finding: July–August account for 20.0% of annual emissions — almost 
entirely HVAC-driven, with HVAC responsible for ~60% of energy use in peak 
summer months (Jun–Aug).

Benchmarks:
- DEWA 2025 grid emission factor: 0.3833 kg CO2e/kWh
- Energy target: 160 kWh/m²/year — UAE retrofit target range (160–260 
  kWh/m²/year), per Saeed Al Abbar, Chairman, EmiratesGBC (Khaleej Times, 2016)

Files:
- Sustainability_Dashboard.pbix — the dashboard file
- energy_data.csv — source data
- dashboard_full.png — screenshot for reference

Day 25 — DAX Measures: Added 4 custom measures — Carbon Intensity per m², 
Month-on-Month Change %, Peak vs Off-Peak Ratio, and a Rolling 3-Month 
Average. Dashboard restructured into 2 pages: Page 1 (original visuals) 
and Page 2 (Advanced DAX Analysis). Carbon Intensity benchmarked against 
a working target of 55 kg CO2e/m²/year (illustrative, not independently 
sourced). See Day25_DAX_Dashboard folder for the updated .pbix and 
Dashboard_v2.pdf.
