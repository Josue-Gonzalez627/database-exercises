-- List all the databases
SHOW databases;

-- write the SQL code necessary to use the albums_db database
USE albums_db; -- This command selects the database

-- Show the currently selected database
SELECT database(); -- This command is used to Verify which database is currently selected

SHOW CREATE DATABASE albums_db; -- Find out the query used to create the database

-- List all tables in the database
SHOW TABLES;

-- Write the SQL code to switch to the employees database
USE employees;

-- Show the currently selected database
SELECT database();

SHOW TABLES;
-- Explore the 'employees' table. What different data types are present in this table?
DESCRIBE employees;
	-- I see INT, DATE, VARCHAR(14), VARCHAR(16), and ENUM('M','F')
    
    
DESCRIBE  departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
-- Which table(s) do you think contain a numeric type column?
	-- Salaries makes the most sense but employee numbers are also INT and are found in all tables except 'departments'
    -- A: dept_emp, dept_manager, employees, Salaries, titles

-- Which table(s) do you think contain a string type column?
	-- Departments because of their names, Employees for their information, and Titles.
    -- A:departments, dept_emp, dept_manager, employees, titles

-- Which table(s) do you think contain a date type column?
	-- Both dept_ tables to show how long those employees/managers where in that department or if they still are.
    -- employees to show the date hired. Titles also to show time in the position.
    -- Salaries to show how much was earned in what year.
    -- A: dept_emp, dept_manager, employees, salaries, titles
    
-- What is the relationship between the employees and the departments tables?
	-- They both use string columns to label their employees/departments but only employees use a numeric type for their...
    -- ... employee number column while department uses a string in their department number column due to it including a letter at the beginning.
    -- Their relationship was also most likely used to create the 'dept_emp' table, as it contains information from both.
    
    -- A: There is no similar comuns betweent the two, but we know that...
    -- A: ... employees should be linked to a department somehow.

DESCRIBE dept_emp;
	-- This has a composit key that will combine our employees and departments tables together
    
    
-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.

SHOW CREATE TABLE dept_manager;
			-- Use hotkey 'command ?' to quote the code below after highlighting
-- CREATE TABLE `dept_manager` (
-- 	  `emp_no` int NOT NULL,
-- 	  `dept_no` char(4) NOT NULL,
-- 	  `from_date` date NOT NULL,
-- 	  `to_date` date NOT NULL,
-- 	  PRIMARY KEY (`emp_no`,`dept_no`),
-- 	  KEY `dept_no` (`dept_no`),
-- 	  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
-- 	  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- 	) ENGINE=InnoDB DEFAULT CHARSET=latin1

