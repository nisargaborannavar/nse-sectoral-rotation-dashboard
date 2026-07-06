-- Query 02: Each sector's alpha vs NIFTY 50 benchmark
-- Business question: Which sectors beat NIFTY each year?

SELECT 
    sr.sector,
    EXTRACT(YEAR FROM sr.date) AS year,
    ROUND(AVG(sr.avg_return) * 252, 2) AS sector_annual_return,
    ROUND(AVG(ir.nifty_return) * 252, 2) AS nifty_annual_return,
    ROUND((AVG(sr.avg_return) - AVG(ir.nifty_return)) * 252, 2) AS alpha
FROM sector_returns sr
JOIN index_returns ir ON sr.date = ir.date
GROUP BY sr.sector, EXTRACT(YEAR FROM sr.date)
ORDER BY year, alpha DESC;
