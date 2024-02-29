WITH top_country AS
(SELECT
  `country`,
  SUM(`totalTransactionRevenue`) AS `revenue`
FROM
  ecommerce
GROUP BY `country`
ORDER BY `revenue` DESC
LIMIT 5)
SELECT
  ec.country,
  ec.channelGrouping,
  SUM(`totalTransactionRevenue`) AS `total_revenue`
FROM
  ecommerce ec
  JOIN top_country top
    ON ec.country = top.country
GROUP BY ec.country,
  ec.channelGrouping
ORDER BY ec.country,
  total_revenue DESC;

-- first I created a subquery to get the top 5 countries by revenue and named it as "top_country" based on totalTransactionRevenue.
-- I assumed get total revenue from the totalTransactionRevenue column. because if we use productRevenue, itemRevenue, or transactionRevenue can't calculate it because the value is 0
-- then join with the ecommerce table to get top 5 countries producing the highest revenue