-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------




-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 7-1 --
-- Write a query that returns the 17th through 25th characters of the string
-- 'Please find the substring in this string'

-- ANSWER --
SELECT substring('Please find the substring in this string', 17, 25);

-------------------------------------------
-- Exercise 7-2 --
-- Write a query that returns the absolute value and sign (-1, 0 or 1) of the
-- number -25.76823. Also return the number rounded to the nearest hundredth.

-- ANSWER --
SELECT ABS(-25.76823), SIGN(-25.76823), ROUND(-25.76823, 2);

-------------------------------------------
-- Exercise 7-3 --
-- Write a query to return just the month portion of the current date.

-- ANSWER --
-- note answer will be different from one provided in book because I am 
-- coding on a MariaDB database, not a MySQL database
SELECT EXTRACT(MONTH FROM CURDATE());
