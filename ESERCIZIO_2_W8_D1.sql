-- Esercizio 1

SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id AND MONTH(rental.rental_date) = 1 AND YEAR(rental.rental_date) = 2006
WHERE rental.rental_id IS NULL;

-- Esercizio 2

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.rental_date BETWEEN '2005-10-01' AND '2005-12-31'
GROUP BY film.title
HAVING rental_count > 10;

-- Esercizio 3

SELECT COUNT(*) AS TotalRentals
FROM rental
WHERE DATE(rental_date) = '2006-01-01';

-- Esercizio 4
SELECT SUM(payment.amount) AS TotalWeekendRevenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
WHERE DAYOFWEEK(rental.rental_date) IN (7, 1);  -- 7 = Saturday, 1 = Sunday

-- Esercizio 5
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS TotalSpent
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id
ORDER BY TotalSpent DESC
LIMIT 1;

-- Esercizio 6

SELECT film.title, AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS AvgRentalDuration
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY AvgRentalDuration DESC
LIMIT 5;

-- Eserzio 7 

SELECT AVG(DATEDIFF(next_rental.rental_date, rental.rental_date)) AS AvgTimeBetweenRentals
FROM rental
JOIN rental AS next_rental ON rental.customer_id = next_rental.customer_id AND rental.rental_date < next_rental.rental_date
GROUP BY rental.customer_id;

-- Esercizio 8

SELECT MONTH(rental_date) AS Month, COUNT(*) AS RentalCount
FROM rental
WHERE YEAR(rental_date) = 2005
GROUP BY MONTH(rental_date);

-- Esercizio 9 

SELECT film.title, rental.rental_date, COUNT(rental.rental_id) AS RentalCount
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title, rental.rental_date
HAVING RentalCount >= 2;

-- Esercizo 10

SELECT AVG(DATEDIFF(return_date, rental_date)) AS AvgRentalDuration
FROM rental;


