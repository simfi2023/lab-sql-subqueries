-- LAB | SQL Subqueries

-- Write SQL queries to perform the following tasks using the Sakila database:
-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

USE sakila;

SELECT * FROM inventory; -- film_id

SELECT * FROM film; -- film_id, title

-- SOLUTION WITHOUT SUBQUERY
SELECT f.title, COUNT(*) AS number_of_copies
FROM film AS f
JOIN inventory AS i ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- WITH SUBQUERY
SELECT COUNT(film_id) AS number_of_copies
FROM inventory
WHERE film_id IN (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
)
GROUP BY film_id;


-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT title 
FROM film
WHERE length > (SELECT AVG(length) FROM film);


-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT actor.*
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film
    JOIN film_actor ON film.film_id = film_actor.film_id
    WHERE film.title = 'Alone Trip'
);