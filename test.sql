SELECT film.title, COUNT(rental_date) AS rented
FROM film
LEFT JOIN
    (SELECT film_id, title, rental_date
    FROM film
    JOIN inventory USING (film_id)
    JOIN rental r USING (inventory_id)
    WHERE DATE_FORMAT(CONVERT(rental_date, DATE), '%Y %M') = '2005 May') sub
    USING (film_id)
GROUP BY film.title;


SELECT f.title, f.length, c.name
FROM film f
JOIN film_category fa USING (film_id)
JOIN category c USING (category_id)
GROUP BY f.title, f.length, c.name;

SELECT film.title, avg_price
FROM film
LEFT JOIN
    (SELECT f.film_id, f.title, AVG(p.amount) AS avg_price
    FROM film f
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r ON r.inventory_id = i.inventory_id
    JOIN payment p ON p.rental_id = r.rental_id
    GROUP BY f.title, f.film_id) sub
    USING (film_id);