-- Choosing the sakila database
USE sakila;


---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------
--- INDEX NOTES ---

-- Indexes are special tables that ARE kept in a specific order. Instead of
-- containing all the data about an entity, however, an index contains only the
-- column (or columns) used to locate rows in the data table, along with information 
-- describing where the rows are physically located.

-- To add an index to a MySQL database
-- ALTER TABLE table_name
--  ADD INDEX index_name (index_column)

-- The default index for MySQL is a B-tree index or Balanced-Tree Index
-- Here the server attempts to create a branching tree based on the sorted
-- items in the column you are indexing. The tree splits so that each node is
-- close to being balanced.

-- For categorical variables a B-tree may not be desirable, in such cases you
-- may try a bitmap index

-- Text indexes are used for databases of documents

-- When querying a column(s) with an index(es) the server's query optimizer
-- decides how to best utilize the index(es) and table(s)




--- CONSTRAINT NOTES ---
-- A constraint is a restriction placed on one or more columns of a table
-- Primary Key Constraint -> id the column that guarantees uniqueness
-- Foreighn key constraint -> columns in one table can only take on values from
-- the referenced column of another table
-- Unique constraint -> column must contain unique values within a table
-- Check constraints -> restricts allowable values for a column

-- Constraints can be added during the CREATE TABLE step or with an ALTER TABLE
-- step.




-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 13-1 --
-- Generate an alter table statement for the rental table so that an error will
-- be raised if a row having a value found in the rental.customer_id column is
-- deleted from the customer table.

-- ANSWER --
ALTER TABLE rental
ADD CONSTRAINT fk_rental_customer_id FOREIGN KEY (customer_id)
REFERENCES customer (customer_id) ON DELETE RESTRICT ON UPDATE CASCADE;


-- Exercise 13-1 --
-- Generate a multicolumn index on the payment table that could be used by both
-- of the following queries:
-- SELECT customer_id, payment_date, amount
--   FROM payment
--   WHERE payment_date > cast('2019-12-31 23:59:59' as datetime);
--
-- SELECT customer_id, payment_date, amount
--   FROM payment
--   WHERE payment_date > cast('2019-12-31 23:59:59' as datetime)
--     AND amount < 5;

-- ANSWER --
ALTER TABLE payment
  ADD INDEX payment_date_amount (payment_date, amount);

-- DROPPING IT AFTER RUNNING THE ABOVE
DROP INDEX payment_date_amount ON payment;
