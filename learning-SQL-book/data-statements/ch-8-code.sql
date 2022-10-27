-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------

-- You can use GROUP BY just like pandas Group By
-- Note that the GROUP BY is completed after any WHERE statement you
-- would place. Instead you can use a HAVING statement after the GROUP BY.
-- Example:
SELECT customer_id, count(*)
  FROM rental
  GROUP BY customer_id
  HAVING count(*) >= 40;

-- It seems that null rows are ignored by most standard SQL functions

-- WITH ROLLUP allows you to do the simple counts when doing multicolumn
-- GROUP BYs
-- Example:
SELECT *
FROM
(SELECT fa.actor_id, f.rating, count(*)
  FROM film_actor fa
    INNER JOIN film f
    ON fa.film_id = f.film_id
    GROUP BY fa.actor_id ASC, f.rating WITH ROLLUP) t
ORDER BY actor_id, rating;


-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 8-1 --
-- Construct a query that counts the number of rows in the payment table

-- ANSWER --
SELECT COUNT(*)
  FROM payment;

-------------------------------------------
-- Exercise 8-2 --
-- Modify your query from Exercise 8-1 to count the number of payments made by
-- each customer. Show the customer ID and the total amount paid for each
-- customer.

-- ANSWER --
SELECT customer_id, COUNT(*), SUM(amount)
  FROM payment
  GROUP BY customer_id;


-------------------------------------------
-- Exercise 8-3 --
-- Modify your query from Exercise 8-2 to include only those customers who have
-- made at least 40 payments.

-- ANSWER --
SELECT customer_id, COUNT(*), SUM(amount)
  FROM payment
  GROUP BY customer_id
  HAVING COUNT(*) >= 40;
