---- NOTES Section ----
-- This section of the code will just be notes about the chapter
-----------------------
-- LOCKS --
-- in settings where multiple people are editing and accessing database data at
-- once there are locks and locking mechanisms that are put in place. This is
-- done in order to prevent two or more people from editing the data at once
-- and to set standards for how data is read while it is actively being updated.
-- Example: how to read the rentals from a video store when new rentals are
-- currently happening.

-- Transactions
-- A transaction is a way to ensure that either all of a series of SQL statements
-- are executed or none of them are.




-- EXERCISES IN "TEST YOUR KNOWLEDGE" AT THE END OF THE CHAPTER --
-------------------------------------------
-- Exercise 12-1 --
-- Generate a unit of work to transfer $50 from account 123 to account 789. You
-- will need to insert two rows into the transaction table and update two rows
-- in the account table. Use the following table definitions/data (see book):

-- ANSWER --
START TRANSACTION;

INSERT INTO transaction
  (txn_id, txn_date, account_id, txn_type_cd, amount)
VALUES
  (1003, now(), 123, 50, 'D');

INSERT INTO transaction
  (txn_id, txn_date, account_id, txn_type_cd, amount)
VALUES
  (1004, now(), 789, 50, 'C');

UPDATE account SET avail_balance = avail_balance - 50,
                    last_activity_date = now()
WHERE account_id = 123
  AND avail_balance > 50;

UPDATE account SET avail_balance = avail_balance + 50,
                    last_activity_date = now()
WHERE account_id = 789;

COMMIT;
