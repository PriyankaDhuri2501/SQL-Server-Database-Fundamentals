-- List down existing databases
SELECT name from sys.databases;

-- Employee table using IDENTITY, PRIMARY KEY, UNIQUE KEY, DEFAULT
CREATE TABLE EMPLOYEES(
employee_id INT IDENTITY(1,1) PRIMARY KEY,
fname varchar(50) NOT NULL,
lname VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
dept VARCHAR(50) NOT NULL ,
salary DECIMAL(10,2) DEFAULT 30000.00,
hire_date DATE NOT NULL DEFAULT GETDATE()
);

INSERT INTO employees (fname, lname, email, dept, salary, hire_date) 
VALUES
('Raj', 'Sharma', 'raj.sharma@example.com', 'IT', 50000.00, '2020-01-15'),
('Priya', 'Singh', 'priya.singh@example.com', 'HR', 45000.00, '2019-03-22'),
('Suman', 'Patel', 'suman.patel@example.com', 'Finance', 60000.00, '2018-07-30'),
('Vijay', 'Nair', 'vijay.nair@example.com', 'Marketing', 50000.00, '2020-04-19'),
('Vinayak', 'Nagar', 'vn@example.com', 'Sales', 90000.00, '2020-04-10'),
('Veer', 'Surve', 'vs@example.com', 'IT', 70000.00, '2020-08-19'),
('Harsh', 'kohli', 'kohli@example.com', 'HR', 10000.00, '2020-02-09'),
('Sahil', 'Gupta', 'sahil@example.com', 'Finace', 90000.00, '2020-04-05'),
('Riya', 'Shaikh', 'rshaikh@example.com', 'Sales', 40000.00, '2020-01-10');

INSERT INTO employees (fname, lname, email, dept) 
VALUES
('Raj', 'Sharma', 'raj.sharma@example.com', 'TECH');

SELECT * FROM EMPLOYEES;
TRUNCATE TABLE EMPLOYEES;

-- WHERE CLAUSE 
SELECT * FROM EMPLOYEES WHERE dept != 'TECH';
SELECT * FROM EMPLOYEES WHERE dept = 'IT';
SELECT * FROM EMPLOYEES WHERE salary > 50000;
SELECT * FROM EMPLOYEES WHERE hire_date > '2020-12-31';
SELECT * FROM EMPLOYEES WHERE dept != 'HR';

-- DISTINCT 
SELECT DISTINCT fname FROM EMPLOYEES;

-- ORDER BY
SELECT fname FROM EMPLOYEES ORDER BY salary DESC;
SELECT * FROM EMPLOYEES ORDER BY hire_date;
SELECT * FROM EMPLOYEES ORDER BY fname;
SELECT * FROM EMPLOYEES ORDER BY dept;

-- LIKE CLAUSE 
SELECT * FROM EMPLOYEES WHERE dept LIKE 'M%';         -- starts with m
SELECT * FROM EMPLOYEES WHERE fname LIKE '%a';    -- ends with a
SELECT * FROM EMPLOYEES WHERE email LIKE '%patel%'; -- contains patel
SELECT * FROM EMPLOYEES WHERE fname LIKE '[^V]%';   -- not start with v
SELECT * FROM EMPLOYEES WHERE fname LIKE '[ps]%';    -- starts with a or b
SELECT * FROM EMPLOYEES WHERE fname LIKE '_u%';   -- second letter starts from u
SELECT * FROM EMPLOYEES WHERE fname LIKE '_____';  -- containing 5 letters 

-- NOT LIKE CLAUSE
SELECT * FROM EMPLOYEES WHERE fname NOT LIKE '%a'; 

-- TOP CLAUSE 
SELECT TOP 3 * FROM EMPLOYEES ORDER BY salary;
SELECT TOP 5 * FROM EMPLOYEES ORDER BY hire_date DESC;
SELECT TOP 1 fname,lname FROM EMPLOYEES WHERE dept = 'Marketing';
SELECT TOP 2 * FROM EMPLOYEES ORDER BY fname;

