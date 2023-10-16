-- MySQL provides a way to return only unique results from our queries with the keyword DISTINCT.


-- List the first 10 distinct last names sorted in descending order.
Select DISTINCT last_name
from employees
Order by last_name DESC
LIMIT 10
;

-- Find all previous or current employees hired in the 90s and born on Christmas. 
-- Find the first 5 employees hired in the 90's by sorting by hire date and 
-- limiting your results to the first 5 records. 
-- Write a comment in your code that lists the five names of the employees returned.
select first_name, last_name, hire_date
from employees
where birth_date like '%12-25'
	and hire_date like '199%'
order by hire_date
LIMIT 5
;

-- Try to think of your results as batches, sets, or pages. 
-- The first five results are your first page. 
-- The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results.
select first_name, last_name, hire_date
from employees
where birth_date like '%12-25'
	and hire_date like '199%'
order by hire_date
LIMIT 5 offset 45
;

-- LIMIT and OFFSET can be used to create multiple pages of data. 
-- What is the relationship between OFFSET (number of results to skip), 
-- LIMIT (number of results per page), and the page number?

-- A: (# of results per page * # of pages) - result of 1 page
		-- Using all three, you can asign how many pages your 'book' will have and how many results will be on each page. Then OFFSET will allow you to flip through the pages.