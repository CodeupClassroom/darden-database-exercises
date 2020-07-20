use fruits_db;

# * means all columns
SELECT * from fruits;

# specify a single column
select name from fruits;

# Specify multiple columns with a comma
# comma between column names
select name, quantity from fruits;

USE employees;
SELECT * FROM employees;

SELECT first_name, last_name from employees;

# Select all columns from the employees table where the emp_no is 101010
SELECT *
from employees
WHERE emp_no = 101010;

# Show all employees with the emp_no under 12000
SELECT *
from employees
where emp_no < 12000;

# Show all employees with the emp_no less than or equal to 12000
SELECT *
from employees
where emp_no <= 12000;

# Show all the Georgis at this company
SELECT *
from employees
where first_name = 'Georgi';


# Show all the Georgis at this company who also have an emp_no less than 30,000
SELECT *
from employees
where first_name = 'Georgi'
and emp_no < 30000;


# Show all the Georgis at this company who have an emp_no less than 30,000
# And a hire date later than 1990-01-01
SELECT *
from employees
where first_name = 'Georgi'
and emp_no < 30000
and hire_date > '1990-01-01';


SELECT *
from salaries
where salary BETWEEN 67000 AND 72000;

SELECT *
from employees
where birth_date BETWEEN '1965-01-01' AND '1975-01-01';

# Find all February Birthdays
SELECT *
from employees
where birth_date LIKE '%-02-%';


# Find all February Birthdays who were hired in February
SELECT *
from employees
where birth_date LIKE '%-02-%'
and hire_date LIKE '%-02-%';


# Find all February Birthdays who were hired in February
SELECT *
from employees
where birth_date BETWEEN '1965-02-01' AND '1965-02-29';



# Another example of the string wildcard %
# Gotta use the like operator
SELECT * 
from employees
where first_name like 'georg%';

# % is any number
SELECT *
from employees
where last_name like 'w%';


SELECT *
from employees
where last_name like '%p';


SELECT * 
from employees
where last_name like 'q%t';

SELECT * 
from employees
where last_name like 'b%b';

SELECT * 
from employees
where last_name like '%b';


SELECT *
from employees
where first_name like "san%tonio";

# think of this as a print
SELECT "Howdy Darden!";

# alias our columns with "as"
SELECT birth_date as "DOB"
from employees;

# If you remove the "as", the aliasing still works
SELECT emp_no "employee_serial_number"
from employees;

# We can alias multiple columns
SELECT first_name as "First", last_name as "Last"
from employees;


# Aliases are the column name of the output
SELECT "Howdy, Darden" as "Greeting";

# Aliasing w/ a more complex example
select concat(first_name, " ", last_name) as "full_name"
from employees;
