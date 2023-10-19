SHOW DATABASES;
USE employees;
SELECT DATABASE();
SHOW TABLES;

-- Create a new file named group_by_exercises.sql

-- 1. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles;
-- A: There are 7 unique titles

select count(DISTINCT title) -- lower-case syntax is from the repo since I'm catching up. --
from titles				-- The difference is that this returns the number, rather than showing the 7 DISTINCT titles
;

-- 2. Write a query to find a list of all unique last names that start 
-- and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name lIKE 'e%e'
GROUP BY last_name			-- Remember that GROUP BY is like using DISTINCT. 
;

-- 3. Write a query to to find all unique combinations of first and last names 
-- of all employees whose last names start and end with 'E' using GROUP BY.
SELECT last_name, first_name
FROM employees
WHERE last_name lIKE 'e%e'
GROUP BY last_name, first_name
order by last_name, first_name		-- I ordered the SELECT and GROUP BY like this to show all the similar 
									-- last names first with the first_name being alphabetical
; -- 846 rows

-- 4. Write a query to find the unique last names with a 'q' but not 'qu' using GROUP BY.
-- Include those names in a comment in your sql code.
SELECT last_name -- first_name
FROM employees
WHERE last_name lIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name -- first_name
			-- HAVING first_name LIKE 'm%'		-- Messing around here where 50 rows are shown if first names were in SELECT and GROUP BY.
												-- Meaning it'll show those 3 last names in combination with all first names starting with an M.
-- A: Chleq, Lindqvist, and Qiwen
;								-- Using what I've learned and remembered to use LIKE and NOT LIKE when needed --

-- 5. Add a COUNT() to your results for exercise 4 to find the 
-- number of employees with the same last name.
SELECT last_name, COUNT(*) AS cnt -- This Alias isn't always to use a shortened version later in the query, it AlSo is for labeling the column.
FROM employees
WHERE last_name lIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name
;

-- 6. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) 
-- and GROUP BY to find the number of employees with those names for each gender.
Select first_name, gender, COUNT(*) AS cnt -- I did 'employee count' but shorter should be better to name the column
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
GROUP BY first_name, gender -- Gives the DISTINCT of each
ORDER BY first_name 		-- Neatly places the first names together in alphabetical order so you can see the M/F side to side.
;

-- 7. Using your query that generates a username for all employees, 
-- generate a count of employees with each unique username.
SELECT 
	CONCAT(LOWER(SUBSTRING(first_name, 1, 1)), 
			LOWER(SUBSTRING(last_name, 1 ,4)),
			'_', 
	LPAD(MONTH(birth_date), 2, '0'),

	SUBSTRING(YEAR(birth_date), 3, 2)
) AS username
, COUNT(*) AS cnt
FROM employees
GROUP BY username
ORDER BY COUNT(*) DESC
;
			select						-- How Lauren did it but I like to add an ORDER BY to see the cnt at its peak!
				lower(concat(
			     left(first_name, 1)
			     ,left(last_name,4)
			     ,'_'
			     ,substr(birth_date,6,2)
			     ,substr(birth_date,3,2)
			     )) as username,
			     COUNT(*) as cnt
			 from employees
			 GROUP BY username
			;


-- 8. From your previous query, are there any duplicate usernames? -- This section all is help from REPO --
-- What is the highest number of times a username shows up? 
select
	lower(concat(
    left(first_name, 1)
    ,left(last_name, 4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username,
    COUNT(*) as cnt
from employees
GROUP BY username
HAVING cnt > 1
ORDER BY cnt DESC
; 		-- 6 times is the highest number a username shows up as 
		-- having the same username and there are 4 of them.

-- Bonus: From Q8, how many duplicate usernames are there?
select count(*) 
from
	(
    select
    lower(concat(
    left(first_name, 1)
    ,left(last_name,4)
    ,'_'
    ,substr(birth_date,6,2)
    ,substr(birth_date,3,2)
    )) as username,
    COUNT(*) as cnt
    from employees
    GROUP BY username
    HAVING cnt > 1
    ORDER BY cnt DESC
    ) as un_counts 	-- Not sure if 'un_counts' was meant to be a column label?
					-- If so, it goes on top next to the COUNT(*) in SELECT.
;
-- A: Total duplicates are 13,251 



-- Bonus: More practice with aggregate functions: -- 

-- 9. Determine the historic average salary for each employee. -- 
		-- When you hear, read, or think "for each" with regard to SQL, 
		-- you'll probably be 'grouping by' that exact column.
show tables;

select emp_no, round(AVG(salary),1) as avg_sal
from salaries
group by emp_no
;

-- 10. Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.
select dept_no, count(*) as cnt
from dept_emp
WHERE to_date = '9999-01-01' 		-- 'to_date > NOW()' also works
GROUP BY dept_no
-- order by cnt desc
-- limit 1
;

-- 11. Determine how many different salaries each employee has had. 
			-- This includes both historic and current.
select emp_no, count(*) as cnt
from salaries
group by emp_no
-- 	ORDER BY cnt DESC 	-- To see the employees with the most salary changes.
;

-- 12. For each employee, find their minimum and maximum salary, 
-- 		and standard deviation of salaries.

select emp_no
		, max(salary) as max_sal
	, min(salary) as min_sal
    , count(salary) as cnt
		, round(STD(salary),1)		-- two different fuctions for Standard Deviation
        , round(stddev(salary),1)	-- I believe there is a third
from salaries
group by emp_no
;

-- 13. Find the max salary for each employee where that 
-- 		max salary is greater than $150,000.
select emp_no, max(salary) as max_sal
from salaries
group by emp_no
having max_sal > 150000
;

-- 14. Find the average salary for each employee where that 
-- 		average salary is between $80k and $90k.
select emp_no, round(avg(salary),1) as avg_sal
from salaries
group by emp_no
having avg_sal BETWEEN 80000 and 90000
;



