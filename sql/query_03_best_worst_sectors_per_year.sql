-- Query 03: Best and worst sector per year
-- Business question: Which sector was #1 and #8 each year?

WITH ranked AS (
    SELECT 
        sector,
        EXTRACT(YEAR FROM date) AS year,
        ROUND(AVG(avg_return) * 252, 2) AS annual_return,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY AVG(avg_return) DESC) AS rank
    FROM sector_returns
    GROUP BY sector, EXTRACT(YEAR FROM date)
)
SELECT 
    year,
    MAX(CASE WHEN rank = 1 THEN sector END) AS best_sector,
    MAX(CASE WHEN rank = 1 THEN annual_return END) AS best_return,
    MAX(CASE WHEN rank = 8 THEN sector END) AS worst_sector,
    MAX(CASE WHEN rank = 8 THEN annual_return END) AS worst_return
FROM ranked
GROUP BY year
ORDER BY year;