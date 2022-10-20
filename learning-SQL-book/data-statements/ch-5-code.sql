-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------

-- INNER JOINs are the default JOIN in SQL, when you call JOIN and INNER JOIN
-- is performed even if you did not call INNER
----
-- INNER JOINs go through and match on the desired ON statement and if there are
-- rows for which this match would not be possible, they are left out.
--------------

-- JOINs involving three or more tables just involve two or more JOINs and ONs
-- in this setting the order of the JOINs in the code does not matter because
-- your SQL server protocol is what determines the order in which the tables are
-- accessed and JOINed, not you unless you specify the order using additional
-- commands

-------

-- You can also JOIN on the same table twice, BUT in order to do so you need
-- to give the table different aliases each time it is JOINED on, here is an
-- example
SELECT f.title
  FROM film f
  INNER JOIN film_actor fa1
  ON f.film_id = fa1.film_id
  INNER JOIN actor a1
  ON fa1.actor_id = a1.actor_id
  INNER JOIN film_actor fa2
  ON f.film_id = fa2.film_id
  INNER JOIN actor a2
  ON fa2.actor_id = a2.actor_id
  WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
  AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');

-----
-- You can SELF JOIN a table, i.e. JOIN a table to itself
-- example


-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 5-1 --
-- Fill in the blanks (denoted by <#>) for the following query to obtain the
-- results that follow:
-- SELECT c.first_name, c.last_name, a.address, ct.city
--   FROM customer c
--     INNER JOIN address <1>
--     ON c.address_id = a.address_id
--     INNER JOIN city ct
--     ON a.city_id = <2>
--     WHERE a.district = 'California';

-- ANSWER --
SELECT c.first_name, c.last_name, a.address, ct.city
  FROM customer c
    INNER JOIN address a
    ON c.address_id = a.address_id
    INNER JOIN city ct
    ON a.city_id = ct.city_id
    WHERE a.district = 'California';


-------------------------------------------
-- Exercise 5-2 --
-- Write a query that returns the title of every film in which an actor with
-- the first name JOHN appeared.

-- ANSWER --
SELECT f.title
  FROM film f
    INNER JOIN film_actor fa
    ON f.film_id = fa.film_id
    INNER JOIN actor a
    ON fa.actor_id = a.actor_id
    WHERE a.first_name = 'JOHN';

-------------------------------------------
-- Exercise 5-3 --
-- Construct a query that returns all addresses that are in the same city. You
-- will need to join the address table to itself and each row should include
-- two different addresses.

-- ANSWER --
SELECT address_1, address_2
  FROM (SELECT a1.address address_1, a2.address address_2
    FROM address a1
      INNER JOIN address a2
      ON a1.city_id = a2.city_id
      WHERE a1.address_id <> a2.address_id)
  WHERE (address_1)
-- Note to self: I checked the back of the book and this is indeed a correct
-- answer, however, I'm not pleased that we essentially have duplicate rows
-- since the address order is meaningless....
