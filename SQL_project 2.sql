 CREATE DATABASE music;
use music;

-- Record Label table
CREATE TABLE record_label (
  id int unsigned  not null,
  name varchar(50) not null,
  PRIMARY KEY (id),
  UNIQUE KEY uk_name_in_record_label (name)
);

-- Record Label data
INSERT INTO record_label VALUES(1,'Blackened');
INSERT INTO record_label VALUES(2,'Warner Bros');
INSERT INTO record_label VALUES(3,'Universal');
INSERT INTO record_label VALUES(4,'MCA');
INSERT INTO record_label VALUES(5,'Elektra');
INSERT INTO record_label VALUES(6,'Capitol');

select * from record_label;

-- Artist table
CREATE TABLE artist (
  id  		int unsigned not null,
  record_label_id 	int unsigned  not null,
  name 		varchar(50) not null,
  PRIMARY KEY (id),
  KEY fk_record_label_in_artist (record_label_id),
  CONSTRAINT fk_record_label_in_artist FOREIGN KEY (record_label_id) REFERENCES record_label (id),
  UNIQUE KEY uk_name_in_artist (record_label_id, name)
);

-- Artist data
INSERT INTO Artist VALUES(1, 1,'Metallica');
INSERT INTO Artist VALUES(2, 1,'Megadeth');
INSERT INTO Artist VALUES(3, 1,'Anthrax');
INSERT INTO Artist VALUES(4, 2,'Eric Clapton');
INSERT INTO Artist VALUES(5, 2,'ZZ Top');
INSERT INTO Artist VALUES(6, 2,'Van Halen');
INSERT INTO Artist VALUES(7, 3,'Lynyrd Skynyrd');
INSERT INTO Artist VALUES(8, 3,'AC/DC');
INSERT INTO Artist VALUES(9, 6,'The Beatles');

select * from artist;
SELECT * FROM artist ORDER BY id;

-- Album Table
CREATE TABLE album (
  id 	int unsigned not null,
  artist_id  int unsigned not null,
  name     varchar(50)  not null,
  year     int unsigned not null,
  PRIMARY KEY (id),
  KEY fk_artist_in_album (artist_id),
  CONSTRAINT fk_artist_in_album FOREIGN KEY (artist_id) REFERENCES artist (id),
  UNIQUE KEY uk_name_in_album (artist_id, name)
);

-- Album data
INSERT INTO album VALUES(1, 1, '...And Justice For All',1988);
INSERT INTO album VALUES(2, 1, 'Black Album',1991);
INSERT INTO album VALUES(3, 1, 'Master of Puppets',1986);
INSERT INTO album VALUES(4, 2, 'Endgame',2009);
INSERT INTO album VALUES(5, 2, 'Peace Sells',1986);
INSERT INTO album VALUES(6, 3, 'The Greater of 2 Evils',2004);
INSERT INTO album VALUES(7, 4, 'Reptile',2001);
INSERT INTO album VALUES(8, 4, 'Riding with the King',2000);
INSERT INTO album VALUES(9, 5, 'Greatest Hits',1992);
INSERT INTO album VALUES(10, 6, 'Greatest Hits',2004);
INSERT INTO album VALUES(11, 7, 'All-Time Greatest Hits',1975);
INSERT INTO album VALUES(12, 8, 'Greatest Hits',2003);
INSERT INTO album VALUES(13, 9, 'Sgt. Pepper''s Lonely Hearts Club Band', 1967);

select * from Album

-- Song table

CREATE TABLE song (
  id int unsigned not null,
  album_id int unsigned not null,
  name varchar(50) not null,
  duration decimal not null,
  PRIMARY KEY (id),
  KEY fk_album_in_song (album_id),
  CONSTRAINT fk_album_in_song FOREIGN KEY (album_id) REFERENCES album (id),
  UNIQUE KEY uk_name_in_song (album_id, name)
);


-- Song data
INSERT INTO song VALUES(1,1,'One',7.25);
INSERT INTO song VALUES(2,1,'Blackened',6.42);

