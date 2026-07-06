-- Query 04: Sectors that appear in top 3 in 2+ years
-- Business question: Which sectors consistently outperform?

WITH ranked AS (
    SELECT 
        sector,
        EXTRACT(YEAR FROM date) AS year,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY AVG(avg_return) DESC) AS rank
    FROM sector_returns
    GROUP BY sector, EXTRACT(YEAR FROM date)
)
SELECT 
    sector,
    COUNT(*) AS years_in_top3
FROM ranked
WHERE rank <= 3
GROUP BY sector
HAVING COUNT(*) >= 2
ORDER BY years_in_top3 DESC;