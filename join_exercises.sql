use employees;

select title, count(title) as count
from titles
join dept_emp on dept_emp.emp_no = titles.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where titles.to_date > curdate()
and dept_emp.to_date > curdate()
and departments.dept_name = 'Customer Service'
group by title;

-- Find the name of all departments currently managed by women.
select e.first_name, e.last_name
from employees e
join dept_manager dm on dm.emp_no = e.emp_no
join departments d on d.dept_no = dm.dept_no
where dm.to_date > curdate()
and gender = 'f';


-- Find the current titles of employees currently working in the Customer Service department.
select t.title, count(*)
from titles as t 
join dept_emp as de on de.emp_no = t.emp_no
join departments d on de.dept_no = d.dept_no
where de.to_date > curdate()
and t.to_date > curdate()
and d.dept_name = "Customer Service"
group by t.title;




-- Find the current salary of all current managers.
-- dept_name, employee name, salary for current managers
select dept_name, first_name, last_name, salary
from employees
join dept_manager using(emp_no)
join departments using(dept_no)
join salaries using(emp_no)
where dept_manager.to_date > curdate()
and salaries.to_date > curdate()
order by dept_name;


-- Find the number of employees in each department.
select dept_no, dept_name, count(*)
from departments
join dept_emp using(dept_no)
where dept_emp.to_date > curdate()
group by dept_no;



-- Which department has the highest average salary?
select dept_name, avg(salary) as "Highest Avg Salary of All Departments"
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()
group by dept_no
order by avg(salary) desc
limit 1;


/* Who is the highest paid employee in the Marketing department?
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   | */
select first_name, last_name
from employees
join dept_emp using(emp_no)
join departments using(dept_no)
join salaries using(emp_no)
where dept_name = "Marketing"
order by salary desc
limit 1;

/* Which current department manager has the highest salary?
 +------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing | */

select first_name, last_name, salary, dept_name
from employees
join dept_manager using(emp_no)
join salaries using(emp_no)
join departments using(dept_no)
where salaries.to_date > curdate()
and dept_manager.to_date > curdate()
order by salary desc
limit 1;