INSERT INTO song VALUES(3,2,'Enter Sandman',5.3);
INSERT INTO song VALUES(4,2,'Sad But True',5.29);

INSERT INTO song VALUES(5,3,'Master of Puppets',8.35);
INSERT INTO song VALUES(6,3,'Battery',5.13);

INSERT INTO song VALUES(7,4,'Dialectic Chaos',2.26);
INSERT INTO song VALUES(8,4,'Endgame',5.57);

INSERT INTO song VALUES(9,5,'Peace Sells',4.09);
INSERT INTO song VALUES(10,5,'The Conjuring',5.09);

INSERT INTO song VALUES(11,6,'Madhouse',4.26);
INSERT INTO song VALUES(12,6,'I am the Law',6.03);

INSERT INTO song VALUES(13,7,'Reptile',3.36);
INSERT INTO song VALUES(14,7,'Modern Girl',4.49);

INSERT INTO song VALUES(15,8,'Riding with the King',4.23);
INSERT INTO song VALUES(16,8,'Key to the Highway',3.39);

INSERT INTO song VALUES(17,9,'Sharp Dressed Man',4.15);
INSERT INTO song VALUES(18,9,'Legs',4.32);

INSERT INTO song VALUES(19,10,'Eruption',1.43);
INSERT INTO song VALUES(20,10,'Hot For Teacher',4.43);

INSERT INTO song VALUES(21,11,'Sweet Home Alabama',4.45);
INSERT INTO song VALUES(22,11,'Free Bird',14.23);

INSERT INTO song VALUES(23,12,'Thunderstruck',4.52);
INSERT INTO song VALUES(24,12,'T.N.T',3.35);

INSERT INTO song VALUES(25,13,'Sgt. Pepper''s Lonely Hearts Club Band', 2.0333);
INSERT INTO song VALUES(26,13,'With a Little Help from My Friends', 2.7333);
INSERT INTO song VALUES(27,13,'Lucy in the Sky with Diamonds', 3.4666);
INSERT INTO song VALUES(28,13,'Getting Better', 2.80);
INSERT INTO song VALUES(29,13,'Fixing a Hole', 2.60);
INSERT INTO song VALUES(30,13,'She''s Leaving Home', 3.5833);
INSERT INTO song VALUES(31,13,'Being for the Benefit of Mr. Kite!',2.6166);
INSERT INTO song VALUES(32,13,'Within You Without You',5.066);
INSERT INTO song VALUES(33,13,'When I''m Sixty-Four',2.6166);
INSERT INTO song VALUES(34,13,'Lovely Rita', 2.7);
INSERT INTO song VALUES(35,13,'Good Morning Good Morning', 2.6833);
INSERT INTO song VALUES(36,13,'Sgt. Pepper''s Lonely Hearts Club Band (Reprise)', 1.3166);
INSERT INTO song VALUES(37,13,'A Day in the Life', 5.65);

show tables;

--questions--
1.List all artists for each record label sorted by artist name.

select * from Artist order by id asc
select * from record_label

select a.name as "Artist name", r.name as "record label name" 
from artist as a 
join record_label as r 
on a.record_label_id = r.id

 2. Which record labels have no artists?

 select * from artist
 select * from record_label

select r.name "record label name"
from record_label as r 
left join artist as a 
on r.id = a.record_label_id
where a.record_label_id is null;

3.List the number of songs per artist in descending order

select * from song
select * from artist
select * from album

select ar.name as "artist name", count(*) as "number of songs"
from song as s 
join album as al
on s.album_id = al.id
join artist as ar 
on al.artist_id = ar.id
group by ar.name
order by count(*) desc;

4. Which artist or artists have recorded the most number of songs?

use music
select * from song
select * from album
select * from artist

select count(*) as "number of songs", ar.name as "artist name"
from song as s 
join album as al 
on s.album_id = al.id
join artist as ar 
on ar.id = al.artist_id
group by ar.name
order by count(*) desc
limit 1;

