select * from netflix_raw
-----------------
select distinct show_id
from netflix_raw
order by show_id
select distinct type
from netflix_raw
order by type
select distinct  title
from netflix_raw
order by title
select distinct director
from netflix_raw
order by director
select distinct cast
from netflix_raw
order by cast
select distinct country
from netflix_raw
order by country
select distinct rating
from netflix_raw
order by rating
select distinct duration
from netflix_raw
order by duration
select distinct listed_in
from netflix_raw
order by listed_in
-----------------
DROP TABLE [dbo].[netflix_raw]

CREATE TABLE [dbo].[netflix_raw](
	[show_id] [varchar] (10) NULL,
	[type] [varchar] (10) NULL,
	[title] [nvarchar] (300) NULL,
	[director] [varchar] (400) NULL,
	[cast] [varchar] (1000) NULL,
	[country] [varchar] (250) NULL,
	[date_added] [varchar] (25) NULL,
	[release_year] [int] NULL,
	[rating] [varchar] (15) NULL,
	[duration] [varchar] (15) NULL,
	[listed_in] [varchar] (150) NULL,
	[description] [varchar] (500) NULL
)
-----------------
select * from netflix_raw 

/*
	Things to do
	--handling foreign characters
	--remove duplicates
	--new table for listed in, director, country, cast
	--data type conversions for date added
	--populate missing values in country, duration columns
	--populate rest of the nulls as not_available
	--drop columns director, listed_in,country, cast
*/
---------------------------------------------------
--remove duplicates
-- 1. show_id
select show_id,count(1) cnt 
from netflix_raw
group by show_id
having count(1)>1
/* Comment */
--No duplicate
-- therefore we are making it as PRIMARY KEY
DROP TABLE [dbo].[netflix_raw]
CREATE TABLE [dbo].[netflix_raw](
	[show_id] [varchar] (10) primary key,
	[type] [varchar] (10) NULL,
	[title] [nvarchar] (300) NULL,
	[director] [varchar] (400) NULL,
	[cast] [varchar] (1000) NULL,
	[country] [varchar] (250) NULL,
	[date_added] [varchar] (25) NULL,
	[release_year] [int] NULL,
	[rating] [varchar] (15) NULL,
	[duration] [varchar] (15) NULL,
	[listed_in] [varchar] (150) NULL,
	[description] [varchar] (500) NULL
)

--2. title
select title
from netflix_raw
group by title
having count(1)>1
		/* Comment */
		--Yes there are duplicate

--DEATH NOTE	            2
--Esperando la carroza	    2
--FullMetal Alchemist	    2
--Love In A Puff	        2
--Sin Senos sí Hay Paraíso	2
select *
from netflix_raw
where title in ( select title 
   				 from netflix_raw
				 group by title
				 having count(1)>1
				)
order by title
		/* Comment */
/*
By running above we see that rows are duplicate when there types are also same.
So we also have to do group by on "type" also
*/
select *
,rank()over(partition by title,type order by show_id) rn
from netflix_raw
where concat(title,type) in ( select concat(title,type) 
   							 from netflix_raw
							 group by title,type
							 having count(1)>1
							)
order by title,type

