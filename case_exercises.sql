-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
USE employees;
SELECT database();
SHOW tables;

-- 1. Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not. 
-- DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
SELECT first_name, last_name, dept_no, from_date, to_date
	, IF(to_date < NOW(), FALSE, TRUE) AS 'is_current_employee'
FROM employees
	JOIN dept_emp
		USING (emp_no)
;

-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.
SELECT first_name, last_name
	, CASE
		WHEN SUBSTR(first_name, 1,1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN SUBSTR(first_name, 1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        WHEN SUBSTR(first_name, 1,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
	END AS 'Alpha_group' 
FROM employees
;


-- 3. How many employees (current or previous) were born in each decade?


-- 4. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?



-- BONUS

-- Remove duplicate employees from exercise 1.