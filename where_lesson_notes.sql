use employees;

-- Like enables the % string wildcard
SELECT first_name 
from employees 
where first_name like '%sus%';

SELECT DISTINCT first_name
from employees
where first_name like '%sus%';

SELECT * 
from salaries
where salary between 78000 AND 81000;


-- OR expands possibilities
SELECT *
FROM employees
WHERE last_name = "Herber"
OR last_name = "Dredge"
OR last_name = "Lipner"
OR last_name = "Baek";


-- Using the IN operator to match multiple (like OR)
SELECT *
FROM employees
WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');

-- NOT IN also works
SELECT *
FROM employees
WHERE last_name NOT IN ('Herber', 'Dredge', 'Lipner', 'Baek');

-- IN for numbers
SELECT *
FROM employees
WHERE emp_no IN (10001, 101010, 11111);

-- OR example that is the same as the above IN.
SELECT *
FROM employees
WHERE emp_no = 10001
OR emp_no = 101010
OR emp_no = 11111;


-- Can we use IN and LIKE together
SELECT * 
FROM employees
WHERE emp_no IN (10001, 101010, 11111)
AND first_name LIKE '%G%';

-- Show the not null to_date
SELECT emp_no, title
FROM titles
WHERE to_date IS NOT NULL;

-- Employees who have an employee number less than 20k
-- And who have a last name of Herber or Baek
-- OR anybody hired on July 21st
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name IN ('Herber', 'Baek')
AND emp_no < 20000
OR hire_date LIKE '%-07-21';


SELECT concat(first_name, " ", last_name)
FROM employees;

-- SELECT DISTINCT first_name last_name combinations
SELECT DISTINCT concat(first_name, " ", last_name)
FROM employees;


-- 256 rows w/o any parens
-- ORs expand possibilities
-- This query is the sum of the next 2 queries
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND last_name IN ('Herber','Baek')
  OR first_name = "Shridhar";

-- 14 rows  
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND last_name IN ('Herber','Baek');

-- 251
SELECT *
FROM employees
WHERE first_name = "Shridhar";
   

-- Parenthesis group expressions together
-- Exactly like math
-- so the expression in the parenthese is treated as one expression
-- 21 rows with the parens
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no < 20000
  AND (
      last_name IN ('Herber','Baek')
   OR first_name = 'Shridhar'
);
