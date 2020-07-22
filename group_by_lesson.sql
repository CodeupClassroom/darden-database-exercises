USE titanic_db; 

SELECT * 
FROM passengers
LIMIT 10;

# without distinct or groupby
SELECT embarked, class
FROM passengers
ORDER BY embarked; 

# get distinct class & embarked combos...essentially removing duplicates
SELECT DISTINCT embarked, class
FROM passengers
ORDER BY embarked;

# get same results using group by...essentially removing duplicates
SELECT embarked, class
FROM passengers
GROUP BY embarked ASC, class; 
# No need for order by bc you can do it in the group by clause by adding asc/desc after the column name you are grouping. 
# ORDER BY embarked;

# let's see the count of passengers in each class:
SELECT embarked, class, COUNT(passenger_id) AS passenger_count
FROM passengers
GROUP BY embarked ASC, class;

# do I need to group by? 
# is my function running over multiple rows/observations?  if yes: group by! count(), min(), max() 
# or is my function running over multiple columns but in the same row? if yes, no group by needed. e.g. concat(first_name, last_name)

SELECT COUNT(passenger_id) AS passenger_count
FROM passengers
WHERE sex = 'female';

SELECT COUNT(passenger_id) AS passenger_count
FROM passengers
WHERE sex = 'male';


SELECT sex, COUNT(passenger_id) AS passenger_count
FROM passengers
GROUP BY sex; 

SELECT sibsp, parch, COUNT(*) AS passenger_count
FROM passengers
GROUP BY sibsp, parch
ORDER BY passenger_count DESC;

select class, AVG(fare) AS avg_fare, STDDEV(fare) AS stddev_fare
from passengers
GROUP BY class Asc;