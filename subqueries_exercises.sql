use employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query.
-- 69 Rows

SELECT *
FROM employees
WHERE hire_date = (
    SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
);

-- Find all the titles held by all employees with the first name Aamod.
-- 314 total titles, 6 unique titles
SELECT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
);


SELECT DISTINCT title as "Distinct Titles"
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
);

SELECT title, count(*)
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod"
)
GROUP BY title;


-- How many people in the employees table are no longer working for the company?
-- employees table has names, but no info on if they're still an employee
-- dept_emp table associates emp_no with a dept_no at a given time.
-- first step = figure out who currently works for the company
SELECT *
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate()
);


-- Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees 
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender = 'F'
	)
	AND to_date > CURDATE()
);


-- Find all the employees that currently have a higher than average salary.

SELECT first_name, last_name, salary
FROM employees
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE salary > (
	SELECT AVG(salary)
	FROM salaries
)
AND to_date > curdate();


-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- 78 salaries

-- step 1, find the max salary
-- 158220
SELECT max(salary)
FROM salaries;

-- step 2, find the standard deviation
-- 16904.8282
SELECT STDDEV(salary)
FROM salaries;

-- write the query w/ hardcoded values to ensure we get the answer
-- but now we have to make it programmatic
SELECT *
FROM salaries
WHERE salary > (158220 - 16904.8282)
AND to_date > curdate();

-- Replace the hard-coded values with the code that does the work
SELECT *
FROM salaries
WHERE salary >= 
(
	(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
)
AND to_date > curdate();

-- What percentage of salaries is this?
	SELECT count(*) as "num_salaries_1_stddev_below_max", 
	(count(*) / (SELECT count(*) FROM salaries)) * 100 as "percentage_of_current_salaries"
	FROM salaries
	WHERE salary >= 
	(
		(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
	)
	AND to_date > curdate();

