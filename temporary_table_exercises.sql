-- Exercise 1

SELECT e.emp_no, 
concat(e.first_name, ' ', e.last_name) as full_name,
e.birth_date,
e.hire_date,
e.gender,
d.dept_name,
d.dept_no,
de.from_date,
de.to_date
from employees.employees as e
join employees.dept_emp as de using(emp_no)
join employees.departments as d using(dept_no);


-- Exercise 2
-- Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

-- Step 1
CREATE TEMPORARY TABLE payments AS 
select *
from sakila.payment;

-- Step 2 - set the integer datatype
ALTER TABLE payments modify amount INT UNSIGNED;

-- Step 3 - update to hold the 
UPDATE payments
set amount = amount * 100;

-- Here's what I'd do to keep the original data intact
CREATE TEMPORARY TABLE payments AS 
select *, amount * 100 as pennies
from sakila.payment;

ALTER TABLE payments modify pennies INT UNSIGNED;


-- Exercise 3
-- zscore = (x - mean) / stdev(x)
-- +--------------------+-----------------+
-- | dept_name          | salary_z_score  | 
-- +--------------------+-----------------+
-- | Customer Service   | -0.273079       | 
-- | Development        | -0.251549       | 
-- | Finance            |  0.378261       | 
-- | Human Resources    | -0.467379       | 
-- | Marketing          |  0.464854       | 
-- | Production         | -0.24084        | 
-- | Quality Management | -0.379563       | 
-- | Research           | -0.236791       | 
-- | Sales              |  0.972891       | 
-- +--------------------+-----------------+

CREATE TABLE emps AS
SELECT
	e.*,
	s.salary,
	d.dept_name AS department,
	d.dept_no
FROM employees.employees as e
JOIN employees.salaries s USING (emp_no)
JOIN employees.dept_emp de USING (emp_no)
JOIN employees.departments d USING (dept_no);

SELECT * FROM emps LIMIT 50;

ALTER TABLE emps ADD mean_salary FLOAT;
ALTER TABLE emps ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;


CREATE TEMPORARY TABLE salary_aggregates AS
SELECT
	AVG(salary) AS mean,
	STDDEV(salary) AS sd
FROM emps;

SELECT * FROM salary_aggregates;

UPDATE emps SET mean_salary = (SELECT mean FROM salary_aggregates);
UPDATE emps SET sd_salary = (SELECT sd FROM salary_aggregates);	
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;

SELECT
	department,
	AVG(z_salary) AS z_salary
FROM emps
GROUP BY department
ORDER BY z_salary;