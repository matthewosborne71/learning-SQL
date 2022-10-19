-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------

-- BETWEEN
-- Instead of coding up an interval with two inequalities you can use BETWEEN
-- BETWEEN is not inclusive
-- Example 1
SELECT * FROM payment
  WHERE amount BETWEEN 10 AND 12;

-- Example 2
SELECT *
  FROM actor
  WHERE last_name BETWEEN "AP" and "BB";

-- IN
-- You can also check for the rows where a column is in a set
-- of select values
-- Example 1
SELECT title, rating
  FROM film
  WHERE rating IN ('R', 'NC-17');

-- Checking for specific string matches
-- Example 1, using wildcard characters, need to use LIKE
-- _ means one character, % means any # of characters
SELECT title, rating
  FROM film
  WHERE title LIKE '_T%';

-- Example 2, using regular expressions
SELECT title, rating
  FROM film
  WHERE title REGEXP '^.T';

-- To check for Null us IS NULL

-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 4-1 --
-- Which of the payment IDs would be returned by the following filter conditions
-- customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-08-23')

-- ANSWER --
-- This will return all payment_id values for rows where the customer_id is not 5
-- and the amount was greater than 8 or the payment was made on August 23, 2005

SELECT payment_id, customer_id, amount, payment_date
  FROM payment
  WHERE customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-08-23');

-------------------------------------------
-- Exercise 4-2 --
-- Which of the payment IDs would be returned by the following filter conditions
-- customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19')

-- ANSWER --
-- where the customer_id is 5 and the amount is both less than or equal to 6 and
-- the payment occurred on any day not 2005-06-19

SELECT payment_id, customer_id, amount, payment_date
  FROM payment
  WHERE customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19');

-------------------------------------------
-- Exercise 4-3 --
-- Construct a query that retieves all rows from the payments table where the
-- amount is either 1.98, 7.98, or 9.98

-- ANSWER --

SELECT payment_id, amount
  FROM payment
  WHERE amount IN (1.98, 7.98, 9.98);

-------------------------------------------
-- Exercise 4-4 --
-- Construct a query that finds all customers whose last name contains an A in
-- the second position and a W anywhere after the A.

-- ANSWER --

SELECT customer_id, first_name, last_name
  FROM customer
  WHERE last_name LIKE '_A%W%';
