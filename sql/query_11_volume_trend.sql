-- Query 11: Trading volume trend by sector
-- Business question: Where is institutional interest going?

SELECT 
    sector,
    EXTRACT(YEAR FROM date) AS year,
    ROUND(AVG(tottrdqty), 0) AS avg_daily_volume
FROM master_stocks
GROUP BY sector, EXTRACT(YEAR FROM date)
ORDER BY year, avg_daily_volume DESC;