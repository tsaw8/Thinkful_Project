/* 1. What are the three longest trips on rainy days? */

WITH rainy_day /* Create rainy_day table */
AS (
SELECT 
	DATE(date) rainy_date /* Use DATE function for date format */
FROM 
	weather
WHERE 
	events LIKE 'Rain'
GROUP BY 1)

SELECT /* Joining rainy_day table with trips table to find 3 longest trips on rainy days */
	trips.trip_id,
	trips.duration,
	DATE(trips.start_date)
FROM 
	trips
JOIN /* Intermediate join of rainy date with trips start_date */
	rainy_day
ON 
	DATE(rainy_date) = DATE(start_date)
ORDER BY 
	duration DESC 
LIMIT 3; 

/* 2. Which station is full most often? */
SELECT 
	status.station_id, 
	stations.name,
	COUNT(CASE WHEN docks_available=0 THEN 1 END) AS empty_count /* Create empty_count to count bikes docked */
FROM 
	status
JOIN /* Inner join station_id from status and stations table to see bikes docked at each station */
	stations
ON 
	stations.station_id = status.station_id
GROUP BY 
	1, 2
ORDER BY 
	empty_count DESC 
	/*Santa Clara at Almaden*/
	
/* 3. Return a list stations with a count of numbers of trips starting at the at station but ordered by dock count. */
SELECT 
	trips.start_station,
	stations.dockcount, 
	COUNT(*) /* Count how many bikes are docked at each start station */
FROM 
	trips
JOIN /* Inner join stations to see number of trips at each station */
	stations
ON 
	stations.name = trips.start_station
GROUP BY 
	1, 2
ORDER BY 
	dockcount DESC 
	
/* 4. What's the length of the longest trip for each day it rains anywhere? */
WITH rainy_day /* Create rainy_day table */
AS (
SELECT 
	DATE(date) rainy_date /* Use DATE function for date format */
FROM 
	weather
WHERE 
	events LIKE 'Rain'
GROUP BY 1),

rain_trip /* Create rain_trip table */
AS (
SELECT 
	trip_id,
	duration,
	DATE(trips.start_date) AS rain_trip_date /* Create date column to find trips on rainy day */
FROM 
	trips
JOIN
	rainy_day
ON 
	rainy_day.rainy_date = DATE(trips.start_date)
ORDER BY
	duration DESC)

SELECT
	rain_trip_date,
	MAX(duration) AS longest_trip
FROM 
	rain_trip
GROUP BY 1
ORDER BY 
	longest_trip DESC
