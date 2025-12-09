-- task 1 : create and use database
CREATE DATABASE IF NOT EXISTS CommercialWebsite;

USE CommercialWebsite;

-- task 2 : create tables with relationship
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(50) NOT NULL UNIQUE,
    province VARCHAR(40) NOT NULL,
    birth_date DATE NOT NULL,
    city VARCHAR(40) NOT NULL
);

CREATE TABLE Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_date DATE NOT NULL,
    invoice_note TEXT,
    invoice_discount DECIMAL(10, 2),
    invoice_total DECIMAL(10, 2) NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- task 3 : modify invoice table
ALTER TABLE Invoices
DROP COLUMN invoice_discount;

-- task 4 : modify customer tables
ALTER TABLE Customers
MODIFY COLUMN first_name VARCHAR(40) NOT NULL,
MODIFY COLUMN last_name VARCHAR(40) NOT NULL;

ALTER TABLE Customers
ADD COLUMN phone VARCHAR(20) AFTER email;

-- task 5 : Insert records into tables
INSERT INTO Customers (first_name, last_name, email, phone, province, birth_date, city)
VALUES 
    ('John', 'Smith', 'john.smith@email.com', '416-555-0101', 'Ontario', '1985-03-15', 'Toronto'),
    ('Sarah', 'Johnson', 'sarah.johnson@email.com', '604-555-0202', 'British Columbia', '1990-07-22', 'Vancouver'),
    ('Michael', 'Williams', 'michael.williams@email.com', '514-555-0303', 'Quebec', '1978-11-08', 'Montreal'),
    ('Emily', 'Brown', 'emily.brown@email.com', NULL, 'Alberta', '1995-01-30', 'Calgary');

INSERT INTO Invoices (invoice_date, invoice_note, invoice_total, customer_id)
VALUES 
    ('2024-01-15', 'First purchase - Electronics', 1299.99, 1),
    ('2024-02-20', 'Clothing items', 459.50, 1),
    ('2024-01-28', 'Home appliances', 899.00, 2),
    ('2024-03-05', 'Books and magazines', 125.75, 3),
    ('2024-02-14', 'Valentine special order', 350.00, 4),
    ('2024-03-10', 'Sports equipment', 675.25, 2);

-- task 6 : update records in both tables
UPDATE Customers
SET phone = '416-555-9999'
WHERE email = 'john.smith@email.com';

UPDATE Invoices
SET invoice_note = CONCAT(invoice_note, ' - High value order')
WHERE invoice_total > 500;

-- task 7 : display queries

-- Query 1: Display customer's full name with their invoice details
-- This joins customers and invoices to show complete information
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS 'Full Name',
    i.invoice_id AS 'Invoice ID',
    i.invoice_date AS 'Invoice Date',
    i.invoice_note AS 'Invoice Note',
    i.invoice_total AS 'Invoice Total'
FROM Customers c
INNER JOIN Invoices i ON c.customer_id = i.customer_id
ORDER BY c.last_name, c.first_name;

-- Query 2: Display the maximum invoice total with customer's full name
-- This finds the customer who has the highest single invoice
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS 'Full Name',
    i.invoice_total AS 'Maximum Invoice Total'
FROM Customers c
INNER JOIN Invoices i ON c.customer_id = i.customer_id
WHERE i.invoice_total = (SELECT MAX(invoice_total) FROM Invoices);

-- Query 3: Display customer's full name with date of birth sorted from older to younger
-- This sorts customers by birth date in ascending order (oldest first)
SELECT 
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    birth_date AS 'Date of Birth'
FROM Customers
ORDER BY birth_date ASC;

-- task 8 : Display queries with inner join

-- Query 1: Display customers from Ontario with their total invoice amount
-- This shows customers from a specific province and their spending
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS 'Full Name',
    c.province AS 'Province',
    c.city AS 'City',
    i.invoice_total AS 'Invoice Total'
FROM Customers c
INNER JOIN Invoices i ON c.customer_id = i.customer_id
WHERE c.province = 'Ontario'
ORDER BY i.invoice_total DESC;

-- Query 2: Display customers with invoices in 2024 and their total spending
-- This aggregates all invoices per customer for year 2024
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS 'Full Name',
    c.email AS 'Email',
    COUNT(i.invoice_id) AS 'Number of Invoices',
    SUM(i.invoice_total) AS 'Total Spending'
FROM Customers c
INNER JOIN Invoices i ON c.customer_id = i.customer_id
WHERE YEAR(i.invoice_date) = 2024
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY SUM(i.invoice_total) DESC;
