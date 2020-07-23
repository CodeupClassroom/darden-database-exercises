USE employees;

# look at entire table...we see 443,308 rows on bottom bar
SELECT *
FROM titles;

# count is purely counting the rows, whether we count all columns through * 
# or specify a column, we will get the same result and it will equal the 443,308
# from above. 
SELECT COUNT(*), COUNT(title)
FROM titles;

# there are 107,391 titles of "Staff"
SELECT title
FROM titles
WHERE title = 'Staff';

# we get the same result bc we are simply counting all rows of staff. 
SELECT COUNT(title)
from titles
WHERE title = 'Staff';

# there are 107,415 rows of staff or manager title...
SELECT title
FROM titles
WHERE title IN ('Staff', 'Manager');

# but how mnay rows are staff and how many are manager? 
# we see 24 rows of manager & what we expect, 107,391 rows of Staff. 
SELECT title, COUNT(title)
FROM titles
WHERE title IN ('Staff', 'Manager')
GROUP BY title;

# count number of rows for each title
SELECT title, COUNT(title) as total
FROM titles
GROUP BY title;

# I want to sum the total counts for each title 
# from the query above (seen in a subquery) to show 
# the it matches the total number of rows we found above 
# when we ran count(title) without any filters or groups. 
SELECT SUM(subtotal.total) AS total_rows
	FROM (SELECT title, COUNT(title) as total
		FROM titles
		GROUP BY title
	) AS subtotal;

# count is counting the number of rows, so not specifying a column is ok, you can use *
# sum, average, stddev, min, max, etc. are all working on the values within the columns so you must specify the column name. 

SELECT *
FROM salaries
LIMIT 50;

# Create a new file named group_by_exercises.sql

# In your script, use DISTINCT to find the unique titles in the titles table. 
USE employees;

SELECT DISTINCT title
FROM titles;


/* Your results should look like:
Senior Engineer
Staff
Engineer
Senior Staff
Assistant Engineer
Technique Leader
Manager */


# Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. 
# you can see that using group by (without distinct) will return same results as distinct (without group by)

SELECT last_name 
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

/* The results should be:

Eldridge
Erbe
Erde
Erie
Etalle */

# Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.

SELECT CONCAT(first_name, ' ', last_name) AS unique_full_names
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY unique_full_names ASC;
# group by first_name, last_name ASC;

# Find the unique last names with a 'q' but not 'qu'. 
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/* Your results should be:

Chleq
Lindqvist
Qiwen */

# Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(last_name);


# Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 

SELECT COUNT(*), gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

/* Your results should be:

441 M
268 F */


# Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?

# Run without distinct or group by and getting count of usernames
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name
FROM employees; 

# run with distinct or group by and get count of usernames
# we can see the counts are different...there are fewer distinct than total
# therefore there are duplicates. 
# we could use distinct or group by, 
SELECT DISTINCT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name
FROM employees;


SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name
FROM employees
GROUP BY user_name;
		
# another way to see whether usernames are duplicated
SELECT  user_name, COUNT(*) AS records
FROM (SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), 
						SUBSTR(last_name, 1, 4), 
						'_',
						SUBSTR(birth_date, 6, 2), 
						SUBSTR(birth_date, 3, 2)
					)) AS user_name, 
				first_name, last_name, birth_date
		FROM employees
	) AS temp
	GROUP BY user_name
	ORDER BY records DESC;



# Bonus: how many duplicate usernames are there?

# this will get us all records with more than 1 row for the username. 

SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), 
					LOWER(SUBSTR(last_name, 1, 4)), "_", 
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)) AS username, 
					COUNT(*) as username_count
        FROM employees
        GROUP BY username
        HAVING username_count > 1
        ORDER BY username_count DESC;
        
# putting that in a subquery and aggregating from that will give us our totals. 
# but what do they actually need? What do the instructions mean?
# let's be safe and give all options with descriptive names so 
# our end user knows what the number represent. 
SELECT sum(temp.username_count) AS total_users_with_duplicated_usernames, 
		COUNT(temp.username_count) AS distinct_usernames_that_are_duplicated, 
		sum(temp.username_count) - COUNT(temp.username_count) AS number_of_users_who_need_unique_usernames
FROM (SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), 
					LOWER(SUBSTR(last_name, 1, 4)), "_", 
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)) AS username, 
					COUNT(*) as username_count
        FROM employees
        GROUP BY username
        ORDER BY username_count DESC
) as temp
WHERE username_count > 1;