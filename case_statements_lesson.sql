
-- CASE statements are a part of your select statement

-- in the case of x, do y, otherwise do z
-- CASE WHEN x THEN y ELSE z END

-- IF: if x, do y, otherwise do z
-- IF(x, y, z)

/* SELECT col1
		, col2
		, CASE WHEN x THEN y ELSE z END
FROM table1; */

-- x represents a condition, it must return a true or false: =, <>, >=, <=, LIKE, IN
-- y represents a value (static value (string, integer), column reference)
-- y is returned when x is true
-- z also represents a value
-- z is returned when x is false

USE titanic_db;

SELECT * FROM passengers;
-- the below example will assign adult to all rows where age is null, but we don't know that those are adults, so we need to add a second condition and have the "ELSE" capture the exceptions. 

SELECT passenger_id
		, survived
		, age
		, CASE WHEN age < 12 THEN 'child' 
			ELSE 'adult'
			END AS adult_child
FROM passengers
WHERE age IS NOT NULL
ORDER BY age;


-- here we add the second condition of >=12 and the else is "NULL"

SELECT passenger_id
		, survived
		, age
		, CASE WHEN age < 12 THEN 'child' 
			WHEN age >= 12 THEN 'adult'
			ELSE null 
			END AS adult_child
FROM passengers
WHERE age IS NOT NULL
ORDER BY age;

-- a way to write a case statement when condition is equality and all referencing the same column

SELECT passenger_id
		, survived
		, age
		, CASE embarked 
			WHEN 'S' THEN 'Southampton'
			WHEN 'C' THEN 'Cherbourg'
			WHEN 'Q' THEN 'Queenstown'
			ELSE null
			END AS embarked_town
FROM passengers;

-- what this would look like in the more long handed way:

SELECT passenger_id
		, survived
		, age
		, CASE WHEN	embarked = 'S' THEN 'Southampton'
			WHEN embarked = 'C' THEN 'Cherbourg'
			WHEN embarked = 'Q' THEN 'Queenstown'
			ELSE null
			END AS embarked_town
FROM passengers;


-- Can we use IF() in this case? 

SELECT passenger_id
		, survived
		, age
		, IF(age < 12, 'child', 'adult') AS adult_child
FROM passengers;

-- yes you can...and they can be nested. 

SELECT passenger_id
		, survived
		, age
		, IF(age < 12, 'child', 
			IF(age >= 12, 'adult', NULL)
			) AS adult_child
FROM passengers;


-- case statements where not all comparisons are referencing the same column...

SELECT passenger_id
		, survived
		, age
		, CASE WHEN	embarked = 'S' THEN 'Southampton'
			WHEN embark_town = 'Cherbourg' THEN 'Cherbourg'
			WHEN embarked = 'Q' THEN 'Queenstown'
			ELSE null
			END AS embarked_town
FROM passengers;

-- case statements with OR/AND

SELECT passenger_id
		, survived
		, age
		, CASE WHEN age < 12 THEN 'child' 
			WHEN age >= 12 THEN 'adult'
			WHEN parch + sibsp = 0 THEN 'adult'
			WHEN parch > 2 THEN 'adult'
			WHEN sibsp = 1 AND parch = 0 THEN 'adult'
			ELSE null 
			END AS adult_child
		, sibsp
		, parch
FROM passengers;

/* doing an aggregate + group by with a case statement
let's look at actual distribution of adult/child across the different
combinations of values of sibsp & parch. 
we want to see if our assumptions about the numbers a child or adult
would travel with are valid. 
*/

SELECT sibsp
		, parch
		, CASE WHEN age < 12 THEN 'child' 
			WHEN age >= 12 THEN 'adult'
			ELSE null 
			END AS adult_child
		, COUNT(*) AS passengers
FROM passengers
WHERE age is NOT NULL
GROUP BY sibsp, parch, adult_child;

SELECT passenger_id
		, survived
		, age
		, CASE WHEN age < 12 THEN 'child' 
			WHEN age >= 12 THEN 'adult'
			WHEN parch = 0 OR parch > 2 THEN 'adult'
			ELSE null 
			END AS adult_child
		, sibsp
		, parch
