# Use database_name
USE employees;

# Once you have a db selected, show tables
SHOW tables;

# DESCRIBE == Structure in Sequel Pro
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE salaries;

# Show CREATE TABLE == Table Info in Sequel Pro
SHOW CREATE TABLE salaries;

# What tables w/ a date type
# titles, salaries, employees, dept_manager...
# every table has dates except for departments.

# What is the relationship between the employees and the departments tables?
# No direct relationship
# BUT... the dept_emp table and dept_manager table show a relationship
# Relationships between tables == key idea in Relational Databases

# Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;