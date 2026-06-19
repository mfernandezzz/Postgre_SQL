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

-- Obtener el promedio de renta por tienda

-- Obtener las 10 rentas mas caras por tienda

-- Obtener los nombres de los clientes y la cantidad de dinero gastado en ambas tiendas


-- Obtener la direccion de cada tienda

-- Obtener el nombre, apellido y direccion de cada cliente

-- Obtener el nombre y apellido del cliente que vive en la ciudad "Apeldoorn"

-- Obtener la categoria de la pelicula "Arabia Dogma"

-- Obtener el nombre y apellido de los actores que participaron en la pelicula "Interview Liaisons"

-- Obtener el nombre del miembro del staff que le rento una copia de la pelicula "Hunchback Imposible" al cliente "Kurt Emmons"

-- Obtener cantidad de veces que el cliente "Vivian Ruiz" rento peliculas

-- Obtener la cantidad de peliculas disponibles en ambas tiendas

-- Obtener todas las ciudades con su pais respectivo

-- Obtener los clientes y el monto total de sus pagos realizados en orden descendente

-- Obtener las categorias y la cantidad de peliculas para cada categoria

-- Obtener el id de los vendedores, su direccion y su primer nombre

-- Obtener los nombres de las peliculas donde actuo el actor "Nick Walhberg"

-- Obtener el id de cada alquiler, el id de la tienda y la direccion de la tienda donde se realizo ese alquiler

-- Obtener la pelicula mas alquilada

-- Obtener el id de cada cliente, la direccion y el id de la tienda a la que accedio

-- Obtener las categorias de peliculas y la cantidad de veces que se rentaron peliculas para cada categoria. Agrupar por nombre de categoria y ordenar por cantidad de rentas de mayor a menor

-- Obtener las categorias de peliculas y las ganancias de rentas de peliculas para cada categoria. Agrupar por categoria y ordenar por suma de categorias de mayor a menor

-- Obtener el id de los clientes, el id de la tienda y la cantidad de dinero gastado en cada tienda

-- Obtener la cantidad de clientes por pais

-- Obtener el nombre y apellido de cada cliente, la cantidad de rentas que realizo y la cantidad de dinero gastado. Agrupar por nombre y ordenar por cantidad de rentas

-- Obtener la cantidad de alquileres por tienda

-- Obtener las ganancias por tienda

-- Obtener cantidad de clientes que visitaron cada tienda

-- Obtener el pais y la cantidad de clientes por pais en orden descendente

-- Obtener las ventas por mes para todo el periodo. Monto total para cada mes del periodo que se tenga datos. Ordenrar por recaudacion de mayor a menor

-- Obtener las categorias de peliculas, la cantidad de rentas por categoria, las ganancias por categoria y el porcentaje que representa lo recaudado por categoria respecto de la recaudacion total. Ordenar por ganancia de mayor a menor

-- Obtener las categorias de peliculas, la cantidad de rentas por categoria y el porcentaje de rentas para cada categoria con respecto de la cantidad maxima de rentas. Ordenar por cantidad de rentas de mayor a menor

-- Identificar los 3 actores cuyas peliculas son las mas alquiladas en cantidad de rentas y recaudacion lograda

-- Obtener el top 6 de clientes que mas dinero gastaron
