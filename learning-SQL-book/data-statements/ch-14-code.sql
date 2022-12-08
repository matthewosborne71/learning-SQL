-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------

-- VIEWS are a way to store a query as a table without storing it to disk
-- How to create a VIEW:
CREATE VIEW customer_vw
  (customer_id,
    first_name,
    last_name,
    email)
  AS
  SELECT customer_id,
         first_name,
         last_name,
         concat(substr(email,1,2),'*****',substr(email, -4)) email
  FROM customer;

SELECT first_name, last_name, email FROM customer_vw;

-- The VIEW is not stored as a table, but rather the query is stored and it
-- is only executed once the view is requested.


-- You can UPDATE VIEWs as well.
-- When you UPDATE a VIEW you also UPDATE the underlying table(s)
-- If your VIEW is constructed from a single table, the UPDATE runs exactly as
-- a table UPDATE runs.
-- If your VIEW is constructed from multiple tables, you must write multiple
-- UPDATE statements in order to UPDATE columns from the different tables.




-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 14-1 --
-- Create a view definition that can be used by the following query to generate
-- the given results:
-- SELECT title, category_name, first_name, last_name
--   FROM film_ctgry_actor
--   WHERE last_name = 'FAWCETT';

-- ANSWER --
CREATE VIEW film_ctgry_actor
  (title,
    category_name,
    first_name,
    last_name)
  AS
  SELECT f.title title,
          c.name category_name,
          a.first_name first_name,
          a.last_name last_name
    FROM film_actor fa
    INNER JOIN film f
    ON fa.film_id = f.film_id
    INNER JOIN actor a
    ON fa.actor_id = a.actor_id
    INNER JOIN film_category fc
    ON fa.film_id = fc.film_id
    INNER JOIN category c
    ON fc.category_id = c.category_id;

-- CHECKING that the query works as desired
SELECT title, category_name, first_name, last_name
  FROM film_ctgry_actor
  WHERE last_name = 'FAWCETT';

-------------------------------------------
-- Exercise 14-2 --
-- The film rental company manager would like to have a report that includes
-- the name of every country, along with the total payments for all customers
-- who live in each country. Generate a view definition that queries the
-- country table and uses a scalar subquery to calculate a value for a column
-- named tot_payments

-- ANSWER --

CREATE VIEW country_payment
  (country,
    total_payment)
  AS
  SELECT country, SUM(payment) total_payment
  FROM (SELECT country.country country, p.amount payment
          FROM payment p
          INNER JOIN customer c
          ON p.customer_id = c.customer_id
          INNER JOIN address a
          ON c.address_id = a.address_id
          INNER JOIN city
          ON a.city_id = city.city_id
          INNER JOIN country
          ON city.country_id = country.country_id) cp
  GROUP BY country;
