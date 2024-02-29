use world;
show tables;

show databases;
use
create table cities(
    city_name VARCHAR(25),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    country_code_2 CHAR(2),
    capital BOOLEAN,
    population INT,
    insert_date DATE
);   

drop table cities

LOAD DATA INFILE 'd:/cities.csv'
INTO TABLE cities
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

show create table  cities....

CREATE TABLE countries (
    country_name VARCHAR(255),
    country_code_2 CHAR(2),
    country_code_3 CHAR(3),
    region VARCHAR(255),
    sub_region VARCHAR(255),
    intermediate_region VARCHAR(255)
); 

LOAD DATA INFILE'd:/c.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM countries;

CREATE TABLE currencies (
    country_code_2 CHAR(2),
    currency_name VARCHAR(255),
    currency_code VARCHAR(3)
);

LOAD DATA INFILE'd:/currencies.csv'
INTO TABLE currencies
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM currencies;

CREATE TABLE languages (
    language VARCHAR(255),
    country_code_2 CHAR(2)
);

LOAD DATA INFILE'd:/languages.csv'
INTO TABLE languages
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM languages;
-------------
USE WORLD;

ALTER TABLE countries
ADD COLUMN country_id INT AUTO_INCREMENT PRIMARY KEY FIRST;
select * from countries;

ALTER TABLE countries
ADD COLUMN created_on DATE DEFAULT CURRENT_DATE;
SELECT * FROM COUNTRIES;

ALTER TABLE cities
ADD COLUMN country_id INT AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE cities
CHANGE COLUMN id country_id INT;

select * from cities;

ALTER TABLE currencies
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE currencies
CHANGE COLUMN id country_id INT;

SELECT * FROM currencies;


ALTER TABLE languages
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE languages
CHANGE COLUMN id country_id INT;

SELECT * FROM languages;

----------- one to one reltnship

ALTER TABLE currencies
ADD FOREIGN KEY (country_id) REFERENCES countries(country_id);
select * from currencies;

-- Add 'country_id' as a foreign key in 'cities'
ALTER TABLE cities
ADD FOREIGN KEY (country_id) REFERENCES countries(country_id);

-- Add 'country_id' as a foreign key in 'currencies'
ALTER TABLE currencies
ADD FOREIGN KEY (country_id) REFERENCES countries(country_id);

-- Add 'country_id' as a foreign key in 'languages'
ALTER TABLE languages
ADD FOREIGN KEY (country_id) REFERENCES countries(country_id);

------------------------------------------------------------------------------
Q2----
select region, count(*) as countrycount
from countries
group by region
order by count(*) desc;

Q3----------------------------------------------
 
select sub_region, count(*) as citycount
from countries as co
join cities as ci
on co.country_code_2 = ci.country_code_2
group by sub_region
order by count(*) asc;

select * from cities
select * from countries

Q4-------------------------------------------------

SELECT UPPER(country_name) AS Country, COUNT(*) AS CityCount
FROM countries co
LEFT JOIN cities ci ON co.country_code_2 = ci.country_code_2
WHERE co.sub_region = 'Northern Europe'
GROUP BY co.country_name
ORDER BY LENGTH(co.country_name), UPPER(co.country_name) ASC;

select * from countries;

Q5--------------------------------------------------

SELECT UPPER(country_name) AS Country, COUNT(*) AS CityCount
FROM countries co
LEFT JOIN cities ci ON co.country_code_2 = ci.country_code_2
WHERE co.sub_region = 'Southern Europe' AND Year(insert_date) = 2021
GROUP BY co.country_name
ORDER BY right(country_name,1), citycount;

select * from countries
select * from cities
/* so when i want to use last letter than i will use right(country_name ,1) and when i want first letter than left(country_name,1)*/
Q6-----------------------------------------------

SELECT co.country_name 
FROM countries AS co 
LEFT JOIN cities AS ci
ON co.country_code_2 = ci.country_code_2
WHERE co.region = 'Asia'
  AND (ci.insert_date IS NULL OR ci.insert_date NOT BETWEEN '2021-06-01' AND '2021-09-30');

  

List all of the countries in the region of Asia that did NOT have a city with an inserted date from June 2021 through Sept 2021.

Q7----------------------------------------------------
use world
select * from cities
select * from countries

WITH palindromic_cities AS(
  SELECT
    co.country_name,
    c.city_name,
    c.population,
    LENGTH(c.city_name) AS city_name_length
  FROM
    cities AS c
    JOIN countries AS co ON c.country_code_2 = co.country_code_2
  WHERE
    co.sub_region = 'Western Asia'
    AND c.city_name = REVERSE(c.city_name)
),
city_name_with_roman_length AS (
  SELECT
    country_name,
    city_name,
    population,
    city_name_length,
    CASE
      WHEN city_name_length = 1 THEN 'I'
      WHEN city_name_length = 2 THEN 'II'
      WHEN city_name_length = 3 THEN 'III'
      -- Add more cases as needed
      ELSE 'N/A'
    END AS roman_numeral_length
  FROM
    palindromic_cities
)
SELECT
  country_name,
  city_name,
  FORMAT(population, 0) AS formatted_population,
  roman_numeral_length
FROM
  city_name_with_roman_length
ORDER BY
  city_name_length DESC, city_name ASC;

Q8----------------------------------------------

SELECT
       UPPER(co.country_name) AS country,
      CASE WHEN SUM(ci.population % 2) = 0 THEN 'Even' ELSE 'Odd' END AS population_type
from countries co 
join cities ci 
on co.country_code_2 = ci.country_code_2
where co.country_name like '%STAN'
and year(ci.insert_date) = 2022
group by co.country_name
order by population_type asc, co.country_name asc;

/*so here whenever there is even number to find than use population % 2 =0 */

Q9-------------------------------------
select * from cities
select * from countries

WITH ranked_cities AS (
  SELECT
    co.sub_region,
    c.city_name,
    c.population,
    ROW_NUMBER() OVER (PARTITION BY co.sub_region ORDER BY c.population DESC) AS city_rank
  FROM
    cities c
    JOIN countries co  ON c.country_code_2 = co.country_code_2
)
SELECT
  sub_region,
  city_name,
  population
FROM
  ranked_cities
WHERE
  city_rank = 3
ORDER BY
  sub_region;

----------------------------------------------------------------
Q 10

WITH my_cte AS(
    SELECT 
    co.country_name,
    ROW_NUMBER() OVER (ORDER BY co.country_name) AS RN,
    NTILE(3) OVER (ORDER BY co.country_name) AS NT 
FROM countries as co
join languages as l 
on co.country_code_2 = l.country_code_2
where co.sub_region = 'western asia'
and l.language = 'arabic'
)
SELECT 
country_name,
RN 
FROM my_cte
where NT = 3;

 SELECT * FROM world.COUNTRIES
 select * from world.cities
 select * from world.currencies
 select * from world.languages


 Q 11 ---------------------------------------------------
 use world
 SELECT co.country_name,
 ci.city_name,
 ci.population,
 GROUP_CONCAT(DISTINCT cu.currency_name) AS currency_name,
 GROUP_CONCAT(DISTINCT l.language) AS languages_spoken
from countries as co 
join cities as ci 
on co.country_code_2 = ci.country_code_2
join currencies as cu 
on co.country_code_2 = cu.country_code_2
join languages as l 
on co.country_code_2 = l.country_code_2
where co.sub_region = 'northern africa'
group by co.country_name, ci.city_name, ci.population;

Q 12 questn-------------------







 


 


















 


























 










   





 



 
 





