CREATE TEMPORARY TABLE current_employee_salaries AS
SELECT employees.employees.emp_no, employees.employees.first_name, employees.employees.last_name, employees.salaries.salary
FROM employees.salaries
JOIN employees.employees on employees.employees.emp_no = employees.salaries.emp_no
WHERE to_date > curdate();

SELECT * 
FROM current_employee_salaries;

-- employees hired in october 31st, 1992
CREATE TEMPORARY TABLE halloween AS
SELECT e.first_name, e.last_name, e.hire_date
FROM employees.employees as e
WHERE e.hire_date = '1992-10-31';

SELECT * from halloween;


-- Names and salaries of managers...
CREATE TEMPORARY TABLE managers AS 
SELECT e.first_name, e.last_name, s.salary
FROM employees.employees as e
JOIN employees.dept_manager as dm ON dm.emp_no = e.emp_no
JOIN employees.salaries as s ON s.emp_no = dm.emp_no
WHERE s.to_date > curdate()
AND dm.to_date > curdate();

SELECT * from managers;
