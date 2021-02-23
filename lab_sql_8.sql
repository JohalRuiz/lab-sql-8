use sakila;

-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your 
-- output, only select the columns title, length, and the rank.
select title, `length`, dense_rank() over (order by length) as 'Rank' from film;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s 
-- in length column). In your output, only select the columns title, length, rating and the rank.
select title, `length`, rating, dense_rank() over (partition by rating order by length) as 'Rank' from film;

-- 3. How many films are there for each of the categories in the category table. Use appropriate 
-- join to write this query
select * from film_category;
select * from film;

select category_id, count(category_id) from film_category a
join film l on a.film_id = l.film_id
group by category_id
order by category_id;

-- 4. Which actor has appeared in the most films?
select * from actor;
select * from film_actor;
select a.actor_id, l.first_name, l.last_name, count(a.actor_id) from film_actor a
join actor l on a.actor_id = l.actor_id
group by l.actor_id
order by count(actor_id) desc; -- (eventually: limit 1) 
-- So Gina Degeneres it is

-- 5. Most active customer (the customer that has rented the most number of films)
select * from customer;
select * from rental;
select l.first_name, l.last_name, count(a.rental_id) as 'rental_count' from rental a
join customer l on a.customer_id = l.customer_id
group by l.customer_id
order by count(a.rental_id) desc; -- (eventually: limit 1) 
-- So Eleanor Hunt it is
