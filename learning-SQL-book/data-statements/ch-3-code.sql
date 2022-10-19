-- This will move us over to the sakila database
-- Available from MySQL
USE sakila;

-- Let's show the tables in this database and then one or two of them
SHOW tables;

-- actor table
DESCRIBE actor;
-- customer table
DESCRIBE customer;


------ note -------------------------------------------------------------
-- Not really much else here to take note of, mostly a survey chapter to
-- wet the reader's whistle. I will just do the exercises now.
-------------------------------------------------------------------------

-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 3-1 --
-- Retrieve the actor ID, first name and last name for all actors. Sort by
-- last name and then by first name.

-- ANSWER --
-- First I describe the table because I don't know the column names off hand
DESCRIBE actor;

-- Now I use a SELECT statement with an ORDER BY
SELECT actor_id, first_name, last_name
    FROM actor
    ORDER BY last_name, first_name;

-------------------------------------------
-- Exercise 3-2 --
-- Retrieve the actor ID, first name, and last name for all actors whose last
-- name equals 'WILLIAMS' or 'DAVIS'

-- ANSWER --

-- Another SELECT statement, this time with a WHERE
SELECT actor_id, first_name, last_name
    FROM actor
    WHERE last_name = 'WILLIAMS' or last_name = 'DAVIS';

-------------------------------------------
-- Exercise 3-3 --
-- Write a query against the rental table that returns the IDs of the customers
-- who rented a film on July 5, 2005 (use the rental.rental_date column, and
-- you can use the date() function to ignore the time component). Include a single
-- row for each distinct customer ID.

-- ANSWER --

-- Describing the renal table
DESCRIBE rental;

-- Using a SELECT with a WHERE and a DISTINCT
SELECT DISTINCT customer_id
    FROM rental
    WHERE date(rental_date) = '2005-07-05'
    ORDER BY customer_id;

-------------------------------------------
-- Exercise 3-4
-- Fill in the blanks (denoted by <#>) for this multitable query to achieve the
-- following results:
-- SELECT c.email, r.return_date
--     FROM customer c
--     INNER JOIN rental <1>
--     ON c.customer_id = <2>
--     WHERE date(r.rental_date) = '2005-06-14'
--     ORDER BY <3> <4>;

-- ANSWER --
SELECT c.email, r.return_date
    FROM customer c
    INNER JOIN rental r
    ON c.customer_id = r.customer_id
    WHERE date(r.rental_date) = '2005-06-14'
    ORDER BY r.return_date desc; -- alternatively could use 2 instead of r.return_date
