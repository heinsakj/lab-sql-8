-- 1. Write a query to display for each store its store ID, city, and country.
SELECT * 
FROM store;
-- JOIN ON address_id
SELECT *
FROM address;
-- JOIN ON city_id
SELECT *
FROM city;
-- JOIN ON country_id
SELECT *
FROM country;

SELECT s.store_id AS 'Store ID', c.city AS 'City', cy.country AS 'Country'
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country cy
ON c.country_id = cy.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT * 
FROM store;
-- JOIN ON store_id
SELECT * 
FROM customer;
-- JOIN ON customer_id
SELECT * 
FROM payment;

SELECT s.store_id, CONCAT('$', FORMAT(SUM(p.amount),2)) AS 'Revenue'
FROM store s
JOIN customer c
ON s.store_id = c.store_id
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY s.store_id
ORDER BY SUM(p.amount) DESC;

-- 3. Which film categories are longest?
-- AVG length with genre categories
SELECT * 
FROM category;
-- JOIN ON category_id
SELECT *
FROM film_category;
-- JOIN ON film_id
SELECT *
FROM film;

SELECT c.name, AVG(f.length) AS 'AVG length'
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

-- 4. Display the most frequently rented movies in descending order.
-- JOIN film title and inventory
SELECT *
FROM film;
-- JOIN ON film_id
SELECT * 
FROM inventory;
-- JOIN ON inventory_id
SELECT *
FROM rental;

SELECT f.title, r.rental_date
FROM film f 
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
ORDER BY r.rental_date DESC;

-- 5. List the top five genres in gross revenue in descending order.
-- HOW much money did they make?

SELECT *
FROM category;
-- JOIN ON category_id
SELECT *
FROM film_category;
-- JOIN ON film_id
SELECT *
FROM film;
-- JOIN ON inventory_id
SELECT *
FROM inventory;
-- JOIN ON rental_id
SELECT *
FROM rental;
-- JOIN ON rental_id
SELECT *
FROM payment;


SELECT c.name, CONCAT('$', FORMAT(SUM(p.amount),2)) AS 'Gross Revenue'
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT *
FROM film;
-- JOIN ON film_id
SELECT *
FROM inventory;
-- JOIN ON inventory_id
SELECT *
FROM rental;

SELECT f.title, i.store_id, r.return_date
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.rental_id
WHERE f.title = "ACADEMY DINOSAUR" AND i.store_id = '1';

-- from the output I can see that 4 movies should be available in store 1

-- 7. Get all pairs of actors that worked together.
-- Self join
SELECT *
FROM film_actor;

SELECT 
    fa1.actor_id, a1.first_name, a1.last_name, fa2.actor_id, a2.first_name, a2.last_name
FROM
    sakila.film_actor fa1
    JOIN
    sakila.film_actor fa2 ON (fa1.actor_id < fa2.actor_id) AND (fa1.film_id = fa2.film_id)
    JOIN
    sakila.actor a1 ON (fa1.actor_id = a1.actor_id)
    JOIN
    sakila.actor a2 ON (fa2.actor_id = a2.actor_id);

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
-- DIFFICULT
SELECT *
FROM film; -- title
-- JOIN ON film_id
SELECT * 
FROM inventory;
-- JOIN on inventory_id
SELECT *
FROM rental;
-- JOIN on customer_id
SELECT * 
FROM customer;

SELECT f.film_id, title, r.customer_id, COUNT(*) AS count
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY r.customer_id, f.film_id
HAVING count >= 3
ORDER BY count DESC;
 

-- 9. For each film, list actor that has acted in more films.
SELECT *
FROM actor;
-- JOIN ON actor_id
SELECT * 
FROM film_actor;

SELECT *
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film_actor fa2 ON (fa1.actor_id < fa2.actor_id);
