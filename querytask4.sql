USE classicmodels;

-- View table
SHOW TABLES;

/* List all customers from USA, ordered by name 
a. Use SELECT, WHERE, ORDER BY */
SELECT customerName, city, state, country
FROM customers
WHERE country = 'USA'
ORDER BY customerName ASC;

/* Show orders with customer names 
b. Use JOINS (INNER, LEFT, RIGHT) */
SELECT o.orderNumber, o.orderDate, c.customerName, o.status
FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber;

SELECT c.customerName, o.orderNumber, o.orderDate
FROM customers c
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber
ORDER BY c.customerName;

SELECT c.customerName, o.orderNumber, o.orderDate
FROM customers c
RIGHT JOIN orders o
    ON c.customerNumber = o.customerNumber
ORDER BY o.orderNumber;

/* Customers with above-average credit limit 
c. Write subqueries */
SELECT customerName, creditLimit
FROM customers
WHERE creditLimit > (SELECT AVG(creditLimit) FROM customers);

/* Total and Average sales amount per customer 
d. Use aggregate functions (SUM, AVG) */
SELECT 
    c.customerName, 
    SUM(od.quantityOrdered * od.priceEach) AS total_sales,
    AVG(od.quantityOrdered * od.priceEach) AS average_order_value
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
ORDER BY total_sales DESC;

/* View for analysis 
e. Create views for analysis*/
CREATE VIEW customer_total_sales AS
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName;

/* Optimize queries with indexes 
f. Optimize queries with indexes */
CREATE INDEX idx_customerNumber ON orders(customerNumber);