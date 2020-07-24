-- Subquery means a query that hits another query
-- Subquery using WHERE column_a in (select column_a from ...)
-- Subqueries that use WHERE column_a in (select column_a) are SUPER fast, but we don't have all the columns available from the inner query...
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE salary BETWEEN 60000 AND 70000
	AND to_date > now()
)
AND emp_no IN (
    SELECT emp_no
    from dept_manager
);


-- Another way to do subqueries
-- we can use a subquery as the FROM instead of a table
-- derived table is what's we call it when we select from another query
-- derived table benefits == more flexibility
-- derived table costs == more computational complexity
-- we have to alias a derived table (even if we don't use the alias later)
SELECT *
FROM (
	select salary, emp_no
	from salaries 
 	where salary between 60000 and 70000
) as salary_between_60_and_70
JOIN dept_emp ON dept_emp.emp_no = salary_between_60_and_70.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no;



