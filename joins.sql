-- Obtener todos los clientes de los que recibio pagos el miembro del staff con id=1
SELECT DISTINCT customer.first_name, customer.last_name
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.staff_id = 2;
--para verificar esta query, se obtiene el id de cada miembro del staff y la cantidad de clientes de los que recibio pagos
SELECT payment.staff_id AS staffM, COUNT(DISTINCT customer.customer_id) AS clients
FROM payment
LEFT JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY staffM;

-- Obtener las categorias de peliculas y sus ganancias
SELECT category.name as category, sum(payment.amount) as amount
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
LEFT JOIN inventory
ON film_category.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category
ORDER BY amount DESC;

-- Obtener la cantidad de rentas por categoria de pelicula
SELECT category.name as category, count(rental.rental_id) as rentals
FROM rental
LEFT JOIN inventory
ON rental.inventory_id = inventory.inventory_id
LEFT JOIN film_category
ON inventory.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
GROUP BY category
ORDER BY rentals DESC;

-- Obtener los idiomas y la cantidad de clientes que alquilaron peliculas para cada idioma
SELECT name as language, count(customer.customer_id) as customers
FROM language
LEFT JOIN film
ON language.language_id = film.language_id
LEFT JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN customer
ON rental.customer_id = customer.customer_id
GROUP BY language
ORDER BY customers DESC;

-- Obtener la cantidad de clientes por pais
SELECT country as country, count(customer.customer_id) as count
FROM country
LEFT JOIN city
ON country.country_id = city.country_id
LEFT JOIN address
ON city.city_id = address.city_id
LEFT JOIN customer
ON address.address_id = customer.address_id
GROUP BY country
ORDER BY count DESC;

-- Obtener los clientes, la cantidad de rentas y la cantidad de dinero gastado
SELECT customer.first_name as name, customer.last_name as surname, count(rental.rental_id) as rentals, sum(payment.amount) as payment
FROM customer
LEFT JOIN rental
ON customer.customer_id = rental.customer_id
LEFT JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY name, surname
ORDER BY payment DESC;

-- Obtener la renta mas alta para cada tienda
SELECT MAX(payment.amount) as amount, store.store_id as store_id, staff.first_name as name, staff.last_name as surname
FROM payment
LEFT JOIN rental
ON payment.rental_id = rental.rental_id
LEFT JOIN staff
ON rental.staff_id = staff.staff_id
LEFT JOIN store
ON staff.store_id = store.store_id
GROUP BY store.store_id, name, surname
ORDER BY amount DESC;

-- Obtener la direccion de cada tienda
SELECT store.store_id, address.address
FROM store
LEFT JOIN address
ON store.address_id = address.address_id;

-- Obtener el nombre, apellido y direccion de cada cliente
SELECT customer.first_name as name, customer.last_name as surname, address.address
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id;

-- Obtener el nombre y apellido del cliente que vive en la ciudad "Apeldoorn"
SELECT customer.first_name as name, customer.last_name as surname
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
WHERE city.city = 'Apeldoorn';

-- Obtener la categoria de la pelicula "Arabia Dogma"
SELECT category.name
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film
ON film_category.film_id = film.film_id
WHERE film.title = 'Arabia Dogma';

-- Obtener el nombre y apellido de los actores que participaron en la pelicula "Interview Liaisons"
SELECT actor.first_name, actor.last_name
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE film.title = 'Interview Liaisons';

-- Obtener cantidad de veces que el cliente "Vivian Ruiz" rento peliculas
SELECT count(rental.rental_id) as rentals
FROM rental
LEFT JOIN customer
ON rental.customer_id = customer.customer_id
WHERE customer.first_name = 'Vivian' and customer.last_name = 'Ruiz';

-- Obtener la cantidad de peliculas disponibles en ambas tiendas
SELECT store.store_id as store_id, count(film.film_id)
FROM store
LEFT JOIN inventory
ON store.store_id = inventory.store_id
LEFT JOIN film
ON inventory.film_id = film.film_id
GROUP BY store.store_id; --la cantidad total de peliculas es 1000, en el inventario se encuentra una cantidad mayor de peliculas debido a que existe mas de una copia por pelicula

-- Obtener todas las ciudades con su pais respectivo
SELECT city.city as city, country.country as country
FROM city
INNER JOIN country
ON city.country_id = country.country_id;

-- Obtener los clientes y el monto total de sus pagos realizados en orden descendente
SELECT customer.first_name as name, customer.last_name as surname, sum(amount) as amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY name, surname
ORDER BY amount DESC;

-- Obtener las categorias y la cantidad de peliculas para cada categoria
SELECT category.name as category, count(film.film_id) as count
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
LEFT JOIN film
ON film_category.film_id = film.film_id
GROUP BY category
ORDER BY count desc;

-- Obtener el id de los vendedores, su primer nombre y su direccion
SELECT staff.staff_id, staff.first_name, address.address
FROM staff
LEFT JOIN address
ON staff.address_id = address.address_id;

