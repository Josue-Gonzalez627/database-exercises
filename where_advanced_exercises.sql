show databases;
use employees; 
select database();

show tables;

-- 1.) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' 
-- using IN. What is the employee number of the top three results?
SELECT first_name, emp_no
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
/*
A: The top 3 employee numbers are 10,200 , 10,397 , and 10610
*/
;

-- 2.) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
-- as in Q1, but use OR instead of IN. What is the employee number of the top three results? 
-- Does it match the previous question?
SELECT first_name, emp_no
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya'
/*
A: The top 3 employee numbers are 10,200 , 10,397 , and 10610. 
Yes it does match the previous question.
*/
;

-- 3.) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
-- using OR, and who is male. What is the employee number of the top three results?
Select *
FROM employees
WHERE gender = 'M'
	AND (
			first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya'
/*
A: The top 3 employee numbers are 10,200 , 10,397, 10,821
*/
);

-- 4.) Find all unique last names that start with 'E'.
Select DISTINCT last_name
FROM employees
WHERE last_name LIKE 'e%'
ORDER BY last_name
;

-- 5.) Find all unique last names that start or end with 'E'.
Select DISTINCT last_name
FROM employees
WHERE last_name LIKE 'e%'
	OR last_name LIKE '%e'
ORDER BY last_name
;

-- 6.) Find all unique last names that end with E, but does not start with E?
Select DISTINCT last_name
FROM employees
WHERE last_name NOT LIKE 'e%' -- Meaning does NOT start with E but the % means anything can be after
	AND last_name LIKE '%e' -- % meaning that it can have anything before but NOTHING after it ends with E
ORDER BY last_name
;

-- 7.) Find all unique last names that start and end with 'E'.
Select DISTINCT last_name
FROM employees
WHERE last_name LIKE 'e%' -- could also be simpler by puttling "LIKE 'e%e' in one line"
	and last_name LIKE '%e'
ORDER BY last_name asc
;

-- 8.) Find all current or previous employees hired in the 90s. 
-- Enter a comment with the top three employee numbers.
SELECT first_name, hire_date, emp_no
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
-- could also use "LIKE '199%' "     
-- could also be numeric " BETWEEN 19900101 AND 19991231"
-- WHERE year(hire_date) BETWEEN 1990 AND 1999 -- this is a function
/*
A: The top 3 employee numbers are 10,008 , 10,011 , and 10,012
*/
;

-- 9.) Find all current or previous employees born on Christmas. 
-- Enter a comment with the top three employee numbers.
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
/*
A: The top 3 employee numbers are 10,078 , 10,115 , and 10,261
*/
;

-- 10.) Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the top three employee numbers.
SELECT first_name, hire_date, birth_date, emp_no
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%12-25'
/*
A: The top 3 employee numbers are 10,261 , 10,438 , and 10,681
*/
;

-- 11.) Find all unique last names that have a 'q' in their last name.
SELECT DISTINCt last_name
FROM employees
WHERE last_name LIKE '%q%'
LIMIT 1900
;

-- 12.) Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
;

