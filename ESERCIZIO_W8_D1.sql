-- Esercizio 1
SHOW TABLES;
DESCRIBE actor;
DESCRIBE actor_info;
DESCRIBE address;
DESCRIBE category;
DESCRIBE city;
DESCRIBE country;
DESCRIBE customer;
DESCRIBE customer_list;
DESCRIBE film;
DESCRIBE film_actor;
DESCRIBE film_category;
DESCRIBE film_list;
DESCRIBE film_text;
DESCRIBE inventory;
DESCRIBE language;
DESCRIBE nicer_but_slower_film_list;
DESCRIBE payment;
DESCRIBE rental;
DESCRIBE sales_by_film_category;
DESCRIBE sales_by_store;
DESCRIBE staff;
DESCRIBE staff_list;
DESCRIBE store;

-- Esercizio 2
SELECT COUNT(*) AS TotalCustomers2006
FROM Customer
WHERE YEAR(Create_Date) = 2006;

-- Esercizio 3
SELECT COUNT(*) AS TotalRentals
FROM Rental
WHERE DATE(Rental_Date) = '2006-01-01';

-- Esercizio 4
SELECT 
    film.title,
    customer.first_name,
    customer.last_name,
    customer.email,
    rental.rental_date
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
JOIN 
    customer ON rental.customer_id = customer.customer_id
WHERE 
    rental.rental_date >= CURDATE() - INTERVAL 7 DAY;
    
    -- Esercizio 5
    SELECT 
    category.name AS Category,
    AVG(DATEDIFF(rental.return_date, rental.rental_date)) AS AverageRentalDuration
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name;
    
    -- Esercizio 6
    SELECT 
    MAX(DATEDIFF(return_date, rental_date)) AS LongestRentalDuration
FROM 
    rental;