-- LOGICAL OPERATORS 
SELECT * FROM EMPLOYEES WHERE salary = 50000 AND dept = 'Marketing';
SELECT * FROM EMPLOYEES WHERE salary = 52000 OR dept = 'Marketing';

SELECT * FROM EMPLOYEES WHERE dept in ('Marketing','HR','IT');
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 45000 AND 60000;

-- CASE
SELECT fname, lname, salary,
CASE
	WHEN salary >=50000 THEN 'High Earner'
	WHEN salary >=30000 THEN 'Medium Earner'
	ELSE 'Standard Earner'
END AS Salary_band
FROM EMPLOYEES;

SELECT fname, lname,dept,salary,
CASE
	WHEN dept in ('Marketing','Sales') THEN salary*0.10
	WHEN dept='Tech' THEN salary*0.12
	ELSE salary*0.05
END AS bonus
FROM EMPLOYEES;

-- IS NULL 
SELECT * FROM EMPLOYEES WHERE fname is NULL;

--AGGREGATE FUNCTIONS
SELECT COUNT(employee_id) FROM EMPLOYEES;
SELECT MAX(salary) FROM EMPLOYEES;
SELECT MIN(salary) FROM EMPLOYEES;
SELECT AVG(salary) FROM EMPLOYEES;
SELECT SUM(salary) FROM EMPLOYEES;

-- ADD NEW COLUMN
ALTER TABLE EMPLOYEES 
ADD city varchar(20);

UPDATE EMPLOYEES 
SET city = CASE employee_id
	when 1 Then 'Mumbai'
	when 2 Then 'Bangalore'
	when 3 Then 'Pune'
	when 4 Then 'Hyderabad'
	when 5 Then 'Bangalore'
	when 6 Then 'Mumbai'
	when 7 Then 'Hyderabad'
	when 8 Then 'Pune'
	when 9 Then 'Noida'
end
where employee_id in (1,2,3,4,5,6,7,8,9)

ALTER TABLE EMPLOYEES 
ADD Job_title varchar(20);

EXEC sp_help 'EMPLOYEES';

ALTER TABLE EMPLOYEES
ALTER COLUMN Job_title varchar(30);

UPDATE EMPLOYEES 
SET Job_title = CASE employee_id
	when 1 Then 'DevOps Engineer'
	when 2 Then 'Director'
	when 3 Then 'Recruiter'
	when 4 Then 'Product Designer'
	when 5 Then 'Sales Executive'
	when 6 Then 'Lead Engineer'
	when 7 Then 'Data Analyst'
	when 8 Then 'Data Scientist'
	when 9 Then 'Marketing Lead'
end
where employee_id in (1,2,3,4,5,6,7,8,9)

-- GROUP BY
SELECT dept, COUNT(*) FROM EMPLOYEES GROUP BY dept;
SELECT city, COUNT(*) FROM EMPLOYEES GROUP BY city;
SELECT dept, AVG(salary) FROM EMPLOYEES GROUP BY dept;

SELECT dept, city, count(employee_id) FROM EMPLOYEES 
GROUP BY dept,city;

-- HAVING CLAUSE 
SELECT dept FROM EMPLOYEES 
GROUP BY dept HAVING COUNT(employee_id)>1;

SELECT Job_title FROM EMPLOYEES 
GROUP BY Job_title HAVING AVG(SALARY)>=90000;

SELECT dept, SUM(salary) FROM EMPLOYEES 
GROUP BY dept HAVING SUM(salary)>30000;

SELECT dept, COALESCE(city,'Total') ,COUNT(employee_id) FROM EMPLOYEES 
GROUP BY ROLLUP(dept,city);

-- sub queries 

SELECT * FROM EMPLOYEES WHERE salary > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT * FROM EMPLOYEES WHERE city = (SELECT city FROM EMPLOYEES WHERE fname = 'Vinayak' AND lname = 'Nagar');

