-- create-db-w-tables.sql
-- This code will create a database with empty tables

-- Create toy_database
CREATE DATABASE toy_database;

-- Switch to toy_database;
USE toy_database;

-- Create an empty "person" table
CREATE TABLE person
(person_id SMALLINT UNSIGNED,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  eye_color ENUM('BR', 'BL', 'GR', 'Other'),
  birth_date DATE,
  street VARCHAR(30),
  city VARCHAR(30),
  state VARCHAR(30),
  country VARCHAR(30),
  postal_code VARCHAR(20),
  CONSTRAINT pk_person PRIMARY KEY (person_id)
)

-- Create a favorite_food table
CREATE TABLE favorite_food
(person_id SMALLINT UNSIGNED,
  food VARCHAR(30),
  CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
  CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
  REFERENCES person (person_id)
);

-- This will alter the person table so that the person_id is
-- incremented automatically by the server
set foreign_key_checks=0;
ALTER TABLE person
  MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks=1;

-- Now we can add some entries into the person TABLE
INSERT INTO person
  (person_id, first_name, last_name, eye_color, birth_date,
    street, city, state, country, postal_code)
  VALUES (null, 'Mark', 'Abraham', 'GR', '1944-03-22', '71 W. Birmingham Dr.',
            'Sioux Falls', 'IA', 'United States of America', '51101');

INSERT INTO person
  (person_id, first_name, last_name, eye_color, birth_date,
    street, city, state, country, postal_code)
  VALUES (null, 'Mary', 'Magaret', 'BR', '1989-07-12', '18 Ontario St.',
            'Cleveland', 'OH', 'United States of America', '44115');


-- Let's add a few favorite foods
INSERT INTO favorite_food
  (person_id, food)
  VALUES (1, 'pizza');

INSERT INTO favorite_food
  (person_id, food)
  VALUES (1, 'eggs with italian dressing');

INSERT INTO favorite_food
  (person_id, food)
  VALUES (2, 'pierogi');
