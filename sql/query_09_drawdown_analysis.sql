-- Query 09: Maximum peak to trough drop per sector per year
-- Business question: What was the worst loss each sector faced?

WITH cumulative AS (
    SELECT 
        sector,
        EXTRACT(YEAR FROM date) AS year,
        date,
        SUM(avg_return) OVER (PARTITION BY sector, EXTRACT(YEAR FROM date) ORDER BY date) AS cum_return
    FROM sector_returns
),
peaks AS (
    SELECT 
        sector,
        year,
        date,
        cum_return,
        MAX(cum_return) OVER (PARTITION BY sector, year ORDER BY date) AS peak
    FROM cumulative
)
SELECT 
    sector,
    year,
    ROUND(MIN(cum_return - peak) * 100, 2) AS max_drawdown_pct
FROM peaks
GROUP BY sector, year
ORDER BY year, max_drawdown_pct;