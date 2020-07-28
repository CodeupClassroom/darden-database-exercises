-- Exercise Goals

-- Use CASE statements or IF() function to explore information 
-- in the employees database
USE employees;

/* Create a file named case_exercises.sql and craft queries to 
return the results for the following criteria:

1. Write a query that returns all employees (emp_no), 
their department number, their start date, 
their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not.
*/


# get the latest to_date
# get the max(1 or 0 ... whether currently employeed)
# group by employee number, meaning that we will one row per employee, 
# i.e. each observation (aka row) is an employee. 

SELECT dept_emp.emp_no
		, max(dept_emp.to_date) AS last_date_of_employment
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
FROM dept_emp
GROUP BY dept_emp.emp_no;

# add start date
SELECT dept_emp.emp_no
		, max(employees.hire_date) AS start_date
		, max(dept_emp.to_date) AS end_date
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
FROM dept_emp
JOIN employees USING(emp_no)
GROUP BY dept_emp.emp_no;


SELECT emp.emp_no, d.dept_no, emp.start_date, emp.end_date, emp.is_current_emp
FROM dept_emp d 
JOIN 
(SELECT dept_emp.emp_no # dept.dept_no
		, max(employees.hire_date) AS start_date
		, max(dept_emp.to_date) AS end_date
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
FROM dept_emp
JOIN employees USING(emp_no)
GROUP BY dept_emp.emp_no #, dept.dept_no
) emp
ON d.emp_no = emp.emp_no AND d.to_date = emp.end_date
;














/* Write a query that returns all employee names, 
and a new column 'alpha_group' 
that returns 'A-H', 'I-Q', or 'R-Z' depending on 
the first letter of their last name.
*/
USE employees;

SELECT first_name, last_name, substr(last_name, 1, 1) AS last_initial
    , CASE WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
        WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
        WHEN last_name REGEXP '^[R-Z]' THEN 'R-Z' 
        ELSE null
        END AS alpha_group 
FROM employees

SELECT first_name, 
	   last_name,
	   CASE WHEN SUBSTR(last_name, 1, 1) < 'I' THEN 'A-H'
	   		WHEN SUBSTR(last_name, 1, 1) < 'R' THEN 'I-Q'
	   		WHEN SUBSTR(last_name, 1, 1) > 'Q' THEN 'R-Z'
	   		ELSE null END AS alpha_group
FROM employees
ORDER BY alpha_group;


/* How many employees were born in each decade? 
*/

-- check out the range of birth dates first

SELECT MIN(birth_date), MAX(birth_date) FROM employees; 

SELECT 
	sum(CASE WHEN YEAR(birth_date) >= 1950 AND YEAR(birth_date) < 1960 THEN 1 ELSE null end) as fifties, 
	sum(CASE WHEN YEAR(birth_date) >= 1960 AND YEAR(birth_date) < 1970 THEN 1 ELSE null end) as sixties 
FROM employees;

SELECT COUNT(birth_date) AS employees, 
	CASE WHEN substr(birth_date, 3, 1) = 5 THEN 'fifties'
		WHEN substr(birth_date, 3, 1) = 6 THEN 'sixties'
		ELSE 'other' END AS decade
FROM employees
GROUP BY decade;


SELECT count(birth_date)
	, case when year(birth_date) between 1950 and 1959 then '1950s'
			when year(birth_date) between 1960 and 1969 then '1960s'
			else 'other' end as decades
FROM employees
group by decades;

select count(birth_date)
	, case when birth_date like '195%' then '1950s'
		when birth_date like '196%' then '1960s'
		end as birth_decade
FROM employees
group by birth_decade;

-- BONUS

/* What is the average salary for each of the following department groups: R&D, Sales & Marketing, 
Prod & QM, Finance & HR, Customer Service?
*/