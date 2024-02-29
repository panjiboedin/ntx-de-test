WITH user_behaviour AS
(SELECT
  fullVisitorId,
  AVG(timeOnSite) AS avg_site,
  AVG(pageviews) AS avg_page,
  AVG(sessionQualityDim) AS avg_session
FROM
  ecommerce
GROUP BY fullVisitorId),
average_metrics AS
(SELECT
  AVG(avg_site) AS allavg_site,
  AVG(avg_page) AS allavg_page
FROM
  user_behaviour)
SELECT
  ub.fullVisitorId,
  ub.avg_site,
  ub.avg_page,
  ub.avg_session
FROM
  user_behaviour ub
  JOIN average_metrics am
    ON 1 = 1
WHERE ub.avg_site > am.allavg_site
  AND ub.avg_page < am.allavg_page


-- first i create subquery to get average of time on site, page views, and  session quality for each visitor.
-- then in second subquery is to get the average time on site and average page views as average metrics
-- then join all that subquery table  by "ON 1=1" because I want to join tables that don't have keys to be able to compare values freely.

  fullVisitorId,
channelGrouping,
time,
country,
city,
totalTransactionRevenue,
transactions,
timeOnSite,
pageviews,
sessionQualityDim,
date,
visitId,
type,
productRefundAmount,
productQuantity,
productPrice,
productRevenue,
productSKU,
v2ProductName,
v2ProductCategory,
productVariant,
currencyCode,
itemQuantity,
itemRevenue,
transactionRevenue,
transactionId,
pageTitle,
searchKeyword,
pagePathLevel1,
eCommerceAction_type,
eCommerceAction_step,
eCommerceAction_option,