-- Obtener los nombres de las peliculas donde actuo el actor "Nick Wahlberg"
SELECT film.title as film
FROM film
LEFT JOIN film_actor
ON film.film_id = film_actor.film_id
LEFT JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'Nick' and actor.last_name = 'Wahlberg';

-- Obtener el id de cada alquiler, el id de la tienda y la direccion de la tienda donde se realizo ese alquiler
SELECT rental.rental_id as rental_id, store.store_id as store_id, address.address as address
FROM rental
INNER JOIN staff
ON rental.staff_id = staff.staff_id
INNER JOIN store
ON staff.store_id = store.store_id
INNER JOIN address
ON store.address_id = address.address_id
GROUP BY rental.rental_id, store.store_id, address.address;

-- Obtener la pelicula mas alquilada
SELECT film.title as title, count(rental.rental_id) as rentals
FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY title
ORDER BY rentals DESC
LIMIT 1;

-- Obtener la cantidad de clientes por pais
SELECT country.country as country, count(customer.customer_id) as customers
FROM country
LEFT JOIN city
ON country.country_id = city.country_id
LEFT JOIN address
ON city.city_id = address.city_id
LEFT JOIN customer
ON address.address_id = customer.address_id
GROUP BY country
ORDER BY customers DESC;

-- Obtener la cantidad de alquileres por tienda
SELECT store.store_id as store_id, count(rental.rental_id) as rentals
FROM store
LEFT JOIN staff
ON store.store_id = staff.store_id
LEFT JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY store.store_id;

-- Obtener las ganancias por tienda
SELECT store.store_id as store_id, sum(payment.amount) as profit
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- Obtener cantidad de clientes que visitaron cada tienda
SELECT store.store_id as store_id, count(customer.customer_id) as clients
FROM store
LEFT JOIN customer
ON store.store_id = customer.store_id
GROUP BY store.store_id;

-- Identificar los 3 actores cuyas peliculas son las mas alquiladas en cantidad de rentas y recaudacion lograda
SELECT actor.first_name as name, actor.last_name as last_name, count(rental.rental_id) as rentals, sum(payment.amount) as amount
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
LEFT JOIN inventory
ON film_actor.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY name, last_name
ORDER BY rentals DESC
LIMIT 3;

-- Obtener el top 6 de clientes que mas dinero gastaron
SELECT customer.first_name as name, customer.last_name as last_name, sum(payment.amount) as amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY name, last_name
ORDER BY amount DESC
LIMIT 6;

-- Obtener las 10 rentas mas caras por tienda
SELECT payment.rental_id as rental_id, payment.amount as amount
FROM payment
LEFT JOIN staff
ON payment.staff_id = staff.staff_id
WHERE staff.store_id = 1 --2
GROUP BY payment.rental_id, payment.amount, staff.store_id
ORDER BY amount DESC
LIMIT 10;

-- Obtener el id de los clientes, el id de la tienda y la cantidad de dinero gastado en cada tienda
SELECT customer.customer_id as customer, customer.store_id as store, sum(payment.amount) as amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer, store;

-- Obtener el nombre del miembro del staff que le rento una copia de la pelicula "Hunchback Impossible" al cliente "Kurt Emmons"
SELECT staff.first_name as name, staff.last_name as surname
FROM staff
LEFT JOIN rental
ON staff.staff_id = rental.staff_id
LEFT JOIN inventory
ON rental.inventory_id = inventory.inventory_id
WHERE inventory.film_id = 439 and rental.customer_id = 547; --previamente se obtiene el id de la pelicula y el id del cliente

-- Obtener el id de cada cliente, la direccion y el id de la tienda a la que accedio
SELECT customer.customer_id as customer_id, address.address as address, customer.store_id
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
LEFT JOIN store
ON address.address_id = store.address_id
GROUP BY customer_id, address.address, store.store_id
ORDER BY customer_id ASC;

-- Obtener el nombre y apellido de cada cliente, la cantidad de rentas que realizo y la cantidad de dinero gastado
SELECT customer.first_name as name, customer.last_name as last_name, count(rental.rental_id) as rentals, sum(payment.amount) as amount
FROM customer
LEFT JOIN rental
ON customer.customer_id = rental.customer_id
LEFT JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY name, last_name
ORDER BY rentals DESC;

-- Obtener las ventas por mes para todo el periodo. Monto total para cada mes del periodo que se tenga datos. Ordenar por recaudacion de mayor a menor
SELECT rental_date
FROM rental
ORDER BY rental_date DESC --ASC
LIMIT 1; --primero se obtiene la fecha inicial y la fecha final del periodo que se quiera evaluar

SELECT to_char(rental.rental_date, 'YYYY-MM') as month, sum(payment.amount) as profit
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE rental.rental_date BETWEEN '2005-05-24' and '2006-03-14' --el rango de fechas debe incluir un mes mas con respecto a la fecha final
GROUP BY month
ORDER BY profit DESC;

-- Obtener las categorias de peliculas, la cantidad de rentas por categoria y las ganancias por categoria
SELECT category.name as category, count(rental.rental_id) as rentals, sum(payment.amount) as amount
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
LEFT JOIN inventory
ON film_category.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category
ORDER BY amount DESC;
