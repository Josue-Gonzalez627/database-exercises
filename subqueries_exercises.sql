USE employees;
SELECT database();
SHOW tables; -- departments, dept_emp, dept_manager, employees, salaries, titles


-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
				-- SELECT *
				-- FROM employees
				-- WHERE hire_date = ( -- Using 'IN' rather than '=' would also work since the hire date is IN the hire date of the other employees
				-- 				SELECT hire_date 
				--                 FROM employees 
				--                 WHERE emp_no = 101010 -- hire date is 1990-10-22
				--                 )  
							-- What I tried...
;
select hire_date
from employees
WHERE emp_no = '101010'
;
            select *
            from employees 
				JOIN dept_emp
					using (emp_no) -- same column name
            where hire_date = (
				select hire_date
				from employees
				where emp_no = '101010'
				)
                AND to_date > now()
                ; -- 55 rows 
		

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
DESCRIBE titles; -- emp_no, titles
DESCRIBE employees; -- emp_no, first_name


		-- SELECT e.emp_no, first_name, last_name, title, to_date
		-- FROM employees as e -- left table
		-- 	JOIN titles as t -- right table
		-- 		ON e.emp_no = t.emp_no -- Can use "USING (emp_no)" also since the column is the same and that way, the 'emp_no' column won't be repeated!
		-- WHERE e.emp_no IN (
		-- 		SELECT emp_no
		--         FROM titles as t
		-- )
		-- AND to_date > NOW()
		-- AND first_name = 'Aamod'						-- what I tried...
		;

select DISTINCT title 	-- Can do a group by but since we don't have a count (aggregate function), DISTINCT is fine!
from titles
	-- join employees	
		-- using (emp_no)		-- This JOIN is optional to check the names column to check my work but not necessary.
where emp_no IN 
		(
		select emp_no 		-- can throw inside my WHERE clause cause it's a SinGlE ColUmn!
		from employees
		where first_name = 'Aamod'
		)
AND to_date > now() -- same result with or without BUT it does state 'current' employees
;

-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.
-- 59,900 -- tricky one!!! -- 

select count(*) as cnt
from employees
where emp_no NOT IN -- filtering out the CurRenT employees
		(
		select emp_no
		from dept_emp
        -- where to_date like '9999%'
		where to_date > now() -- Do this first to see who is current, TheN remove them
		-- where to_date < now() -- This doesn't work because they may have changed departments or salaries... 
								-- So it loOkS like they are no longer working there but in reality, they just no longer work in ThAt depArTmeNt!
		)
;

-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.
				-- 4 rows -- 
select concat(first_name, ' ', last_name) as female_manager_current 	-- Could do an * or you can make it simpler, either is fine!
		, gender
from employees
where gender = 'F'
	and emp_no IN
		(
        select emp_no 			-- can't be * if I want to throw it into the WHERE clause
		from dept_manager
		where to_date > now()
        )
; 

-- 5. Find all the employees who currently have a higher salary than the 
-- company's overall, historical average salary.
			-- 154,543 employees
            
select count(*)	
from salaries
where to_date > now() 	-- don't have duplicate employees since I filTerEd to CurrEnt
	and salary >
		(
        select round(avg(salary),2)		-- if you round to 0, 3 people are CuT off
		from salaries
        )
;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary?
-- (Hint: you can use a built-in function to calculate the standard deviation.)
-- What percentage of all salaries is this?
			-- 83
			-- 0.0346%
-- Hint: You will likely use multiple subqueries in a variety of ways
-- Hint: It's a good practice to write out All of the small queries that you can. Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

		-- select std(salary)
		-- from salaries
		-- where to_date > now()
		-- ; -- 1 Standard Deviation -- 

		-- select max(salary)
		-- from salaries
		-- where to_date > now()
		-- ; -- CurrenT highest Salary -- 

select max(salary) - std(salary) AS cutoff -- this is the CutOfF point (140,910.04)
from salaries
where to_date > now()
; -- combined the above 2 queries into this one to find the cutoff (1 std away from the max)

select count(*)
from salaries
where salary >=
	( -- cutoff point ~140k
		select max(salary) - std(salary) AS cutoff -- this is the CutOfF point (140,910.04)
		from salaries
		where to_date > now()
    )
    AND to_date > now()
;	-- 83 current salaries (within 1SD of MAX)

select count(*)
from salaries
where to_date > now()
; -- 240,124 current salaries (all)

select 83/240124 * 100;

select
	(
	select count(*)
	from salaries
	where salary >=
		( -- cutoff point
		select max(salary) - std(salary) AS cutoff -- this is the CutOfF point (140,910.04)
		from salaries
		where to_date > now()
		)
		AND to_date > now()
		) -- my 83
/
	(
    select count(*)
	from salaries
	where to_date > now()
    ) -- my 240124
* 100
; -- 0.0346 Or 3.46%
    
-- BONUS

-- 1. Find all the department names that currently have female managers.
select first_name, last_name, gender, dept_name
from employees
	join dept_emp
		using (emp_no)
	join departments 
		using (dept_no)
where gender = 'F'
	and emp_no in 
		(
        select emp_no
		from dept_manager
		where to_date > now()
        )
;

-- 2. Find the first and last name of the employee with the highest salary.
select 
	first_name
    , last_name
    , salary
from employees
	join salaries
		on employees.emp_no = salaries.emp_no
where salary = 
	(
    select max(salary)
    from salaries
    )
;

-- 3. Find the department name that the employee with the highest salary works in.
select 
	first_name
    , last_name
    , salary
    , dept_name
from employees
	join salaries
		on employees.emp_no = salaries.emp_no
	join dept_emp
		on dept_emp.emp_no = employees.emp_no
	join departments
		on departments.dept_no = dept_emp.dept_no
where salary = 
	(
    select max(salary)
    from salaries
    )
;

-- 4. Who is the highest paid employee within each department.
select
	concat(first_name, ' ', last_name) as full_name
   , max_sal
   , dept_name
from 
	(
	select dept_name, max(salary) as max_sal
	from salaries
		join dept_emp
			using (emp_no)
		join departments
			using (dept_no)
	group by dept_name
    ) as ms
    join salaries as s
		on s.salary = ms.max_sal -- notice what this join is joining ON! 
        -- might need clarification on this later on ^
	join employees
		using (emp_no)
;