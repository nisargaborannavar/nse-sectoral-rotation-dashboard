-- Query 01: Annual return per sector per year, ranked
-- Business question: Which sector performed best each year?

SELECT 
    sector,
    EXTRACT(YEAR FROM date) AS year,
    ROUND(AVG(avg_return) * 252, 2) AS annual_return_pct,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY AVG(avg_return) DESC) AS rank
FROM sector_returns
GROUP BY sector, EXTRACT(YEAR FROM date)
ORDER BY year, rank;