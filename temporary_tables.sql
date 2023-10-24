USE ursula_2334;
USE employees;

/* 1. Using the example from the lesson, create a temporary table called 
employees_with_departments that contains first_name, last_name, and dept_name 
 for employees currently with that department. Be absolutely sure to create this 
 table on your own database. If you see "Access denied for user ...", 
 it means that the query was attempting to write a new table 
 to a database that you can only read. */

DROP TABLE employees_with_departments; -- If I want to restart --

create temporary table if not exists employees_with_departments as
select
		e.first_name,
	e.last_name,
    d.dept_name
from employees.employees as e
join employees.dept_emp as de
		on e.emp_no=de.emp_no
join employees.departments as d
		on de.dept_no=d.dept_no;

					-- CREATE TEMPORARY TABLE IF NOT EXISTS employees_with_departments (
					-- 		emp_no INT PRIMARY KEY
					-- 	,first_name VARCHAR(50)
					--     ,last_name VARCHAR(50)
					--     ,dept_name VARCHAR(50)
					-- ); 					SUPPOSED TO HAVE USED EXISTING TABLES & COLUMNS

SELECT * FROM employees_with_departments;


	-- 1a. Add a column named full_name to this table. 
    -- It should be a VARCHAR whose length is the sum of the lengths of the 
    -- first name and last name columns.
ALTER TABLE employees_with_departments ADD column full_name VARCHAR(100);
SELECT * FROM employees_with_departments;
    
    
	-- 1b. Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);
SELECT * FROM employees_with_departments;


	-- 1c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
SELECT * FROM employees_with_departments;

    
    
	-- 1d. What is another way you could have ended up with this same table?
-- could have gotten this same answer via the select statement -- 
CREATE TEMPORARY TABLE ursula_2334.employees_with_departments AS
	SELECT emp_no, first_name, last_name, dept_no, dept_name
	FROM employees		-- could use 'employees.employees' here so we don't have to switch from database to database
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

DROP TABLE IF EXISTS ursula_2334.payment; -- If I want to restart --
USE sakila;
		-- CREATE TEMPORARY TABLE ursula_2334.payment AS
		-- 	SELECT amount
		--     FROM payment;
		--     
		-- USE ursula_2334;

		-- ALTER TABLE payment MODIFY amount DECIMAL(10,2);
		-- UPDATE payment SET amount = amount * 100;
		-- ALTER TABLE payment MODIFY amount INT; 
		-- SELECT * FROM payment;			
						-- MY WAY... worked but could've been better --


-- one way
-- step1
describe sakila.payment;
create temporary table sk_payments as
select
			payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,payment_date
        -- , CAST(amount *100 as int)
        ,amount
from sakila.payment;

select * from sk_payments;


-- second way
-- step 1
describe sakila.payment;
drop table sk_payments2;
create temporary table sk_payments2 as
select 
		 payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,payment_date
        ,amount*100 as amt_in_pennies
        ,amount
from sakila.payment;

select * from sk_payments2;
-- step 2
alter table sk_payments2 modify amt_in_pennies int;

select * from sk_payments2;
            

-- third way
-- step 1
drop table sk_payments3;
create temporary table sk_payments3 as
select 
		 payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,payment_date
        ,amount
from sakila.payment;

-- step 2
-- Alter the column
alter table sk_payments3
modify amount dec(10, 2);

-- step 3
-- Update the column
update sk_payments3
set amount = amount * 100;

-- As Int
ALTER TABLE sk_payments3 MODIFY amount int NOT NULL;


select * from sk_payments3;

/* 3. Go back to the employees database. 
Find out how the current average pay in each department compares to 
the overall current pay for everyone at the company. For this comparison, 
you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst? */


-- Overall current salary stats
select 
	avg(salary), 
    std(salary)
from employees.salaries 
where to_date > now();

-- 72,012 overall average salary
-- 17,310 overall standard deviation


-- Saving my values for later... that's what variables do (with a name)
-- Think about temp tables like variables
use employees;

drop table overall_aggregates;
-- get overall std 
create temporary table overall_aggregates as (
    select 
		avg(salary) as avg_salary,
        std(salary) as overall_std
    from employees.salaries  where to_date > now()
);

select * from overall_aggregates;


-- Let's check out our current average salaries for each department
-- If you see "for each" in the English for a query to build..
-- Then, you're probably going to use a group by..
-- want to compare each departments average salary to the overall std and overall avg salary

drop table current_info;
-- get current average salaries for each department
create temporary table current_info as (
    select 
		dept_name, 
        avg(salary) as department_current_average
    from employees.salaries s
    join employees.dept_emp de
		on s.emp_no=de.emp_no and 
        de.to_date > NOW() and 
        s.to_date > NOW()
    join employees.departments d
		on d.dept_no=de.dept_no
    group by dept_name
);

select * from current_info;


-- add on all the columns we'll end up needing:
alter table current_info add overall_avg float(10,2);
alter table current_info add overall_std float(10,2);
alter table current_info add zscore float(10,2);

-- set the avg and std
update current_info set overall_avg = (select avg_salary from overall_aggregates);
update current_info set overall_std = (select overall_std from overall_aggregates);


-- update the zscore column to hold the calculated zscores
update current_info 
set zscore = (department_current_average - overall_avg) / overall_std;


select * from current_info;

select 
	max(zscore) as max_score
from current_info 
where max(zscore) = .97
;





-- BELOW IS AS FAR AS I GOT -- FIGURED SOME INFO OUT BUT NOT ALL --
DROP TABLE IF EXISTS ursula_2334.overall_stats; -- If I want to restart --
USE employees;
USE ursula_2334;

-- Create temporary table to store overall average and standard deviation
CREATE TEMPORARY TABLE ursula_2334.overall_stats AS
	SELECT 
		AVG(salary) AS overall_avg_salary, 
		STDDEV(salary) AS overall_stddev_salary
	FROM salaries
	WHERE to_date > NOW();
    
SELECT * FROM overall_stats;

-- Calculate current average salary and current STD for each department
DROP TABLE ursula_2334.department_stats;

CREATE TEMPORARY TABLE ursula_2334.department_stats AS
	SELECT
		d.dept_name,
		AVG(s.salary) AS avg_department_salary,
		STDDEV(s.salary) AS stddev_department_salary
	FROM
		salaries AS s
		JOIN dept_emp AS de ON s.emp_no = de.emp_no
		JOIN departments AS d ON de.dept_no = d.dept_no
	WHERE s.to_date > NOW()
	GROUP BY d.dept_name;
SELECT * FROM department_stats;

USE employees;
SELECT * FROM departments;

-- Calculate z-score for each department
SELECT
    ds.dept_no,
    ds.avg_department_salary,
    ds.stddev_department_salary,
    (ds.avg_department_salary - os.overall_avg_salary) / os.overall_stddev_salary AS z_score
FROM
    department_stats ds
    CROSS JOIN overall_stats os
ORDER BY z_score DESC;

-- add on all the columns we'll end up needing:
alter table current_info add overall_avg float(10,2);

