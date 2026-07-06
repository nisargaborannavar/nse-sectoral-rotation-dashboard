-- Query 07: Return divided by volatility as risk adjusted metric
-- Business question: Which sector gave best returns per unit of risk?

SELECT 
    sector,
    EXTRACT(YEAR FROM date) AS year,
    ROUND(AVG(avg_return) * 252, 2) AS annual_return,
    ROUND(STDDEV(avg_return) * 100, 4) AS volatility,
    ROUND((AVG(avg_return) * 252) / NULLIF(STDDEV(avg_return) * 100, 0), 4) AS sharpe_proxy
FROM sector_returns
GROUP BY sector, EXTRACT(YEAR FROM date)
ORDER BY year, sharpe_proxy DESC;