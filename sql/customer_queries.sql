-- Total customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Customers by district
SELECT district, COUNT(*) AS num_customers
FROM customers
GROUP BY district;

-- Gender-wise customer count
SELECT gender, COUNT(*) AS count_by_gender
FROM customers
GROUP BY gender;

-- Age distribution
SELECT age, COUNT(*) AS age_group_count
FROM customers
GROUP BY age
ORDER BY age;

-- Monthly new customers
SELECT DATE_FORMAT(join_date, '%Y-%m') AS month, COUNT(*) AS new_customers
FROM customers
GROUP BY month
ORDER BY month;
