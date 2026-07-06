# NSE Sectoral Rotation Dashboard

3 years of real NSE data. 8 sectors. One question — would rotating sectors have beaten just holding NIFTY?

---

## What this project does

Instead of using a Kaggle dataset, I downloaded 618 daily NSE Bhavcopy files directly from nseindia.com, cleaned and processed them in Python, ran SQL analysis in PostgreSQL, and built a Power BI dashboard to answer one practical investing question:

**Which sectors should an investor have been in each year between 2022 and 2024?**

---

## Dataset

- Source: NSE Bhavcopy + Yahoo Finance (NIFTY 50)
- 618 trading days of data (Jan 2022 — Dec 2024)
- 1.5 million raw rows, filtered to 61 stocks across 8 sectors
- Sectors: IT, Banking, Pharma, Auto, FMCG, Energy, Metals, Finance

---

## Tools

Python 3.12 · Pandas · PostgreSQL 18 · Power BI · Jupyter Notebook · Git

---

## What I found

**AUTO dominated.** It was #2 in 2022, #1 in 2023 (+45%), and #1 again in 2024 (+57%). Nothing else came close over the full 3 years.

**IT was a trap in 2022.** Down 33% that year. But investors who sold and never came back missed a +34% recovery in 2023.

**Rotation crushed passive investing every year:**

| Year | Best Sector | Return | NIFTY |
|------|------------|--------|-------|
| 2022 | Banking | +25.66% | ~+4% |
| 2023 | Auto | +45.27% | ~+20% |
| 2024 | Auto | +56.75% | ~+9% |

**Banking + Finance is not diversification.** Correlation of 0.63 — they move together. Energy + FMCG (0.21) is a much better combination.

**Auto had the best risk-adjusted return.** Sharpe proxy of 0.53 in 2023 — highest of any sector any year.

---

## Dashboard

4 pages built in Power BI connected directly to PostgreSQL:

- **Market Overview** — NIFTY trend line, sector returns matrix, summary cards
- **Sector Deep Dive** — drill into any sector's performance over time
- **Rotation Map** — color coded heatmap, sectors vs years
- **Risk vs Return** — scatter plot, volatility vs return, bubble size = volume

---

## SQL Analysis

12 queries covering annual returns, sector vs NIFTY alpha, volatility, Sharpe proxy, drawdown, correlation matrix, volume trends and more. All saved as individual .sql files in the sql/ folder.

---

## How to run it

```bash
# 1. Clone
git clone https://github.com/nisargaborannavar/nse-sectoral-rotation-dashboard.git

# 2. Install
pip install pandas matplotlib seaborn yfinance psycopg2-binary

# 3. Download data
python script/bulk_download.py

# 4. Clean data
# Open notebook/01_data_cleaning.ipynb and run all cells

# 5. Load into PostgreSQL
# Create database nse_analysis, then run notebook/02_sql_loading.ipynb

# 6. SQL analysis
# Run notebook/03_sql_queries.ipynb

# 7. Dashboard
# Open nse_sectoral_rotation_dashboard.pbix in Power BI Desktop
```

---

## Folder structure

```
├── data/
│   ├── raw/                  ← 618 bhavcopy files
│   ├── master_stocks.csv
│   ├── sector_returns.csv
│   └── index_returns.csv
├── notebook/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_sql_loading.ipynb
│   └── 03_sql_queries.ipynb
├── script/
│   └── bulk_download.py
├── sql/                      ← 12 .sql files
├── insight_memo.md
└── README.md
```

---

Built with real market data. No Kaggle shortcuts.