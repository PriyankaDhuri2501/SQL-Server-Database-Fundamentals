CREATE DATABASE store_db
USE store_db

CREATE TABLE Customers ( 
    customer_id INT IDENTITY(100,1) PRIMARY KEY, 
    customer_name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) UNIQUE 
);

CREATE TABLE Orders ( 
    order_id INT IDENTITY(500,1) PRIMARY KEY, 
    order_date DATE NOT NULL, 
    total_amount DECIMAL(10, 2), 
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

EXEC sp_help 'orders'

INSERT INTO Customers (customer_name, email) 
VALUES 
('Raju', 'raju@example.com'), 
('Sham', 'sham@example.com'),
('Baburao', 'baburao@example.com');

INSERT INTO Orders (order_date, total_amount, customer_id) 
VALUES 
('2025-09-15', 1500.00, 100), -- This links to Raju (customer_id 100) 
('2025-09-28', 800.00, 104), -- This links to Sham (customer_id 104) 
('2025-10-05', 2200.00, 100), -- This links to Raju (customer_id 100) 
('2025-10-12', 500.00, 102), -- This links to Baburao (customer_id 102) 
('2025-10-17', 1200.00, 104); -- New order for Sham (customer_id 104)

SELECT * FROM Customers
SELECT * FROM Orders


INSERT INTO orders (order_date, total_amount)
VALUES ('2025-10-18', '3500')

DELETE FROM Customers WHERE customer_id=101; -- due to reference in other table it cant delete the record so here we can use "ON DELETE CASCADE"
DROP TABLE Orders;

-- INNER JOIN
SELECT c.customer_name, COUNT(o.order_id), SUM(o.total_amount) FROM Customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY customer_name

-- LEFT JOIN
SELECT * FROM Customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

-- RIGHT JOIN
SELECT * FROM Customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- FULL OUTER JOIN
SELECT * FROM Customers c
FULL OUTER JOIN orders o
ON c.customer_id = o.customer_id;

-- OUTER APPLY
SELECT c.customer_id,c.customer_name,o.order_id,o.order_date,o.total_amount
FROM Customers AS c

OUTER APPLY(
SELECT TOP 1 * FROM orders AS o
WHERE o.customer_id = c.customer_id
ORDER BY o.order_date DESC )
AS o;

-- UNION , UNION ALL & EXCEPT
SELECT customer_id FROM Customers
UNION 
SELECT customer_id FROM orders

SELECT customer_id FROM Customers
UNION ALL
SELECT customer_id FROM orders

SELECT customer_id FROM orders
EXCEPT
SELECT customer_id FROM Customers

---- MANY TO MANY ----

CREATE DATABASE institute
USE institute

CREATE TABLE courses ( 
  course_id INT IDENTITY(1,1) PRIMARY KEY, 
  course_name VARCHAR(100) NOT NULL, 
  course_fee NUMERIC(10, 2) NOT NULL 
);

INSERT INTO courses (course_name, course_fee)
VALUES
('Mathematics', 500.00),
('Physics', 600.00),
('Chemistry', 700.00);

CREATE TABLE students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);


INSERT INTO Students (student_name) VALUES
('Raju'),
('Sham'),
('Baburao'),
('Alex');

CREATE TABLE enrollment (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
 
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO enrollment (student_id, course_id, enrollment_date)
VALUES
(1, 1, '2025-01-01'), -- Raju enrolled in Mathematics
(1, 2, '2025-01-15'), -- Raju enrolled in Physics
(2, 1, '2025-02-01'), -- Sham enrolled in Mathematics
(2, 3, '2025-02-15'), -- Sham enrolled in Chemistry
(3, 3, '2025-03-25'); -- Alex enrolled in Chemistry

SELECT * FROM students
SELECT * FROM courses

SELECT * FROM enrollment

--- VIEWS---
CREATE VIEW enrollment_details AS
SELECT s.student_name, c.course_name,c.course_fee,e.enrollment_date
FROM enrollment e
INNER JOIN students s ON e.student_id = s.student_id 
INNER JOIN courses c ON e.course_id = c.course_id 

SELECT * FROM enrollment_details;

--- CHECK EXISTING VIEWS ---
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS

--- TO VIEW CODE INSIDE VIEW ---
sp_helptext 'enrollment_details'