-- CORRECTION OF ASSIGNMENT OF DATABASE AND DATA MANAGMENT


use sakila;
-- Question 1

SELECT *
from country ;

-- Question 2

SELECT DISTINCT  COUNT(*) as Number_of_country
from country ;

-- Question 3

SELECT *
FROM country c  
WHERE country='United States';

-- Question 4

SELECT * 
FROM payment p 
WHERE amount IN (1.99,2.99,3.99,4.99);

-- Question 5

insert into country(country_id,country) values(110,'Utopia');



-- Question 6
-- No because a country_id=1 is primary key for another country and primary key can not be duplicated.
-- Question  7

SELECT country_id ,country 
from country c
order by country_id ASC 
LIMIT 11,6;



-- Question 8
select DISTINCT  c.first_name as first_name_of_each_customer
from customer c;

-- Question 9
 SELECT store_id, COUNT(store_id)
 from customer c 
 group by store_id  HAVING COUNT(store_id)>200 ;

-- Question 10

SELECT  first_name , COUNT(first_name) as number_of_duplication 
FROM customer c    
GROUP BY first_name HAVING COUNT(*)>1;


--  Question 11

SELECT a.address,c.city  
FROM city c ,address a 
WHERE c.city_id =a.city_id and c.city  LIKE 'A%';

-- Question 12

-- This query will not  work because natural join  creates an implicit join clause for you based on the common columns in the two tables being joined;
-- Here ,empty relation will be the answer as they have common attributes but not common records(rows) among them to join over.

-- Question 13
SELECT  c.first_name, c.last_name, AVG(p.amount) as Average_Amount
from payment p ,customer c 
where p.customer_id =c.customer_id 
group by p.customer_id ;


-- Question 14


SELECT first_name ,last_name ,city 
from customer c ,city c2 ,address a 
WHERE a.city_id in(SELECT city_id
from address a
WHERE a.city_id=c2.city_id)
AND c.address_id =a.address_id ;


-- Question 15 and 16

select f.title as Title_of_film,f.`length` as Length_of_film from film f where f.`length`>(SELECT MIN(L_i) as L
from (select MAX(length) as L_i ,c.name 
from film f,category c,film_category fc
WHERE f.film_id=fc.film_id 
AND c.category_id=fc.category_id GROUP by fc.category_id) as Length_of)

-- Question 17
SELECT c.first_name , c.last_name ,p.amount 
FROM customer c, payment p 
WHERE p.customer_id =c.customer_id and p.amount >11
GROUP by c.customer_id HAVING COUNT(p.customer_id)>=1; 

-- Question 18
SELECT c.first_name , c.last_name ,p.amount 
FROM customer c, payment p 
WHERE p.customer_id =c.customer_id and p.amount >9
GROUP by c.customer_id  HAVING COUNT(p.customer_id)>=3;


-- Question 19

create VIEW Customers_with_high_price AS select c.first_name ,c.last_name ,p.amount  FROM customer c ,payment p,
rental 
where amount in(SELECT MAX(amount)from payment where c.customer_id=p.customer_id);
SELECT *
FROM Customers_with_high_price

-- Question 20

select c2.country, COUNT(c.customer_id) as Numer_of_customers from customer c ,country c2 ,address a ,city c3 
WHERE country in(SELECT country
from country c4
WHERE c2.country_id=c3.country_id)
and c3.city_id =a.city_id  and a.address_id =c.address_id 
GROUP by country 
order by Numer_of_customers DESC ;








































