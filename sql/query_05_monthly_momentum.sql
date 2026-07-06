-- Query 05: Rolling 3 month return per sector every month
-- Business question: Which sectors have momentum?

SELECT 
    sector,
    DATE_TRUNC('month', date) AS month,
    ROUND(AVG(avg_return) * 63, 2) AS rolling_3month_return
FROM sector_returns
GROUP BY sector, DATE_TRUNC('month', date)
ORDER BY sector, month;