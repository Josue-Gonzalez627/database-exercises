-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
USE employees;
SELECT database();
SHOW tables;


-- 1. Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not. 
-- DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
SELECT first_name, last_name, emp_no, dept_no, from_date, to_date		-- concat(first_name, ' ', last_name) --
	, IF(to_date > NOW(), TRUE, FALSE) AS 'is_current_employee'
FROM employees
	JOIN dept_emp
		USING (emp_no)
;


-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.
SELECT last_name
	, CASE
		WHEN SUBSTR(last_name, 1,1) BETWEEN 'A' AND 'H' THEN 'A-H'		-- LEFT function would work also -- LEFT(last_name, 1)
        WHEN SUBSTR(last_name, 1,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        WHEN SUBSTR(last_name, 1,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'		-- ELSE 'R-Z' -- would suffice because it'll catch the leftovers. 
        -- ELSE 'R-Z'
	END AS 'Alpha_group' 
FROM employees
;

-- 3. How many employees (current or previous) were born in each decade?
						-- SELECT first_name, last_name, birth_date
						-- 	, IF(birth_date BETWEEN '1950-01-01' AND '1959-12-31', True, False) AS '50\'s'
						--     , IF(birth_date BETWEEN '1960-01-01' AND '1969-12-31', True, False) AS '60\'s'
						-- FROM employees
						-- ;		-- Tried another way, formatting needs work
SELECT
	CASE 
		WHEN birth_date >= '1950-01-01' AND birth_date <= '1959-12-31' THEN '50\'s'		-- A BETWEEN or a LIKE could've worked --
	 -- WHEN birth_date like '195%' THEN '50s'
		WHEN birth_date >= '1960-01-01' AND birth_date <= '1969-12-31' THEN '60\'s'
	END AS 'Decade_Born',
	count(*) AS cnt
FROM employees
GROUP BY Decade_Born
;

-- 4. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT *
FROM departments;

SELECT
	CASE 
		WHEN dept_name IN ('Research', 'development') THEN 'R&D'
		WHEN dept_name IN ('Sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE 'Customer Service'
	END AS dept_group
	, ROUND(AVG(salary),2) AS Avg_Salary
FROM departments AS d
	JOIN dept_emp AS de
		USING (dept_no)
		-- ON d.dept_no = de.dept_no	-- another way
	JOIN salaries AS s
		USING (emp_no)
		-- ON de.emp_no = s.emp_no		-- another way
where s.to_date > now()
	and de.to_date > now()
GROUP BY dept_group
;


-- BONUS

-- Remove duplicate employees from exercise 1.			-- Go to REPO  :D --
select emp_no, max(to_date);


;