SELECT * FROM EMPLOYEES WHERE salary = (SELECT MAX(salary) FROM EMPLOYEES)

SELECT * FROM EMPLOYEES e1
WHERE salary = (SELECT MAX(salary) FROM EMPLOYEES e2
WHERE e2.dept = e1.dept);

SELECT * FROM EMPLOYEES WHERE salary IN (SELECT MAX(salary) FROM EMPLOYEES GROUP BY dept);

-- multi-row sub queries

SELECT * FROM EMPLOYEES WHERE dept IN (
SELECT dept FROM EMPLOYEES WHERE city = 'Mumbai');

Select * FROM EMPLOYEES WHERE city = 'Mumbai';

-- INLINE VIEW
SELECT dept, avg
FROM (
	SELECT dept, AVG(salary) as avg FROM EMPLOYEES 
	GROUP BY dept
) AS dept_avg
WHERE avg>70000;

-- STRING FUNCTIONS 

SELECT CONCAT(fname,' ',lname) FROM EMPLOYEES;
SELECT CONCAT_WS(',', employee_id, fname, lname) FROM EMPLOYEES;
SELECT SUBSTRING(fname, 1,4) FROM EMPLOYEES;
SELECT REPLACE(fname, 'Raj', 'Viraj') FROM EMPLOYEES;

SELECT REVERSE('hello');
SELECT UPPER(fname) FROM EMPLOYEES;
SELECT LOWER(fname) FROM EMPLOYEES;
SELECT len(fname) FROM EMPLOYEES;
SELECT LEFT(fname,3) FROM EMPLOYEES;
SELECT RIGHT(fname,3) FROM EMPLOYEES;
SELECT TRIM('   DWEJDWE   ');
SELECT CHARINDEX('ANCE', dept) FROM EMPLOYEES;

ALTER TABLE EMPLOYEES 
ADD CONSTRAINT chk_emp_positive_sal CHECK (salary>0);

INSERT INTO employees (fname, lname, email, dept, salary, hire_date,city,Job_title) 
VALUES
('Raj', 'Sharma', 'raj.sharma@example.com', 'IT', 0, '2020-01-15','Mumbai','Tester');

-----WINDOW FUNCTIONS---
SELECT fname, salary, 
SUM(salary) OVER() as Total_sal,
CAST(salary*100 / SUM(salary) OVER() as DECIMAL(10,2)) AS pct_of_total
FROM EMPLOYEES

SELECT fname,dept, salary,
SUM(salary) OVER(PARTITION BY dept) as Total_sal
FROM EMPLOYEES

--- ROW_NUMBER---
SELECT 
	ROW_NUMBER() OVER(ORDER BY fname)as row_num,
	fname,dept, salary
	FROM EMPLOYEES

-- RANK ----
SELECT 
	fname,dept, salary,
	RANK() OVER(PARTITION BY dept ORDER BY salary desc)as rank
	FROM EMPLOYEES

-- DENSE RANK ----
SELECT 
	fname,dept, salary,
	DENSE_RANK() OVER(ORDER BY salary desc)as rank
	FROM EMPLOYEES

SELECT 
	fname,hire_date, salary,
	LAG(salary) OVER(ORDER BY hire_date) as lag,
	salary - LAG(salary) OVER(ORDER BY hire_date) as differ
	FROM EMPLOYEES

SELECT 
	fname,dept, salary,
	Lead(salary) OVER(ORDER BY salary desc) as lead
	FROM EMPLOYEES


------------- CTE ---------
WITH avgsal as (
SELECT dept, AVG(salary) as dept_avg FROM EMPLOYEES GROUP BY dept )
SELECT e.fname,e.dept,e.salary, a.dept_avg
FROM EMPLOYEES e JOIN avgsal a ON
e.dept = a.dept
WHERE e.salary > a.dept_avg

WITH maxsal as (SELECT dept, MAX(salary) as dept_max
FROM EMPLOYEES
GROUP BY dept)
SELECT e.employee_id, e.fname, e.dept,e.salary, m.dept_max
FROM EMPLOYEES e JOIN maxsal m
ON e.dept = m.dept
WHERE e.salary > m.dept_max;

