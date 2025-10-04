USE ecommerce_bd;

SELECT * FROM orders LIMIT 10;

SELECT COUNT(*) AS total_orders FROM orders;

SELECT order_id, COUNT(*) 
FROM orders 
GROUP BY order_id 
HAVING COUNT(*) > 1;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(*) AS order_count
FROM orders
GROUP BY month
ORDER BY month;

SELECT 
  DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
  COUNT(*) AS returned_orders
FROM orders
WHERE returned = 'Y'
GROUP BY month
ORDER BY month;

SELECT 
    COUNT(CASE WHEN returned = 'Y' THEN 1 END) * 100.0 / COUNT(*) AS return_rate_percent
FROM orders;

SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 5;

SELECT 
  CASE 
    WHEN order_count = 1 THEN 'New Customer'
    ELSE 'Repeat Customer'
  END AS customer_type,
  COUNT(*) AS customer_count
FROM (
  SELECT customer_id, COUNT(*) AS order_count
  FROM orders
  GROUP BY customer_id
) AS customer_orders
GROUP BY customer_type;
