-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------
-- Subqueries are just executing a SELECT on the table resulting from another SELECT
-- in various forms.



-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 9-1 --
-- Construct a query against the film table that uses a filter condition with a
-- noncorrelated subquery against the category table to find all action films
-- (category.name = 'Action')

-- ANSWER --
SELECT film_id, title
  FROM film f
  WHERE f.film_id IN
    (SELECT fc.film_id
      FROM film_category fc
      WHERE fc.category_id in
      (SELECT c.category_id
        FROM category c
        WHERE c.name = 'Action'));

-------------------------------------------
-- Exercise 9-2 --
-- Rework the query from Exercise 09-1 using a correlated subquery against the
-- category and film_category tables to achieve the same results.

-- ANSWER --
SELECT f.film_id, f.title
  FROM film f
  WHERE EXISTS
  (SELECT fc.film_id
    FROM film_category fc
    INNER JOIN category c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Action'
    AND f.film_id = fc.film_id);
-- I don't know why you would ever execute this query this way, the earlier
-- answer makes more sense to me. Maybe it is just to show we know how to write
-- a correlated subquery...

-------------------------------------------
-- Exercise 9-3 --
-- Join the following query to a subquery against the film_actor table to show
-- the level of each actor:
-- SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
-- UNION ALL
-- SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
-- UNION ALL
-- SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
-- The subquery against the film_actor table should count the number of rows for
-- each actor using group by actor_id and the count should be compared to the
-- min_roles/max_roles columns to determine which level each actor belongs to

-- ANSWER --
SELECT actr.actor_id, a.first_name, a.last_name, grps.level
FROM
(SELECT actor_id, COUNT(*) num_roles
  FROM film_actor
  GROUP BY actor_id) actr
  INNER JOIN
  (SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
    UNION ALL
    SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
    UNION ALL
    SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) grps
  ON actr.num_roles BETWEEN grps.min_roles AND grps.max_roles
  INNER JOIN actor a
  ON actr.actor_id = a.actor_id;

-- Full disclosure, I did have to look up this answer in the back of the book
-- because I was unclear what his provided code was doing and didn't think it
-- would run on its own. In the future I should try his code first before looking
-- up the answer.... I also didn't know you could join using a between statement
-- does this mean you can join using a >, <, >= etc?

SELECT actr.actor_id, a.first_name, a.last_name, grps.level
FROM
(SELECT actor_id, COUNT(*) num_roles
  FROM film_actor
  GROUP BY actor_id) actr
  INNER JOIN
  (SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
    UNION ALL
    SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
    UNION ALL
    SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) grps
  ON actr.num_roles > grps.min_roles
  INNER JOIN actor a
  ON actr.actor_id = a.actor_id;

-- Yes! But you get repeats based on every possible match that can be made.
-- For example, in the code above, if someone is a 'Hollywood Star' they are
-- also in the table as a 'Prolific Actor' and a 'Newcomer'
