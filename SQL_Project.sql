use world;
show tables;

show databases;

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

show create table  cities

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
WHERE co.sub_region = 'Southern Europe' AND Year(create_on) = 2021
GROUP BY co.country_name
ORDER BY LENGTH(co.country_name), UPPER(co.country_name) ASC;

select * from cities
select * from countries
select * from currencies
select * from languages





Q6-----------------------------------------------------

select co.country_name, ci.city_name, length(ci.population)
from countries as co
join cities as ci
on co.country_code_2 = ci.country_code_2
where city.name


show create table cities;






Q7-------------------------------------






 


























 










   





 



 
 





