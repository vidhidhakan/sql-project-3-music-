    Examples for using MySQL with a music database (project 2 sql)
 -------------------------------------------------------------------------------------------------- 

This example SQL project was created to practice writing SQL queries for a job interview. I hope others will find it useful. The data is simple and the listing of record labels, albums, artists and songs is just for example purposes. You can try altering the tables to make them more complete and more interesting.

vidhi dhakan ==== 6feb 2024

Pre requsites

install mysql

 A SQL editing environment such as: SQuirreL SQL Client or IntelliJ IDE or the MySQL Workbench

Usage Notes

fire-up your mysql server if it is not already running: mysql

fire-up your editing environment

create the empty database: create database music;

connect your editing environment to the music database


Database exercises

1. List all artists for each record label sorted by artist name.


2. Which record labels have no artists?


3. List the number of songs per artist in descending order 

4. Which artist or artists have recorded the most number of songs? 

5. Which artist or artists have recorded the least number of songs?  

6. How many artists have recorded the least number of songs? Hint: we can wrap the results of query 5. with another select to give us total artist count.
 

7. Which artists have recorded songs longer than 5 minutes, and if so, how many songs were recorded?  

8. For each artist and album how many songs were less than 5 minutes long? 

9. In which year or years were the most songs recorded?
    ----------------------------------------------------------------------
 

11. List the artist, song and year of the top 5 longest recorded songs  

12. List a table showing the Number of albums recorded for each year.
 

13. What is the max number of recorded albums across all the years? Hint: using the above sql as a temp table  

14. In which year (or years) were the most (max) number of albums recorded, and how many were recorded?  

15. List the total duration of all songs recorded by each artist in descending order.  

16. for which artist and album are there no songs less than 5 minutes long? 

17. Display a table of all artists, albums, songs and song duration, all ordered in ascending order by artist, album and song.  

18. List the top 3 artists with the longest average song duration, in descending with longest average first.  

19. What is the total album length for all songs on the Beatles Sgt. Pepper's album - in minutes and seconds.  

20. Which artists did not release an album during the decades of the 1980's and the 1990's?  

21. Which artists did release an album during the decades of the 1980's and the 1990's?

22
    ----------------------------------------------------------------------------------------------------
