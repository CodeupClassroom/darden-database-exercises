USE employees;

-- order by first_name
SELECT *
FROM employees
ORDER BY first_name;

SELECT *
FROM employees
ORDER BY first_name, last_name;

-- ASC == ascending == default
SELECT * 
FROM employees
order by first_name ASC;

-- DESC == descending
SELECT * 
FROM employees
order by first_name DESC, last_name DESC;


-- DESC == descending
SELECT * 
FROM employees
order by first_name DESC, hire_date ASC;