--show_id	type	title	director	cast	country	date_added	release_year	rating	duration	listed_in	description	rn
--s304		Movie	Esperando la carroza	Alejandro Doria	Luis Brandoni, China Zorrilla, Antonio Gasalla, Julio De Grazia, Betiana Blum, Monica Villa, Juan Manuel Tenuta, Andrea Tenuta, Cecilia Rossetto, Enrique Pinti	Argentina	August 5, 2021	1985	TV-MA	95 min	Comedies, Cult Movies, International Movies	Cora has three sons and a daughter and she´s almost 80. One day during a family reunion the big question comes up: who will be her heir?	1
--s6706		Movie	Esperando La Carroza	Alejandro Doria	Luis Brandoni, China Zorrilla, Antonio Gasalla, Julio De Grazia, Betiana Blum, Monica Villa, Juan Manuel Tenuta, Andrea Tenuta, Cecilia Rossetto, Enrique Pinti	Argentina	July 15, 2018	1985	NR	95 min	Comedies, Cult Movies, International Movies	Cora has three sons and a daughter and she´s almost 80. One day during a family reunion the big question comes up: who will be her heir?	2
--s160		Movie	Love in a Puff	Pang Ho-cheung	Miriam Chin Wah Yeung, Shawn Yue, Singh Hartihan Bitto, Isabel Chan, Cheung Tat-ming, Matt Chow, Chui Tien-you, Queenie Chu, Charmaine Fong, Vincent Kok	Hong Kong	September 1, 2021	2010	TV-MA	103 min	Comedies, Dramas, International Movies	When the Hong Kong government enacts a ban on smoking cigarettes indoors, the new law drives hard-core smokers outside, facilitating unlikely connections.	1
--s7346		Movie	Love In A Puff	Pang Ho-cheung	Miriam Chin Wah Yeung, Shawn Yue, Singh Hartihan Bitto, Yat Ning Chan, Tat-Ming Cheung, Matt Chow, Chui Tien-you, Queenie Chu, Charmaine Fong, Vincent Kok	Hong Kong	August 1, 2018	2010	TV-MA	103 min	Comedies, Dramas, International Movies	When the Hong Kong government enacts a ban on smoking cigarettes indoors, the new law drives hard-core smokers outside, facilitating a meeting between Cherie, a makeup saleswoman, and Jimmy, an advertising exec.	2
--s1271	   TV Show	Sin senos sí hay paraíso	NULL	Catherine Siachoque, Fabián Ríos, Carolina Gaitán, Juan Pablo Urrego, Majida Issa, Johanna Fadul, César Mora, Juan Pablo Llano, Carmen Villalobos, Francisco Bolívar, Jennifer Arenas, Luigi Aycardi, Julián Beltrán, Stefanía Gómez, Diana Acevedo, Joselyn Gallardo, Jairo Ordóñez, Oscar Salazar, Gregorio Pernía, Carolina Sepúlveda, Javier Jattin, Juan Alfonso Baptista	United States, Colombia	February 25, 2021	2018	TV-MA	3 Seasons	International TV Shows, Spanish-Language TV Shows, TV Dramas	Born into a small town controlled by the mafia, an irate young woman seeks revenge on the forces that tore apart and wrongfully imprisoned her family.	1
--s8023	   TV Show	Sin Senos sí Hay Paraíso	NULL	Majida Issa, Fabián Ríos, Catherine Siachoque, Carolina Gaitán, Juan Pablo Urrego, Francisco Bolívar, Johanna Fadul, Jennifer Arenas, Luigi Aycardi, Juan Pablo Llano, César Mora, Julián Beltrán, Stefanía Gómez, Diana Acevedo, Joselyn Gallardo, Jairo Ordoñez, Oscar Salazar, Gregorio Pernía, Carolina Sepúlveda	United States, Colombia	 January 11, 2019	2018	TV-MA	3 Seasons	International TV Shows, Spanish-Language TV Shows, TV Dramas	Born into a small town controlled by the mafia, an irate young woman seeks revenge on the forces that tore apart and wrongfully imprisoned her family.	2
--Now removing the duplicates
with rem_duplicate_cte as(
select * 
,rank()over(partition by title,type order by show_id) rn
from netflix_raw)
select *
from rem_duplicate_cte
where rn=1


---------------------------------------------------
--new table for listed in, director, country, cast (each block has more than 1 value)
select * from netflix_raw
/* 
	trim - trim the passed delimeter, if no delimeter is passed then trim the white-spaces, 
	into - used to create new table with columns present in select clause, 
	cross apply - use to apply on all the rows, 
	string_split
*/
select show_id, trim(value) as director
into director_netflix
from netflix_raw n
cross apply string_split(n.director,',')
--
select * from director_netflix
--
select show_id, trim(value) as cast
into cast_netflix
from netflix_raw n
cross apply string_split(n.cast,',')
--
select * from cast_netflix
--
select show_id, trim(value) as country
into country_netflix
from netflix_raw n
cross apply string_split(n.country,',')
--
select * from country_netflix
--
select show_id, trim(value) as listed_in
into listed_in_netflix
from netflix_raw n
cross apply string_split(n.listed_in,',')
--
select * from listed_in_netflix

---------------------------------------------------
--data type conversions for date added
select show_id,type,title,CAST(date_added as date),release_year,rating,duration,description
from netflix_raw

---------------------------------------------------
------populate missing values in country, duration columns


--country
select * from netflix_raw where country is null

with director_country_cte as(
select  cn.country, dn.director
from country_netflix cn
inner join director_netflix dn on cn.show_id=dn.show_id
group by cn.country, dn.director)

insert into country_netflix --for inserting the query o/p to the country_netflix table
select nr.show_id, dc.country   --note: here the country must be from dc_cte table
from netflix_raw nr
inner join director_country_cte dc on nr.director=dc.director
where nr.country is null  --note: here the country must be from netflix table
order by nr.country;

--duration
select * 
from netflix_raw 
where duration is null
/*
	Conclusion: from above query we can see that the duration data in shifted to rating column. 
	Hence we can directly copy the rating column to the duration col where 'duration is null'
	The solution is use:-
	"case when duration is null then rating else duration END as duration"
	in the select clause
*/

-----------------------------------------------------------------
--populate rest of the nulls as not_available
--drop columns director, listed_in,country, cast

/*
	now updating the original table, named as "netflix_final_table"
	final_table
*/
with rem_duplicate_cte as(
select * 
,rank()over(partition by title,type order by show_id) rn
from netflix_raw)
select show_id,type,title,cast(date_added as date) as date_added, release_year,rating
, case when duration is null then rating else duration END as duration /*This is the duration is null handling scenario*/
, description
into netflix_final_table
from rem_duplicate_cte
where rn=1

select *
from netflix_final_table
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

--												DATA ANALYSIS

