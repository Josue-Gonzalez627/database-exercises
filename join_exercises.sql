

-- Use the join_example_db. 
USE join_example_db; 

-- Select all the records from both the users and roles tables.
select * from users;
select * from roles;


-- Use join, left join, and right join to combine results from the users 
-- and roles tables as we did in the lesson. Before you run each query, 
-- guess the expected number of results.

-- will return all users who have roles --
-- due to no nulls being returned from inner joins -- 
select *
from roles r
join users u -- can't use "USE" 
	ON r.id=u.role_id
;
    
-- in a left join, I can expect to return all roles even if they --
-- don't have users --

select *
from roles r
left join users u -- can't use "USE" 
	ON r.id = u.role_id
;

select *
from roles r
right join users u
	ON r.id=u.role_id
;
-- Although not explicitly covered in the lesson, 
-- aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along 
-- with the number of users that have the role. 
-- Hint: You will also need to use group by in the query.

-- count number of user --

select 
	COUNT(u.id) -- to explicitly count users (don't use * here)
    ,r.name
from roles r
left join users u 
	ON r.id=u.role_id
GROUP BY r.name
; 

-- 1. Use the employees database.
use employees;

-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name 
-- of the current manager for that department.

describe departments;
describe employees;
describe dept_manager;

select 
	d.dept_name as 'Department Name',
    concat(e.first_name,' ',e.last_name) as 'Department Manager'
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no and
    dm.to_date > NOW()
join employees e
	on e.emp_no=dm.emp_no
order by dept_name
-- where dm.to_date like '9999-%';   --These two options could also be used rather than
									 -- the 1st 'on' where the 'and' is
-- where dm.to_date > NOW();
;

-- 3. Find the name of all departments currently managed by women.
describe employees;
describe departments;
describe dept_manager;

select 
	d.dept_name as 'Department Name',
    concat(e.first_name,' ',e.last_name) as 'Manager Name'
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no and
    dm.to_date > NOW()
join employees e
	on e.emp_no=dm.emp_no
where e.gender = 'F'
order by dept_name
;

-- 4. Find the current titles of employees currently 
-- working in the Customer Service department.
describe titles; -- emp_no
describe dept_emp; -- emp_no & dept_no
describe departments; -- dept_no

select
	t.title as Title,
    COUNT(de.emp_no) as Count
from titles t
join dept_emp de
	on t.emp_no=de.emp_no and
    t.to_date > NOW() and
    de.to_date > NOW() -- this is an alternative to putting it in the 'where' clause
join departments d
	on d.dept_no=de.dept_no
where d.dept_name = 'Customer Service'
group by t.title
order by t.title
;

-- 5. Find the current salary of all current managers.
describe salaries; -- emp_no
describe dept_manager; -- emp_no & dept_no
describe employees; -- emp_no
describe department;

select 
	d.dept_name as 'Department Name',
	concat(e.first_name,' ',e.last_name) as 'Name',
	s.salary Salary -- don't have to us 'as'
from salaries s
join dept_manager dm
	on s.emp_no=dm.emp_no and
    dm.to_date > NOW() and
    s.to_date > NOW()
join employees e
	on e.emp_no=dm.emp_no
join departments d
	on d.dept_no=dm.dept_no
order by d.dept_name
;

-- 6. Find the number of current employees in each department.
describe dept_emp; --
describe departments; --

select
	d.dept_no, 
    d.dept_name,
    COUNT(de.dept_no) as num_employees
from departments d
join dept_emp de
	on d.dept_no=de.dept_no and
    de.to_date > NOW()
group by d.dept_no,d.dept_name
order by d.dept_no
;

-- 7. Which department has the highest average salary? 
-- Hint: Use current not historic information.
describe departments; -- dept_no
describe salaries; -- emp_no
describe dept_emp; -- emp_no & dept_no

SELECT
	d.dept_name,
		round(AVG(s.salary),2) as average_salary -- Using 'round' to get 2 decimal places but answer didn't require it
FROM departments d
JOIN dept_emp de
	ON d.dept_no=de.dept_no and
    de.to_date > NOW()
JOIN salaries s
	ON s.emp_no=de.emp_no and
    s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1
;
	

-- 8. Who is the highest paid employee in the Marketing department?
describe employees; -- emp_no
describe salaries; -- emp_no
describe department; -- dept_no
describe dept_emp; -- dept_no & emp_no (associative table)

select
	e.first_name,
    e.last_name,
from employees e
join salaries s
	on e.emp_no=s.emp_no and
join dept_emp de
	on de.emp_no=e.emp_no and
join departments d
	on d.dept_no=de.dept_no
where d.dept_name = 'Marketing'
order by s.salary DESC
limit 1
; -- COME BACK TO THIS ONE ON REPO (NOT RUNNING) --

-- 9. Which current department manager has the highest salary?
describe dept_manager;
describe salaries;
describe departments;
describe employees;

select
	e.first_name,
    e.last_name,
    s.salary,
    d.dept_name
from employees e
join salaries s
	on e.emp_no=s.emp_no and
    s.to_date > NOW()
join dept_manager dm
	on dm.emp_no = e.emp_no and
    dm.to_date > NOW()
join departments d
	on d.dept_no=dm.dept_no
where d.dept_name = 'Marketing'
order by s.salary DESC
limit 1
;

-- 10. Determine the average salary for each department. 
-- Use all salary information and round your results.
describe salaries;
describe departments;
describe dept_emp;

select
	d.dept_name,
    ROUND(AVG(s.salary),0) average_salary
from salaries s
join dept_emp de
	on s.emp_no=de.emp_no
join departments d
	on d.dept_no=de.dept_no
group by d.dept_name
order by average_salary desc
;

-- 11. Bonus Find the names of all current employees, their department name, 
-- and their current manager's name.

-- SELF JOIN WAY --

describe employees; -- 
describe departments; --
describe dept_manager; -- 
describe dept_emp; --

select
		concat(e.first_name,' ',e.last_name) as 'Employee Name',
    d.dept_name AS 'Department Name',
    CONCAT(managers.first_name, ' ', managers.last_name) AS 'Manager_name'
    
from employees e
join dept_emp de
	on e.emp_no=de.emp_no
join departments d
	on d.dept_no=de.dept_no
join dept_manager dm
	on dm.dept_no=de.dept_no and
    dm.to_date > NOW()
-- Join employees again as managers to get manager names.
JOIN employees AS managers
	ON managers.emp_no = dm.emp_no
WHERE de.to_date > CURDATE()
ORDER BY d.dept_name
;

-- SUBQUERY WAY --
select
    concat(e.first_name,' ',e.last_name) as 'Employee Name',
    d.dept_name AS 'Department Name',
    m.managers AS 'Manager_name'
    
from employees e
join dept_emp de
	on de.emp_no=e.emp_no and
	de.to_date > CURDATE()
join departments d
	on de.dept_no=d.dept_no
join (SELECT
		dm.dept_no,
		CONCAT(e.first_name, ' ', e.last_name) AS managers
	FROM employees AS e
	JOIN dept_manager AS dm
		ON e.emp_no = dm.emp_no AND
		to_date > CURDATE()) AS m
	ON m.dept_no = d.dept_no
ORDER BY d.dept_name;
