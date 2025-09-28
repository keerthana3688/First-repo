Create database
CREATE DATABASE ecommerce_DB;
USE ecommerce_DB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);






INSERT INTO Customers (name, email, country) VALUES
('Alice', 'alice@email.com', 'USA'),
('Bob', 'bob@email.com', 'UK'),
('Charlie', 'charlie@email.com', 'India');

-- Insert Products
INSERT INTO Products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Phone', 'Electronics', 700.00),
('Shoes', 'Fashion', 80.00),
('Watch', 'Fashion', 150.00);

-- Insert Orders
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2025-09-01', 1980.00),
(2, '2025-09-02', 700.00),
(3, '2025-09-03', 230.00);

-- Insert Order Details
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 1), -- Laptop
(1, 2, 1), -- Phone
(2, 2, 1), -- Phone
(3, 3, 1), -- Shoes
(3, 4, 1); -- Watch



-- Get all orders sorted by amount
SELECT order_id, total_amount
FROM Orders
ORDER BY total_amount DESC;

--Join customers with their orders
SELECT c.name, o.order_id, o.total_amount
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- Total revenue
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

-- Average order value
SELECT AVG(total_amount) AS avg_order_value
FROM Orders;

-- Revenue by country
SELECT c.country, SUM(o.total_amount) AS country_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.country;

-- Customers who spent more than average
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM Orders)
);

-- Create a view for order summary
CREATE VIEW OrderSummary AS
SELECT o.order_id, c.name, o.order_date, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- Create index for faster joins
CREATE INDEX idx_customer_id ON Orders(customer_id);

-- Show all customers, even if they have no orders
SELECT c.name, o.order_id, o.total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Show all orders, even if customer info is missing
SELECT o.order_id, o.total_amount, c.name
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;