-- Obtener la categoria de la pelicula 'Arabia Dogma'
SELECT name
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
WHERE film_id IN (
	SELECT film_id
	FROM film
	WHERE film.title = 'Arabia Dogma'
);

-- Obtener todos los nombres de peliculas donde hayan participado los actores que participaron en la pelicula con id=14
SELECT film.title AS title
FROM film
LEFT JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE actor_id in (
	SELECT actor_id
	FROM film_actor
	WHERE film_id = 14
);
--para verificar esta consulta, se obtienen los actores que participaron en la pelicula con id=14
SELECT actor.first_name, actor.last_name
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_id = 14;
--luego, obtener la cantidad de peliculas en las que actuo cada actor
SELECT count(film_id)
FROM film_actor
LEFT JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'Rock' and actor.last_name = 'Dukakis';

-- Obtener todas las peliculas con categoria "Action"
SELECT film.title AS title
FROM film
WHERE film_id in (
	SELECT film_id
	FROM film_category
	WHERE category_id = 1  --el id de la categoria action, previamente obtenido con un select
);
SELECT film.title
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
WHERE category_id in (
	SELECT category_id
	FROM film_category
	WHERE category_id = 1
);

-- Obtener todos los clientes de pais numero 10 (country_id = 10)
SELECT customer.first_name, customer.last_name
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
LEFT JOIN city
ON address.city_id = city.city_id
WHERE country_id in (
	SELECT country_id
	FROM city
	WHERE country_id = 10
);

-- Obtener la cantidad de rentas que se hicieron para las peliculas de categoria "Sci-Fi"
SELECT count(rental.rental_id)
FROM rental
LEFT JOIN inventory
ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film_category
ON inventory.film_id = film_category.film_id
WHERE film_category.category_id in (
	SELECT category.category_id
	FROM category
	WHERE category.name = 'Sci-Fi'
);

-- Obtener las ganancias que obtuvo la categoria de pelicula "Foreign"
SELECT SUM(payment.amount)
FROM payment
LEFT JOIN rental
ON payment.rental_id = rental.rental_id
LEFT JOIN inventory
ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film_category
ON inventory.film_id = film_category.film_id
WHERE film_category.category_id IN (
	SELECT category_id
	FROM category
	WHERE category.name = 'Foreign'
);

-- Mostrar los nombres de las peliculas en las que actuo el actor "Nick Wahlberg"
SELECT film.title
FROM film
LEFT JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IN (
	SELECT actor_id
	FROM actor
	WHERE actor.first_name = 'Nick' and actor.last_name = 'Wahlberg'
);

-- Seleccionar los clientes que hayan realizado pagos mayores al AVG de los pagos totales

-- Seleccionar las peliculas cuya ganancia asociada sea mayor a el AVG de los pagos totales

-- Seleccionar los paises cuya cantidad de clientes sea inferior al AVG con respecto al total de clientes por pais
