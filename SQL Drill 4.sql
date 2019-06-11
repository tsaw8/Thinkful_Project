-- This file contains a set of queries for exploring the Airbnb database of San Francisco.

-- 1. What's the most expensive listing?  What else can you tell me about the listing?
SELECT 	
	*
FROM 
	sfo_listings
ORDER BY 
	price DESC
LIMIT 1;
-- The most expensive listing is an entire home/apt in Western Addition for $10,000 with a minimum of 2 nights rental.


-- 2. What neighborhoods seem to be the most popular?
SELECT
	neighbourhood,
	SUM(number_of_reviews) AS total_reviews
FROM
	sfo_listings
GROUP BY 
	neighbourhood
ORDER BY total_reviews DESC
-- In terms of reviews, the most popular neighbourhood are Mission and Western Addition with a total review count of 32,804 and 21,917 respectively.

-- 3. What time of year is the cheapest time to go to San Francisco? 
SELECT
	EXTRACT(year FROM calender_date) as year, -- group by year
	EXTRACT(month FROM calender_date) as month, -- group by year
	avg(cast(REPLACE((REPLACE((REPLACE(price, '$', '')), ',', '')), '.00', '') as int)) -- convert price column values from text to integer to take the average
FROM
	sfo_calendar
Group by 1, 2
Order by avg(cast(REPLACE((REPLACE((REPLACE(price, '$', '')), ',', '')), '.00', '') as int)) 
-- The cheapest time to go to San Francisco was during January 2019 where the average cost was $212.50.
-- The rental price in February 2019 was also low averaging $220.81.

-- What about the busiest?
SELECT
	EXTRACT(year FROM review_date) as year, -- group by year
	EXTRACT(month FROM review_date) as month, -- group by month
	COUNT(*) -- count total reviews 
FROM
	sfo_reviews
Group by 1,2 
Order by COUNT(*) DESC
-- The busiest time to visit was July 2018 with a total of 11,030 reviews. 
-- August 2018 came as a close second with 11,029 reviews. 
