use employees;

SELECT *
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya');

SELECT *
FROM employees 
WHERE last_name like 'E%';

SELECT * 
FROM employees
WHERE hire_date LIKE '199%';

SELECT * 
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- Find all employees born on Christmas — 842 rows.
SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';

-- Find all employees with a 'q' in their last name — 1,873 rows.
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

-- Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
SELECT *
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Maya'
OR first_name = 'Vidya';

-- Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
SELECT *
FROM employees
WHERE gender = "M"
AND (
first_name = 'Irena'
OR first_name = 'Maya'
OR first_name = 'Vidya'
);

-- A and B == B and A
-- A + B == B + A
SELECT *
FROM employees
WHERE (
first_name = 'Irena'
OR first_name = 'Maya'
OR first_name = 'Vidya'
) 
AND gender = "M";


-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
OR last_name LIKE '%e';


-- Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT *
FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e';

SELECT *
FROM employees
WHERE last_name LIKE 'e%e';

-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT * 
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';

-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';

-- Find employees hired on Halloween and born in Oct
SELECT *
FROM employees
WHERE hire_date LIKE '%-10-31'
AND birth_date LIKE '%-10-%';