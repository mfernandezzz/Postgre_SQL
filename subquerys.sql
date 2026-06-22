-- ¿Cual es la categoria de la pelicula "Arabia Dogma"?

-- Obtener todos los nombres de peliculas donde hayan participado los actores que participaron en la pelicula con id=14
SELECT film.title
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


-- Obtener todos los clientes de los que recibio pagos el miembro del staff con id=1

-- Obtener todas las peliculas con categoria "Action"

-- Obtener todos los clientes de pais numero 10 (country_id = 10)

-- Obtener el id de todos los clientes que han visto peliculas en japones

-- Obtener la cantidad de rentas que se hicieron para las peliculas de categoria "Sci-Fi"

-- Obtener las ganancias que obtuvo la categoria de pelicula "Foreign"

-- Mostrar los nombres de las peliculas en las que actuo el actor "Nick Wahlberg"
