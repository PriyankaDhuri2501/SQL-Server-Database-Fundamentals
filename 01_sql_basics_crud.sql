-- List down existing databases
SELECT name from sys.databases;

-- Creating a DB
CREATE DATABASE school_db;

-- Selecting a DB
USE school_db;
SELECT DB_NAME();

-- Creating a Table 
CREATE TABLE students (
student_id INT,
name VARCHAR(100),
age INT,
grade INT
);

-- Checking existing table
EXEC sp_help 'students';

-- Insert data into table
INSERT INTO students VALUES (101,'Priya',18,9);
INSERT INTO students VALUES (102,'Parth',19,7);
INSERT INTO students VALUES (103,'Siddhi',17,8);
INSERT INTO students VALUES (104,'Shree',20,6);

-- Read Data
SELECT * FROM students;
SELECT name from students;

-- Update Data
UPDATE students
SET name = 'Priyanka'
WHERE student_id = 101;

-- Delete data 
DELETE FROM students 
WHERE name = 'Parth';

-- Delete all records 
DELETE FROM students 
WHERE 1=1;             -- slow

-- TRUNCATE (deletes records from table)
TRUNCATE TABLE students ;               -- fast