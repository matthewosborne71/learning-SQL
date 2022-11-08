-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------
-- if else statements in SQL are executed with CASE statements, here is an
-- example of such a statement
SELECT first_name, last_name,
  CASE
    WHEN active = 0 THEN 'INACTIVE'
    ELSE 'ACTIVE'
  END activity_type
  FROM customer;

-- Another example
SELECT
  CASE
    WHEN c.name in ('Children', 'Family', 'Sports', 'Animation') THEN 'All Ages'
    WHEN c.name = 'Horror' THEN 'Adult'
    WHEN c.name in ('Music', 'Games') THEN 'Teens'
    ELSE 'Other'
  END genre_category,
  COUNT(*)
  FROM film f
  INNER JOIN film_category fc
  ON f.film_id = fc.film_id
  INNER JOIN category c
  ON fc.category_id = c.category_id
  GROUP BY genre_category;

-- CASE statements can be used to do the equivalent of a pivot table
SELECT SUM(CASE WHEN monthname(rental_date) = 'May' THEN 1 ELSE 0 END) May_rentals,
       SUM(CASE WHEN monthname(rental_date) = 'June' THEN 1 ELSE 0 END) June_rentals,
       SUM(CASE WHEN monthname(rental_date) = 'July' THEN 1 ELSE 0 END) July_rentals
  FROM rental
  WHERE rental_date BETWEEN '2005-05-1' AND '2005-08-01';




-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 11-1 --
-- Rewrite the following query, which uses a simple case expression, so that the
-- same results are achieved using a searched case expression. Try to use as
-- few when clauses as possible.
SELECT name,
  CASE name
    WHEN 'English' THEN 'latin1'
    WHEN 'Italian' THEN 'latin1'
    WHEN 'French' THEN 'latin1'
    WHEN 'German' THEN 'latin1'
    WHEN 'Japanese' THEN 'utf8'
    WHEN 'Mandarin' THEN 'utf8'
    ELSE 'Unknown'
  END character_set
  FROM language;

-- ANSWER --
SELECT name,
  CASE
    WHEN name in ('English', 'Italian', 'French', 'German')
      THEN 'latin1'
    WHEN name in ('Japanese', 'Mandarin')
      THEN 'utf8'
    ELSE 'Unknown'
  END character_set
  FROM language;

-------------------------------------------
-- Exercise 11-2 --
-- Rewrite the following query so that the result set contains a single row
-- with five columns (one for each rating). Name the five columns G, PG, PG_13,
-- R, and NC_17.
SELECT rating, count(*)
  FROM film
  GROUP BY rating;

-- ANSWER --
SELECT SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) G,
       SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) PG,
       SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) PG_13,
       SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) R,
       SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) NC_17
  FROM film;