FROM passengers;

/* let's aggregate and see what our results look like in number of adults/children
and in null ages being estimated (by adult/child)
*/

SELECT ac.survived, ac.adult_child, COUNT(ac.passenger_id)
FROM 
(SELECT passenger_id
		, survived
		, age
		, CASE WHEN age < 12 THEN 'child' 
			WHEN age >= 12 THEN 'adult'
			WHEN parch = 0 OR parch > 2 THEN 'adult'
			ELSE null 
			END AS adult_child
FROM passengers
) AS ac
GROUP BY ac.survived, ac.adult_child
;

/* We were able to est the age, by adult or child, of all by 20 passengers
there are 177 null values with age
*/
SELECT count(*) FROM passengers WHERE age IS NULL;

-- Look at survival for adult vs. child
SELECT ac.survived, ac.adult_child, COUNT(ac.passenger_id)
FROM 
(SELECT passenger_id
		, survived
		, age
		, CASE WHEN age < 12 THEN 'child' 
			WHEN age >= 12 THEN 'adult'
			WHEN parch = 0 OR parch > 2 THEN 'adult'
			ELSE null 
			END AS adult_child
FROM passengers
) AS ac
WHERE ac.adult_child IS NOT NULL
GROUP BY ac.survived, ac.adult_child
;

/* Look at survival for adult vs. child
before grouping and counting we can see what sql is going to count and what the case statements return. After this we will show the code where we count the result of the case statements. 
*/

SELECT ac.survived
-- 		, COUNT(CASE WHEN ac.adult_child = 'adult' THEN ac.passenger_id END) AS adults
-- 		, COUNT(CASE WHEN ac.adult_child = 'child' THEN ac.passenger_id END) AS children
		, CASE WHEN ac.adult_child = 'adult' THEN ac.passenger_id END AS adults
		, CASE WHEN ac.adult_child = 'child' THEN ac.passenger_id END AS children
FROM (
		SELECT passenger_id
			, survived
			, age
			, CASE WHEN age < 12 THEN 'child' 
				WHEN age >= 12 THEN 'adult'
				WHEN parch = 0 OR parch > 2 THEN 'adult'
				ELSE null 
				END AS adult_child
		FROM passengers
	) AS ac
WHERE ac.adult_child IS NOT NULL
-- GROUP BY ac.survived
;


SELECT ac.survived
 		, COUNT(CASE WHEN ac.adult_child = 'adult' THEN ac.passenger_id END) AS adults
 		, COUNT(CASE WHEN ac.adult_child = 'child' THEN ac.passenger_id END) AS children
FROM (
		SELECT passenger_id
			, survived
			, age
			, CASE WHEN age < 12 THEN 'child' 
				WHEN age >= 12 THEN 'adult'
				WHEN parch = 0 OR parch > 2 THEN 'adult'
				ELSE null 
				END AS adult_child
		FROM passengers
	) AS ac
WHERE ac.adult_child IS NOT NULL
GROUP BY ac.survived
;


-- columna = condition shortcut, turning something into a dummy variable

SELECT sex AS gender
		, sex = 'female' AS is_female 
FROM passengers;

SELECT sex AS gender
		, CASE WHEN sex = 'female' THEN 1 else 0 END AS is_female
FROM passengers;

/* 

# CASE WHEN conditional THEN value 
#	<WHEN conditional2 THEN value2> # optional...if needed more conditionals
# 	ELSE value3
# 	END
# 	<AS new_col_name>

# Wrapping an aggregate function goes around CASE & END, E.G. COUNT(CASE...END) AS alias
# you can group by the alias if needed
# IF(condition, val_if_true, val_if_false)
# IF(condition, val_if_true, IF(condition, val_if_true, val_if_false)) (example above)

# sex = 'female' AS is_female : will generate a 1 where true or 0 where false. 


# we can put a calculation in place of value to return
# always think about what is returned, boolean? individuals values, aggregated values? 
*/

SELECT IF(age < 12, sibsp + parch, age) FROM passengers;

SELECT avg(age), sum(age)/count(age), count(age), sum(age)/count(passenger_id), count(passenger_id) FROM passengers;