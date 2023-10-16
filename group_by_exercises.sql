show databases;
use employees;
select database();
show tables;
-- 1. Create a new file named group_by_exercises.sql

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles
;

-- 3. Write a query to find a list of all unique last names that start 
-- and end with 'E' using GROUP BY.


-- 4. Write a query to to find all unique combinations of first and last names 
-- of all employees whose last names start and end with 'E'.


-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.


-- 6. Add a COUNT() to your results for exercise 5 to find the 
-- number of employees with the same last name.


-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) 
-- and GROUP BY to find the number of employees with those names for each gender.


-- 8. Using your query that generates a username for all employees, 
-- generate a count of employees with each unique username.


-- 9. From your previous query, are there any duplicate usernames? 
-- What is the highest number of times a username shows up? 
-- Bonus: How many duplicate usernames are there?


