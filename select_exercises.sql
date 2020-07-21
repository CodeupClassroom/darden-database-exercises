USE albums_db;

-- The name of all albums by Pink Floyd
SELECT name as 'Albums by Pink Floyd'
FROM albums where artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date as "Release Date for Sgt. Pepper's Lonely Hearts Club Band"
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
-- On this version of MySQL, we can use double quotes like this:
SELECT release_date as "Release Date for Sgt. Pepper's Lonely Hearts Club Band"
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- The genre for the album Nevermind
SELECT genre as "Genre for Nevermind"
from albums
where name = 'Nevermind';

-- Which albums were released in the 1990s
SELECT artist, name as "Albums Released in the 1990s"
FROM albums
where release_date like '199%';

-- Let's use WHERE Between
-- This one is more computationally efficient
SELECT artist, name as "Albums Released in the 1990s"
from albums
where release_date between 1990 and 1999;

-- We can find albums released in the 90s also using greater than or equal to and less than or equal to
SELECT artist, name AS "Albums Released in the 1990s"
FROM albums
WHERE release_date >= 1990 AND release_date <= 1999;

-- Which albums had less than 20 million certified sales
SELECT name AS "Albums Selling Less than 20 million"
FROM albums
WHERE sales < 20;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT * 
FROM albums
WHERE genre = 'Rock'; -- single = w/ a where clause in SQL is the same as == in Python


-- What if we want a query that gives any kind of rock?
SELECT *
FROM albums
WHERE genre LIKE '%rock%';

-- What if we want a query that gives any kind of rock?
-- Contents of a string are NOT case-sensitive
SELECT *
FROM albums
WHERE genre LIKE '%rock%';


