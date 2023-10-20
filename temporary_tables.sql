USE ursula_2334;
USE employees;

/* 1. Using the example from the lesson, create a temporary table called 
employees_with_departments that contains first_name, last_name, and dept_name 
 for employees currently with that department. Be absolutely sure to create this 
 table on your own database. If you see "Access denied for user ...", 
 it means that the query was attempting to write a new table 
 to a database that you can only read. */

DROP TABLE employees_with_departments; -- If I want to restart --

CREATE TEMPORARY TABLE IF NOT EXISTS employees_with_departments (
		emp_no INT PRIMARY KEY
	,first_name VARCHAR(50)
    ,last_name VARCHAR(50)
    ,dept_name VARCHAR(50)
);

SELECT * FROM employees_with_departments;

	-- a. Add a column named full_name to this table. 
    -- It should be a VARCHAR whose length is the sum of the lengths of the 
    -- first name and last name columns.
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);
SELECT * FROM employees_with_departments;
    
	-- b. Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name)
WHERE emp_no in (1,2,3,4);
SELECT * FROM employees_with_departments;

	-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
    
	-- d. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE ursula_2334.employees_with_departments AS
	SELECT emp_no, first_name, last_name, dept_no, dept_name
	FROM employees
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
	LIMIT 100;

SELECT * FROM ursula_2334.employees_with_departments;

-- Add a column named full_name
ALTER TABLE employees_with_departments ADD COLUMN full_name VARCHAR(50);

-- Update the table to set values for the full_name column
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

-- Remove the first_name and last_name columns
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

    
-- 2. Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored 
-- as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.




/* 3. Go back to the employees database. 
Find out how the current average pay in each department compares to 
the overall current pay for everyone at the company. For this comparison, 
you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst? */