/*1 for each director count the no of movies and tv shows created by them in separate columns
for directors who have created tv shows and movies both */

/*	1. get all the director which produce both tv and movies
	2. count the no.of movies and no.of tv shows produces by director */
with diff_type_cte as(
	select d.director,n.type
	,DENSE_RANK()over(partition by d.director order by d.director,n.type) rn
	from netflix_final_table n
	inner join director_netflix d
	on n.show_id=d.show_id
	group by d.director,n.type)
,director_with_2_types as(
	select director
	from diff_type_cte
	where rn=2)

select d2.director
,sum(CASE WHEN type='Movie' then 1 else 0 end) as no_of_movie
,sum(CASE WHEN type='TV Show' then 1 else 0 end) as no_of_tvshow
from director_netflix d
inner join director_with_2_types d2 on d.director = d2.director
inner join netflix_final_table n on n.show_id=d.show_id
group by d2.director
order by d2.director



--2 which country has highest number of comedy movies

select top 1 country, count(1) total_comedy_movie_in_a_country
from netflix_final_table n
inner join listed_in_netflix l on l.show_id=n.show_id
inner join country_netflix c on n.show_id=c.show_id
where l.listed_in='Comedies' 
group by c.country
order by total_comedy_movie_in_a_country desc
--------------------------------------------------------------
--3 for each year (as per date added to netflix), which director has maximum number of movies released
/*
	1. Find out all the diff years from the table
	2. Count the movie per year for each director
	3. Connect both the cte and apply window function on each year 
	4. filter by using rank=1 (highest movie for each year)
*/
--Method 1: Non optimized
with diff_year as (
select distinct year(date_added) year
from netflix_final_table)
--order by year)
, movieperyear as(
select d.director, year(n.date_added) year_added_on_netflix,count(n.show_id) total_movie
from netflix_final_table n
inner join director_netflix d on n.show_id=d.show_id
group by d.director, year(n.date_added))
--order by total_movie desc)
, director_max_movie_yearly as(
select *
,rank()over(partition by m.year_added_on_netflix order by total_movie desc, m.director ) rn --if rnak matches then order by director name in alphabetical order
from diff_year d inner join movieperyear m on d.year=m.year_added_on_netflix)
select year, director,total_movie
from director_max_movie_yearly
where rn=1

--Method 2: Optimized
with director_max_movie_yearly as(
select year(n.date_added) year,d.director,count(n.show_id) as total_movies
,rank()over(partition by year(n.date_added) order by count(n.show_id) desc,d.director asc) rn
from netflix_final_table n
inner join director_netflix d on n.show_id=d.show_id
where n.type='Movie'
group by year(n.date_added),d.director)

select year,director,total_movies
from director_max_movie_yearly
where rn=1
--------------------------------------------------------------
--4. what is the average duration of movies in each genre
select * from netflix_final_table
select * from listed_in_netflix

/*
	1. remove min from duration
	2. combine both the table
	3. group by listed
	4. avg(cast(duration))
*/

with duration_change as (
select * , REPLACE(duration,'min','') as new_duration
from netflix_final_table
where type='Movie')

select AVG(CAST(d.new_duration as int)) avg_duration_genre_wise,l.listed_in
from duration_change d
inner join listed_in_netflix l on d.show_id=l.show_id
group by l.listed_in

-----------------------------------------------------------------------------------
-- Find list of director who have created horror and comedy movies both
--display director name along with no. of horror and comedy movies directed by them
/*
	1. apply filter where listedin= horror or comedy
	2. use rank function partition by director
	3. select row where rn=2 (till here we get the director which has directed both the movies)
	4. use case when and count the total horror and total comedy movies
*/
--Method-1 non optimized
with cte as(
select d.director
,rank()over(partition by d.director order by l.listed_in) rn
from netflix_final_table n
inner join listed_in_netflix l on n.show_id=l.show_id
inner join director_netflix d on n.show_id=d.show_id
where n.type='Movie' AND l.listed_in in ('Comedies' , 'Horror Movies'))
,director_name as(
select director
from cte where rn=2)
,combine as (
select d.show_id,l.listed_in,dn.director
from director_netflix d 
inner join listed_in_netflix l on d.show_id=l.show_id
right join director_name dn on dn.director = d.director)

select director
,count(distinct case when listed_in= 'Comedies' then show_id end) as comedy_movies
,count(distinct case when listed_in= 'Horror Movies' then show_id end) as horror_movies
from combine
group by director
order by director,comedy_movies desc,horror_movies desc

--method 2 optimized
select d.director
,count(distinct case when listed_in= 'Horror Movies' then n.show_id end) as horror_movies
,count(distinct case when listed_in= 'Comedies' then n.show_id end) as comedy_movies
from netflix_final_table n
inner join listed_in_netflix l on n.show_id=l.show_id
inner join director_netflix d on n.show_id=d.show_id
where n.type='Movie' AND l.listed_in in ('Comedies' , 'Horror Movies')
group by d.director
having count(distinct l.listed_in)=2