----- STORED PROCEDURES -----
CREATE PROCEDURE get_emp_details 
AS
BEGIN 
SELECT fname,lname,dept,salary FROM EMPLOYEES 
END

EXEC get_emp_details


--- with parameters ---
CREATE PROCEDURE get_emp_by_dept
	@p_dept varchar(100)
AS
BEGIN
	SELECT employee_id,fname,lname,dept,salary FROM EMPLOYEES 
	WHERE dept = @p_dept
END 

EXEC get_emp_by_dept 'HR'

--- GET EXISTING SP ----
SELECT ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE 
ROUTINE_TYPE = 'PROCEDURE'
ORDER BY 
ROUTINE_NAME;
sp_helptext 'get_emp_by_dept'

---ALTER SP---
ALTER PROCEDURE get_emp_details 
AS
BEGIN 
SELECT fname,lname,dept,salary,Job_title FROM EMPLOYEES 
END

EXEC get_emp_details

--SP TO UPDATE VALUE--
CREATE PROCEDURE update_emp_salary
	@p_emp_id INT,
	@p_salary NUMERIC(8,2)
AS
BEGIN 
	UPDATE EMPLOYEES
	SET salary = @p_salary
	WHERE employee_id = @p_emp_id
END

SELECT * FROM EMPLOYEES
EXEC update_emp_salary 1, 80000

---- FUNCTIONS(RETURN SINGLE VALUE) ----
CREATE FUNCTION DOUBLE_VALUE(
	@p_num NUMERIC(10,2)
)
RETURNS NUMERIC(10,2)
AS
BEGIN
	DECLARE @result NUMERIC(10,2)
	SET @result = @p_num*2
	RETURN @result
END

SELECT fname, salary, dbo.DOUBLE_VALUE(salary) FROM EMPLOYEES


---- FUNCTIONS(RETURN TABLE VALUE) ---- (ITVF)
CREATE FUNCTION DEPT_MAX_EMP(
	@p_dept varchar(100)
)
RETURNS TABLE
AS
RETURN (
	SELECT * FROM EMPLOYEES WHERE dept=@p_dept AND 
	salary = (SELECT MAX(salary) FROM EMPLOYEES WHERE dept = @p_dept
	)
)

SELECT * from dbo.DEPT_MAX_EMP('Sales')

--- USER DEFINED FUNCTIONS ---
CREATE FUNCTION YearsOfService(
	@p_hdate DATE
)
RETURNS INT
AS
BEGIN 
	DECLARE @years_of_service INT;
	SET @years_of_service = DATEDIFF(YEAR, @p_hdate, GETDATE());

	IF (DATEADD(YEAR, @years_of_service, @p_hdate) > GETDATE())
	BEGIN 
		SET @years_of_service = @years_of_service - 1
	END
	RETURN @years_of_service
END

SELECT fname, hire_date, GETDATE(),dbo.YearsOfService(hire_date) FROM EMPLOYEES

------------- INDEXES ---------

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT * FROM EMPLOYEES WHERE salary >80000
DBCC DROPCLEANBUFFERS

CREATE INDEX i_salary
ON employees(salary)

DROP INDEX i_salary ON employees ;

---------- TRIGGERS -----------

CREATE TRIGGER trg_PMarketingLeadDeletion
ON EMPLOYEES
INSTEAD OF DELETE
AS
BEGIN
    -- Prevent deletion of Marketing employees
    IF EXISTS (SELECT 1 FROM deleted WHERE dept = 'Marketing Lead')
    BEGIN
        RAISERROR('Deletion not allowed for Marketing employees.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Allow deletion for others
    DELETE FROM EMPLOYEES
    WHERE employee_id IN (SELECT employee_id FROM deleted);
END;

DELETE FROM EMPLOYEES WHERE employee_id = 9


EXEC sp_helpindex 'employees';