5.Which artist or artists have recorded the least number of songs?

select * from artist
select * from album
select * from Song
doubt

6. How many artists have recorded the least number of songs?
doubt

7.which artists have recorded songs longer than 5 minutes, and how many songs was that?

select ar.name, count(*) as "number of songs longer than 5 min"
from Song as s 
join album as al 
on s.album_id = al.id 
join artist as ar 
on ar.id = al.artist_id
where s.duration > 5 
group by ar.name;

8. for each artist and album how many songs were less than 5 minutes long?

select ar.name as "artist name", al.name as "album name", count(*) as "number of songs less than 5min"
from song as s 
join album as al 
on s.album_id = al.id 
join artist as ar 
on ar.id = al.artist_id
where s.duration < 5
group by ar.name, al.name;

9.  in which year or years were the most songs recorded?

select * from Song
select * from album

select year as "year", count(*) as "number of songs recorded"
from artist as ar 
join album as al 
on ar.id = al.artist_id
join song as s 
on al.id = s.album_id
group by year 
order by count(*) desc
limit 1 ;

10. list the artist, song and year of the top 5 longest recorded songs

select * from Song
select * from artist

select ar.name as "artist name", al.name as "album name", s.name as "song name", al.year as "album year", s.duration as "song duration"
from song as s 
join album as al 
on s.album_id = al.id 
join artist as ar 
on ar.id = al.artist_id
order by s.duration DESC
limit 5;

11.  Number of albums recorded for each year

select al.year, count(*) as "number of albums recorded"
from Album as al 
group by al.year;

 12.What is the max number of recorded albums across all the years?

 select MAX(count) as "max number of recorded albums"
 from
 (select al.year, count(*) as "count"
 from album as al 
 group by al.year)
 as temp;
 
13.  In which year (or years) were the most (max) number of albums recorded, and how many were recorded?

SELECT
    al.year AS "Year",
    count(*) AS "Number of Albums Recorded"
FROM
    album al
GROUP BY
    al.year
ORDER BY
    COUNT(*) DESC
LIMIT 1;

14. total duration of all songs recorded by each artist in descending order

select * from artist
select * from song

select ar.name as "artist name", sum(duration)as "total duration"
from song as s  
join album as al 
on s.album_id = al.id 
join artist as ar 
on al.artist_id = ar.id 
group by ar.name 
order by sum(duration) DESC

15.for which artist and album are there no songs less than 5 minutes long?

select * from song
select * from artist 
select * from Album

select
   ar.name "Artist Name",
   al.name "Album Name" 
from
   artist ar left join album al on ar.id = al.artist_id
             left join song s on s.album_id = al.id 
where s.id IS NULL OR s.duration > 5 

16.Display a table of all artists, albums, songs and song duration 
--     all ordered in ascending order by artist, album and song  

select * from artist
select * from album
select * from song

select ar.name as "artist name", al.name as "album name", s.name as "song name", s.duration
from artist as ar 
join album as al 
on ar.id = al.artist_id
join song as s 
on s.album_id = al.id 
order by ar.name, al.name, s.name, s.duration;

17.List the top 3 artists with the longest average song duration, in descending with longest average first.

select ar.name , avg(duration)
from song as s 
join album as al 
on s.album_id = al.id 
join artist as ar 
on al.artist_id = s.id 
group by ar.name 
order by avg(duration) desc
limit 3;

18.Total album length for all songs on the Beatles Sgt. Pepper's album - in minutes and seconds.
doubt


19.  Which artists did not release an album during the decades of the 1980's and the 1990's?

select * from artist
select * from album

select distinct ar.name
from artist as ar 
left join album as al
on ar.id = al.artist_id
where year >= 1980 or year >=1990
and year is null;

 20. Which artists did release an album during the decades of the 1980's and the 1990's? 


 select distinct ar.name
from artist as ar 
left join album as al
on ar.id = al.artist_id
where year >= 1980 or year >=1990
and year is not null
order by ar.name;








 









  









