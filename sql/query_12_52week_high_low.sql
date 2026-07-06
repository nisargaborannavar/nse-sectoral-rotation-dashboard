-- Query 12: Stocks at 52 week high or low counts by sector
-- Business question: Which sectors have stocks at extremes?

WITH yearly AS (
    SELECT 
        symbol,
        sector,
        EXTRACT(YEAR FROM date) AS year,
        MAX(high) AS yearly_high,
        MIN(low) AS yearly_low,
        LAST_VALUE(close) OVER (PARTITION BY symbol, EXTRACT(YEAR FROM date) ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_close
    FROM master_stocks
    GROUP BY symbol, sector, EXTRACT(YEAR FROM date), close, date
)
SELECT 
    sector,
    year,
    COUNT(CASE WHEN last_close >= yearly_high * 0.98 THEN 1 END) AS near_52w_high,
    COUNT(CASE WHEN last_close <= yearly_low * 1.02 THEN 1 END) AS near_52w_low
FROM yearly
GROUP BY sector, year
ORDER BY year, sector;