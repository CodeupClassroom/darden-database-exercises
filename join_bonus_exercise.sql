--10. Bonus Find the names of all current employees, their department name, and their current manager's name.

-- In DB language: 
-- 1. get all employees who are CURRENTLY in a department 
-- (dept_emp, currently -> filter to_date), 
-- 2. and get their name (employees)
-- 3. and get their department name (departments)
-- 4. and add the current manager of each department (dept_manager) (departments, employees)
-- 5. tie those current managers to the employees' departments 

-- 1. 
SELECT de.emp_no, de.dept_no
FROM dept_emp AS de
WHERE de.to_date > curdate();

-- 2. GET EMP NAMES
SELECT de.emp_no, e.emp_no, de.dept_no, e.first_name, e.last_name
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
WHERE de.to_date > curdate();

-- 3. GET DEPT NAMES
SELECT de.emp_no, de.dept_no, e.first_name, e.last_name, d.dept_name
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE de.to_date > curdate();

-- 4. GET CURRENT MANAGER OF EACH DEPARTMENT
SELECT dm.emp_no, dm.dept_no
FROM dept_manager dm
WHERE dm.to_date > curdate();

-- 5. TIE THE MANAGERS DEPARTMENTS WITH THE CURRENT EMPLOYEES DEPARTMENTS, I.E. JOIN
SELECT de.emp_no
        , de.dept_no
        , e.first_name
        , e.last_name
        , d.dept_name
        , dm.emp_no AS mgr_emp_no
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no AND dm.to_date > curdate()
WHERE de.to_date > curdate();

-- 6. get managers name by joining manager employee number on employees table
SELECT de.emp_no
        , de.dept_no
        , e.first_name
        , e.last_name
        , d.dept_name
        , dm.emp_no AS mgr_emp_no
        , ee.first_name AS mgr_first
        , ee.last_name AS mgr_last
FROM dept_emp AS de
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no AND dm.to_date > curdate()
JOIN employees AS ee ON dm.emp_no = ee.emp_no
WHERE de.to_date > curdate();

-- 7. clean it up to make it look as requested

SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name
        , d.dept_name
        , CONCAT(manager_emp.first_name, ' ', manager_emp.last_name) AS manager_name
FROM dept_emp AS de
JOIN employees AS emp ON de.emp_no = emp.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no 
        AND dm.to_date > curdate()
JOIN employees AS manager_emp ON dm.emp_no = manager_emp.emp_no
WHERE de.to_date > curdate();


SELECT DISTINCT sub.dept_name
FROM (

SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name
        , d.dept_name
        , CONCAT(manager_emp.first_name, ' ', manager_emp.last_name) AS manager_name
FROM dept_emp AS de
JOIN employees AS emp ON de.emp_no = emp.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON de.dept_no = dm.dept_no 
        AND dm.to_date > curdate()
JOIN employees AS manager_emp ON dm.emp_no = manager_emp.emp_no
WHERE de.to_date > curdate()

) AS sub;