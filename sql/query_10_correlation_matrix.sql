-- Query 10: Pairwise correlation between sector returns
-- Business question: Which sectors move together?

SELECT 
    a.sector AS sector_1,
    b.sector AS sector_2,
    ROUND(CORR(a.avg_return, b.avg_return)::NUMERIC, 4) AS correlation
FROM sector_returns a
JOIN sector_returns b ON a.date = b.date AND a.sector < b.sector
GROUP BY a.sector, b.sector
ORDER BY correlation DESC;