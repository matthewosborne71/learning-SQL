-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------

-- By default inner joins will remove and data for which a match does not exist
-- in one of the JOINed tables
-- a LEFT OUTER (RIGHT OUTER) JOIN will keep data if it exists in the table
-- on the LEFT (RIGHT) table but not the RIGHT (LEFT) table
SELECT f.film_id, f.title, i.inventory_id
  FROM film f
  LEFT OUTER JOIN inventory i
  ON f.film_id = i.film_id
  WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
  FROM film f
  RIGHT OUTER JOIN inventory i
  ON f.film_id = i.film_id
  WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
  FROM film f
  INNER JOIN inventory i
  ON f.film_id = i.film_id
  WHERE f.film_id BETWEEN 13 AND 15;



-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 10-1 --
-- Using the following table definitions and data, write a query that returns
-- each customer name along with their total payments:
-- Include all customers, even if no payment records exist for that customer.

-- ANSWER --
SELECT c.Name, SUM(p.Amount)
FROM (SELECT 1 Customer_id, 'John Smith' Name
        UNION ALL
      SELECT 2 Customer_id, 'Kathy Jones' Name
        UNION ALL
      SELECT 3 Customer_id, 'Greg Oliver' Name) c
LEFT OUTER JOIN (SELECT 101 Payment_id, 1 Customer_id, 8.99 Amount
                    UNION ALL
                  SELECT 102 Payment_id, 3 Customer_id, 4.99 Amount
                    UNION ALL
                  SELECT 103 Payment_id, 1 Customer_id, 7.99 Amount) p
ON c.Customer_id = p.Customer_id
GROUP BY c.Customer_id;

-------------------------------------------
-- Exercise 10-2 --
-- Reformulate your query from Exercise 10-1 to use the other outer join type
-- (e.g., if you used a left outer join in Exercise 10-1 use a right outer join
-- this time) such that the results are identical to Exercise 10-1.

-- ANSWER --
SELECT c.Name, SUM(p.Amount)
FROM (SELECT 101 Payment_id, 1 Customer_id, 8.99 Amount
                    UNION ALL
                  SELECT 102 Payment_id, 3 Customer_id, 4.99 Amount
                    UNION ALL
                  SELECT 103 Payment_id, 1 Customer_id, 7.99 Amount) p
RIGHT OUTER JOIN (SELECT 1 Customer_id, 'John Smith' Name
                    UNION ALL
                  SELECT 2 Customer_id, 'Kathy Jones' Name
                    UNION ALL
                  SELECT 3 Customer_id, 'Greg Oliver' Name) c
ON c.Customer_id = p.Customer_id
GROUP BY c.Customer_id;

-------------------------------------------
-- Exercise 10-3 --
-- Devise a query that will generate the set {1, 2, 3, ..., 99, 100} (Hint: use
-- a cross join with at least two from clause subqueries)

-- ANSWER --
SELECT a.num + b.num + 1 digit
FROM       (SELECT 0 num
              UNION ALL
            SELECT 1 num
              UNION ALL
            SELECT 2 num
              UNION ALL
            SELECT 3 num
              UNION ALL
            SELECT 4 num
              UNION ALL
            SELECT 5 num
              UNION ALL
            SELECT 6 num
              UNION ALL
            SELECT 7 num
              UNION ALL
            SELECT 8 num
              UNION ALL
            SELECT 9 num) a
CROSS JOIN (SELECT 0 num
             UNION ALL
           SELECT 10 num
             UNION ALL
           SELECT 20 num
             UNION ALL
           SELECT 30 num
             UNION ALL
           SELECT 40 num
             UNION ALL
           SELECT 50 num
             UNION ALL
           SELECT 60 num
             UNION ALL
           SELECT 70 num
             UNION ALL
           SELECT 80 num
             UNION ALL
           SELECT 90 num) b
