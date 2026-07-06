-- Query 08: Top 5 stocks by annual return per sector
-- Business question: Which stocks drove sector performance?

WITH stock_annual AS (
    SELECT 
        symbol,
        sector,
        EXTRACT(YEAR FROM date) AS year,
        ROUND(AVG(return) * 252, 2) AS annual_return,
        RANK() OVER (PARTITION BY sector, EXTRACT(YEAR FROM date) ORDER BY AVG(return) DESC) AS rank
    FROM master_stocks
    GROUP BY symbol, sector, EXTRACT(YEAR FROM date)
)
SELECT 
    sector,
    year,
    symbol,
    annual_return,
    rank
FROM stock_annual
WHERE rank <= 5
ORDER BY sector, year, rank;