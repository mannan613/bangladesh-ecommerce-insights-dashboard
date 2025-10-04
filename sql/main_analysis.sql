/*
Main Analysis Queries for Bangladesh E-Commerce Insights Dashboard
Database: ecommerce_bd
*/

/*=======================
  Customer Related Queries
========================*/

/* 1. Total number of customers */
SELECT COUNT(*) AS total_customers FROM customers;

/* 2. Number of customers by district */
SELECT district, COUNT(*) AS num_customers
FROM customers
GROUP BY district;

/* 3. Gender-wise customer count */
SELECT gender, COUNT(*) AS count_by_gender
FROM customers
GROUP BY gender;

/* 4. Age distribution of customers */
SELECT age, COUNT(*) AS age_group_count
FROM customers
GROUP BY age
ORDER BY age;

/* 5. Monthly new customers */
SELECT DATE_FORMAT(join_date, '%Y-%m') AS month, COUNT(*) AS new_customers
FROM customers
GROUP BY month
ORDER BY month;


/*=======================
  Product Related Queries
========================*/

/* 6. Top 5 products by quantity sold */
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

/* 7. Revenue by product category */
SELECT 
    p.category,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

/* 8. Return count by product */
SELECT 
    p.product_name,
    COUNT(*) AS return_count
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.returned = 'Y'
GROUP BY p.product_name
ORDER BY return_count DESC;

/* 9. Top 5 products by revenue */
SELECT 
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

/* 10. Total revenue from all products */
SELECT 
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;


/*=======================
  Order Related Queries
========================*/

/* 11. Sample orders (first 10 rows) */
SELECT * FROM orders LIMIT 10;

/* 12. Total number of orders */
SELECT COUNT(*) AS total_orders FROM orders;

/* 13. Orders with duplicate order_id */
SELECT order_id, COUNT(*) 
FROM orders 
GROUP BY order_id 
HAVING COUNT(*) > 1;

/* 14. Monthly order count */
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(*) AS order_count
FROM orders
GROUP BY month
ORDER BY month;

/* 15. Monthly returned orders */
SELECT 
  DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
  COUNT(*) AS returned_orders
FROM orders
WHERE returned = 'Y'
GROUP BY month
ORDER BY month;

/* 16. Overall return rate percentage */
SELECT 
    COUNT(CASE WHEN returned = 'Y' THEN 1 END) * 100.0 / COUNT(*) AS return_rate_percent
FROM orders;

/* 17. Top 5 products by quantity ordered */
SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 5;

/* 18. Customer type by order frequency */
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

