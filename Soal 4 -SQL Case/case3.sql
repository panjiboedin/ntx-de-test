SELECT 
    v2ProductName,
    SUM(totalTransactionRevenue) AS total_revenue,
    SUM(productQuantity) AS total_quantity,
    SUM(productRefundAmount) AS total_refund,
    SUM(totalTransactionRevenue) - SUM(productRefundAmount) AS net_revenue,
    CASE WHEN SUM(productRefundAmount) > 0.1 * SUM(totalTransactionRevenue) THEN 'exceeds 10%' ELSE 'Normal' END AS refund_flag
FROM 
    ecommerce
GROUP BY 
    v2ProductName
ORDER BY 
    net_revenue DESC;


-- I assumed get total revenue from the totalTransactionRevenue column. because if we use productRevenue, itemRevenue, or transactionRevenue can't calculate it because the value is 0