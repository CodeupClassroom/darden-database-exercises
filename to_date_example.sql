/*
These queries demonstrate how to break down the to_date column when it exists on multiple tables.
In this example, we'll use salaries and titles tables.
*/ 

-- All Salaries for employee 10004
-- 16 rows
select *
from employees
join salaries on salaries.emp_no = employees.emp_no
where employees.emp_no = 10004;

-- Current Salary for employee 10004
-- 1 row
select *
from employees
join salaries on salaries.emp_no = employees.emp_no
where employees.emp_no = 10004
and salaries.to_date > curdate();

-- Titles for employee 10004
-- 2 rows
select *
from employees
join titles on titles.emp_no = employees.emp_no
where employees.emp_no = 10004;

-- Current title
-- 1 row
select *
from employees
join titles on titles.emp_no = employees.emp_no
where employees.emp_no = 10004
and titles.to_date > now();


-- historic titles and salaries for employee 10004
-- 32 rows
select *
from employees
join titles on titles.emp_no = employees.emp_no
join salaries on salaries.emp_no = employees.emp_no
where employees.emp_no = 10004;


-- current salaries for employee 10004
-- w/ historic titles
-- 2 rows (because 2 titles)
select *
from employees
join titles on titles.emp_no = employees.emp_no
join salaries on salaries.emp_no = employees.emp_no
where employees.emp_no = 10004
and salaries.to_date > curdate();

-- current title for employee 10004
-- historic salaries 
-- 16 rows (b/c 16 different salaries over time)
select *
from employees
join titles on titles.emp_no = employees.emp_no
join salaries on salaries.emp_no = employees.emp_no
where employees.emp_no = 10004
and titles.to_date > curdate();


-- current salary for employee 10004
-- currrent title for employee 10004
-- 1 row
select *
from employees
join titles on titles.emp_no = employees.emp_no
join salaries on salaries.emp_no = employees.emp_no
where employees.emp_no = 10004
and titles.to_date > curdate()
and salaries.to_date > curdate();

