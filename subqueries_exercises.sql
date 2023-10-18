USE employees;
select database();
show tables; -- departments, dept_emp, dept_manager, employees, salaries, titles


-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
select *
from employees
where hire_date = ( -- Using 'IN' rather than '=' would also work since the hire date is IN the hire date of the other employees
				select hire_date 
                from employees 
                where emp_no = 101010 -- hire date is 1990-10-22
                ) 
;

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
describe titles;
describe employees;

SELECT emp_no, first_name, last_name
FROM employees

WHERE emp_no IN (
		SELECT emp_no
		FROM titles
		WHERE to_date > NOW()
)
AND first_name = 'Aamod'
;


				-- SELECT DISTINCT title
				-- FROM titles
				-- WHERE emp_no IN (
				-- 		SELECT emp_no
				--         FROM employees
				--         WHERE first_name = 'Aamod'
				-- 			AND emp_no IN (SELECT emp_no FROM employees)
				-- ) What chat.gpt gave but I could've given more details tbh --

-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.



-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.



-- 5. Find all the employees who currently have a higher salary than the 
-- company's overall, historical average salary.



-- 6. How many current salaries are within 1 standard deviation of the current highest salary?
-- (Hint: you can use a built-in function to calculate the standard deviation.)
-- What percentage of all salaries is this?



-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.




-- BONUS

-- 1. Find all the department names that currently have female managers.


-- 2. Find the first and last name of the employee with the highest salary.


-- 3. Find the department name that the employee with the highest salary works in.


-- 4. Who is the highest paid employee within each department.