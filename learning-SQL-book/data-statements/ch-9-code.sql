-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------
-- Subqueries are just executing a SELECT on the table resulting from another SELECT
-- in various forms.

-- Just practicing...

-- should return the customer info for the highest
-- customer_id rental
SELECT customer_id, first_name, last_name
  FROM customer
  WHERE customer_id IN (SELECT MAX(customer_id) FROM rental);

-- this returns the name of customers who were given what I am
-- deeming as "free rentals" and counts how many such rentals they received.
-- Here I'm calling a free rental any instance of a payment of 0 for that
-- customer.
SELECT first_name, last_name, fr.free_rentals
  FROM customer c
  INNER JOIN (SELECT customer_id, COUNT(*) free_rentals
    FROM (SELECT customer_id
          FROM payment
          WHERE amount=0) t
    GROUP BY customer_id) fr
  ON c.customer_id = fr.customer_id;

-- count the number of film rentals for each customer that had exactly 20 films
-- seems silly, but this was an example in the book I'm trying to recreate from
-- scratch without using a correlated subquery
SELECT c.customer_id, c.first_name, c.last_name, t.num_rentals
  FROM customer c
  INNER JOIN (SELECT customer_id, COUNT(*) num_rentals
                FROM rental
                GROUP BY customer_id
                HAVING num_rentals = 20) t
  ON c.customer_id = t.customer_id;

-- okay, let's try to recreate the way to do it with a correlated subquery
-- did some searching online that suggests they are the fastest way to do some
-- things
SELECT c.customer_id, c.first_name, c.last_name
  FROM customer c
  WHERE 20 = (SELECT COUNT(*)
                FROM rental r
                WHERE r.customer_id = c.customer_id);

-- we can try to copy this to get the actors who appear in 20 films
SELECT a.actor_id, a.first_name, a.last_name
  FROM actor a
  WHERE 20 > (SELECT COUNT(*)
                FROM film_actor fa
                WHERE a.actor_id = fa.actor_id);

SELECT a.first_name, a.last_name
  FROM actor a
  WHERE EXISTS (SELECT 1 FROM film_actor fa
                WHERE fa.actor_id = a.actor_id
                  AND date(fa.last_update) > '2006-01-01');


-- Trying to recreate an example on rental amounts from scratch
-- Small Fry 0 74.99
-- Average Joes 75 149.99
-- Heavy Hitters 150 9999999.99
SELECT c.first_name, c.last_name, grps.level
  FROM customer c
  INNER JOIN (SELECT p.customer_id, SUM(p.amount) total_pay
                FROM payment p
                GROUP BY customer_id) t
  ON c.customer_id = t.customer_id
  INNER JOIN
  (SELECT 'Heavy Hitters' level, 150 min_pay, 9999999.99 max_pay
    UNION ALL
    SELECT 'Average Joes' level, 75 min_pay, 149.99 max_pay
    UNION ALL
    SELECT 'Small Fry' level, 1 min_pay, 74.99 max_pay) grps
  ON t.total_pay BETWEEN grps.min_pay AND grps.max_pay;

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




-- RETRYING the exercises at the end of the chapter. This time I'm not allowed
-- to peak!
-- Exercise 9-1
------------
-- ANSWER --
SELECT f.film_id, f.title
  FROM film f
  WHERE f.film_id IN (SELECT fc.film_id
                        FROM film_category fc
                        WHERE fc.category_id = (SELECT c.category_id
                                                FROM category c
                                                WHERE name = 'ACTION'));


-- Exercise 9-2
------------
-- ANSWER --
SELECT f.film_id, f.title
  FROM film f
  WHERE EXISTS (SELECT 1 FROM (SELECT fc.film_id
                                FROM film_category fc
                                WHERE fc.category_id = (SELECT c.category_id
                                                        FROM category c
                                                        WHERE name = 'ACTION')) g
                WHERE f.film_id = g.film_id);



-- Exercise 9-3
--------------
-- ANSWER --
SELECT a.actor_id, a.first_name, a.last_name, grps.level
  FROM actor a
  INNER JOIN (SELECT fa.actor_id, COUNT(*) num_roles
                FROM film_actor fa
                GROUP BY fa.actor_id) nr
  ON a.actor_id = nr.actor_id
  INNER JOIN (SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
    UNION ALL
    SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
    UNION ALL
    SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) grps
  ON nr.num_roles BETWEEN grps.min_roles AND grps.max_roles;
