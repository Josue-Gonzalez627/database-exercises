use employees;

-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name 
-- together as a single column named full_name.
SELECT CONCAT(first_name,' ',last_name) as full_name
FROM employees
WHERE last_name LIKE 'e%e'
;

-- Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) as full_name
FROM employees
WHERE last_name LIKE 'e%e'
;

-- Use a function to determine how many results were 
-- returned from your previous query.
SELECT COUNT(UPPER(CONCAT(first_name, last_name))) as rows_returned_in_previous
FROM employees
WHERE last_name LIKE 'e%e'
;

-- Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been 
-- working at the company (Hint: You will also need to use NOW() or CURDATE()),
SELECT first_name, last_name, hire_date, birth_date, emp_no, 
DATEDIFF (CURDATE(), hire_date) as num_days_at_company
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' -- Can also be 'WHERE EXTRACT(year from hire_date) BETWEEN 1990 and 1999'
AND 
	birth_date LIKE '%12-25' 
ORDER BY num_days_at_company DESC
;

-- Find the smallest and largest current salary from the salaries table.
SELECT CONCAT('$',MIN(Salary)) as smallest_salary, CONCAT('$' ,MAX(salary)) as largest_salary
FROM salaries
;

-- Use your knowledge of built in SQL functions to generate a username 
-- for all of the employees. A username should be all lowercase, 
-- and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, and the last two digits of the year that 
-- they were born. Below is an example of what the first 10 rows will look like:
SELECT CONCAT(LOWER(SUBSTRING(first_name, 1, 1)), 
			LOWER(SUBSTRING(last_name, 1 ,4)),
'_', 
LPAD(MONTH(birth_date), 2, '0'), -- Will input a 0 next to the month if it is a single digit.
-- Found through the datediff() link in #5 the 'DATE_FORMAT' function that uses '%' 
-- followed by a letter to format it different ways. The other: DATE_FORMAT(birth_date, '%m')

-- messed up, easiest way was just SUBSTRING(birth_date, 6, 2)

SUBSTRING(YEAR(birth_date), 3, 2) -- YEAR works here because the format is 'date' but doesn't require it here. The MOTH above does seem to matter.
) AS username
, first_name, last_name, birth_date
FROM employees
;

