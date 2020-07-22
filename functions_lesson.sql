
# STRING functions

SELECT CONCAT("Today is", " Blursday", "!");

USE employees;

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE CONCAT(first_name, " ", last_name) NOT LIKE 'M% G%';

# can we reference the alias column name "full_name" in the where clause? 
# NO because that has not been computed yet...where is computed before the alias of the concat function. 
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE full_name NOT LIKE 'M% G%';

# SUBSTRING
# substr(string, start_index, length)
SELECT SUBSTR('codeup', 1, 4);

# get first initial of names
SELECT SUBSTR(first_name, 1, 1) AS first_initial FROM employees;

# get first & last initials
# here we can reference the alias 'initials', because order by is the last action that is performed. 
SELECT CONCAT(SUBSTR(first_name, 1, 1), ".", SUBSTR(last_name, 1, 1), ".") AS initials
FROM employees
ORDER BY initials;

# to access the last letter, use -1
SELECT SUBSTR(first_name, -1, 1) FROM employees;

SELECT SUBSTR(first_name, 3, 2) FROM employees;

# case conversion

SELECT UPPER(first_name) AS first_upper, LOWER(first_name) AS first_lower 
FROM employees
WHERE UPPER(first_name) = LOWER(first_name)
; 

# REPLACE 
# REPLACE(string, substring, replacement)
# REPLACE 'substring' with 'replacement' in 'string'

SELECT REPLACE('Margaret', 'rgaret', 'ggie') AS my_name;

SELECT REPLACE(first_name, 'a', 'b') AS changed_first_name 
FROM employees;

SELECT first_name, REPLACE(first_name, 'a', 'b') AS changed_first_name 
FROM employees
WHERE first_name != REPLACE(first_name, 'a', 'b');


# what is the date/time right now?
SELECT NOW();

# what is the current date (no time)?
SELECT CURDATE();

#what is the current time, UTC (no date)?
SELECT CURTIME();

# UNIX_TIMESTAMP: since Jan 1, 1970

SELECT UNIX_TIMESTAMP() AS seconds_since_01011970, UNIX_TIMESTAMP('2014-02-04') AS seconds_from_01011970_to_02042014, CONCAT('Teaching people to code for ', UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'), 'seconds');

# format for date in unix_timestamp must be %Y-%m-%d

# datediff(most_recent_date, earliest_date) returns in number of days between. 
SELECT datediff(CURDATE(), '2014-02-04') * 24;

# this gives a slightly different value, in terms of hours it appears, but more research on how it's computed. 
SELECT CURDATE() - DATE('2014-02-04');


# numerical functions

SELECT * FROM salaries LIMIT 10;

SELECT AVG(salary) FROM salaries;

SELECT MIN(salary) AS min_salary, MAX(salary) as max_salary, AVG(salary) AS avg_salary FROM salaries;

# casting

SELECT 1 + '4', '3' - 1, CONCAT('Here is a number: ', 123);

SELECT CAST(123 AS CHAR), CAST('123' AS UNSIGNED);
