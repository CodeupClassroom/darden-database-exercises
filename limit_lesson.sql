use employees;

-- Limit 10 means, 1-10 including 10.
-- Page 1 of our results
SELECT *
FROM employees
LIMIT 10;

-- Limit 10 means, 1-10 including 10.
-- OFFSET 0 (default)
-- Page 1
SELECT *
FROM employees
LIMIT 10 OFFSET 0;

-- Page 2 of our results should show 11-20
SELECT *
FROM employees
LIMIT 10 OFFSET 10;

-- Page 3 of our results 21-30
SELECT * 
FROM employees
LIMIT 10 OFFSET 20;

-- Page 4 of our results 31-40
SELECT * 
FROM employees
LIMIT 10 OFFSET 30;

-- see the last 10 employees (by emp_no)
select * 
from employees
ORDER BY emp_no DESC
limit 10;


-- The second to the last set of 10
select * 
from employees
ORDER BY emp_no DESC
limit 10 OFFSET 10;

