use employees;

-- select all columns from employees and salaries
SELECT *
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;

-- Let's find employee 10001's current salary
SELECT *
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE employees.emp_no = 10001
AND salaries.to_date > curdate();


-- Find titles and full_names of employees
-- A = B is the same as B = A
SELECT first_name, last_name, title
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no;


USE join_example_db;

-- INNER JOIN is the default when you say JOIN
-- Logically the same as "AND"
-- No nulls from anywhere
-- ONLY users who have roles, ONLY roles who have users
SELECT * 
FROM users
JOIN roles on roles.id = users.role_id;


-- Left join keeps all records from the first table mentioned in your FROM table_name
SELECT *
FROM users 
LEFT JOIN roles on roles.id = users.role_id;


-- Left join keeps all records from the first table mentioned...
-- Show me roles and users... but also show me roles who have no user or a null..
SELECT * 
FROM roles
LEFT JOIN users on roles.id = users.role_id;

-- Same result as above
-- KEEP all the roles whether or not they have a user.
SELECT * 
FROM users
RIGHT JOIN roles on roles.id = users.role_id;


-- SELECT from table A left join table B left join table C ....

USE employees;

-- Write the query to provide the full_name, salary, and title for every employee
SELECT concat(first_name, ' ', last_name) as full_name,
	salary,
	title
FROM employees
JOIN salaries on salaries.emp_no = employees.emp_no
JOIN titles on titles.emp_no = employees.emp_no
WHERE concat(first_name, ' ', last_name) = 'Georgi Facello';


-- find the hire date and name of the person with the highest salary
-- Make sure you're filtering w/ where clauses 
-- if you have multiple tables w/ a to_date, filter by each table
SELECT *
from departments
join dept_emp on dept_emp.dept_no = departments.dept_no
join employees on employees.emp_no = dept_emp.emp_no
join salaries on salaries.emp_no = employees.emp_no
join titles on titles.emp_no = employees.emp_no
WHERE titles.to_date > curdate()
and salaries.to_date > curdate()
and dept_emp.to_date > curdate();

-- Same results as above
SELECT *
from departments
join dept_emp on dept_emp.dept_no = departments.dept_no
join employees on employees.emp_no = dept_emp.emp_no and dept_emp.to_date > curdate()
join salaries on salaries.emp_no = employees.emp_no and salaries.to_date > curdate()
join titles on titles.emp_no = employees.emp_no and titles.to_date > curdate();