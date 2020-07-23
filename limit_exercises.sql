# Add the LIMIT clause to our existing queries

# Create a new SQL script named limit_exercises.sql.

# MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

USE employees;

SELECT DISTINCT title FROM titles;

# List the first 10 distinct last name sorted in descending order. 

SELECT DISTINCT last_name 
FROM employees 
ORDER BY last_name DESC 
LIMIT 10;

-- /* # Your result should look like this:
/* Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker */

# Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. 

SELECT * FROM employees
WHERE hire_date > '1990' AND hire_date < '2000' AND birth_date like '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;

# Their names should be:
/* Khun Bernini
Pohua Sudkamp
Xiaopeng Uehara
Irene Isaak
Dulce Wrigley */


# Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. 

# PAGE = ??

# LIMIT = 5, OFFSET = 0, PAGE = 1
# LIMIT = 5, OFFSET = 5, PAGE = 2
# LIMIT = 5, OFFSET = 10, PAGE = 3
# PAGE = (L + O)/L
# (page - 1)*limit = offset
# Soooo, if limit = 5 (given in instructions) and page = 10, what is offset? 
# (10 - 1)*5 = 45

SELECT * FROM employees
WHERE hire_date > '1990' AND hire_date < '2000' AND birth_date like '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;

# The employee names should be:
/* Piyawadee Bultermann
Heng Luft
Yuqun Kandlur
Basil Senzako
Mabo Zobel */

# LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

