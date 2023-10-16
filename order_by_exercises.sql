show databases;
use employees; 
select database();

show tables;

/* 1.) Find all employees with first names 'Irena', 'Vidya', or 'Maya',
and order your results returned by first name. In your comments, answer: 
What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table?*/
SELECT first_name, last_name, emp_no
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY first_name
/*
A: The Full name in the first row is Irena Reutenauer
The Full name in the last row is Vidya Simmen
*/
;

/* 2.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
and order your results returned by first name and then last name. 
In your comments, answer: What was the first and last name in the first row of the results?
What was the first and last name of the last person in the table?*/
SELECT first_name, last_name, emp_no
FROM employees
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya'
ORDER BY first_name, last_name
/*
A: The Full name in the first row is Irena Acton
The full name in the last row is Vidya Zweizig
*/
;

/* 3.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
and order your results returned by last name and then first name. 
In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table?*/
Select last_name, first_name, emp_no
FROM employees
WHERE first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya'
ORDER BY last_name, first_name 
/*
A: The Full name in the first row is Irena Acton
The Full name in the last row is Maya Zyda
*/
;

/* 4.) Write a query to find all employees whose last name starts and ends with 'E'.
Sort the results by their employee number. 
Enter a comment with the number of employees returned, 
the first employee number and their first and last name, 
and the last employee number with their first and last name.*/
Select last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'e%'
	and last_name LIKE '%e'
ORDER BY emp_no
/*
A: 899 rows/employees were returned.
The first employee number is 10,021 with the name Ramzi Erde
The last employee number is 499,648 with the name Tadahiro Erde
*/
;

/* 5.) Write a query to find all employees whose last name starts and ends with 'E'. 
Sort the results by their hire date, so that the newest employees are listed first. 
Enter a comment with the number of employees returned, 
the name of the newest employee, and the name of the oldest employee. */
SELECT first_name, last_name, hire_date, emp_no
FROM employees
WHERE last_name LIKE 'e%'
	and last_name LIKE '%e' -- or could also use 'e%e'
ORDER BY hire_date DESC
/*
A: 899 rows/employees were returned.
The newest employee is Teiji Eldridge
The oldest employee is Sergi Erde
*/
;

/* 6.) Find all employees hired in the 90s and born on Christmas. 
Sort the results so that the oldest employee who was hired last is the first result. 
Enter a comment with the number of employees returned, the name of the oldest employee 
who was hired last, and the name of the youngest employee who was hired first.*/
SELECT first_name, last_name, hire_date, birth_date, emp_no
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC
/*
A: 362 rows/employees were returned.
The full name of the oldest employee who was hired last is Khun Bernini
The full name of the youngest employee who was hired first is Douadi Pettis
*/
;

