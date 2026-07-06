-- Query 06: Standard deviation of daily returns per sector
-- Business question: Which sector is most risky?

SELECT 
    sector,
    EXTRACT(YEAR FROM date) AS year,
    ROUND(STDDEV(avg_return) * 100, 4) AS volatility_pct
FROM sector_returns
GROUP BY sector, EXTRACT(YEAR FROM date)
ORDER BY year, volatility_pct DESC;