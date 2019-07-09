-- Drills: Using Joins and CTEs

--1. What are the three longest trips on rainy days? 
--I will interpet this question as "what are the three longest trips out of all the 
--trips on rainy days?" To answer this question, I will need to join the weather and trips
--table by date and on where the Event column contains "Rain". 

--Create rainy_day table
--Use DATE function for date format
WITH rainy_day AS ( SELECT DATE(date) rainy_date 
FROM weather
WHERE events LIKE '%Rain%'
GROUP BY 1)

--Joining rainy_day table with trips table to find 3 longest trips on rainy days
SELECT trips.trip_id, trips.duration, DATE(trips.start_date)
FROM trips
-- Intermediate join of rainy date with trips start_date
JOIN rainy_day
ON DATE(rainy_date) = DATE(start_date)
ORDER BY duration DESC 
LIMIT 3; 

--trip_id, duration, date
--1173890, 85900, 2016-04-22
--1009870, 84349, 2015-11-15
--1210487, 83915, 2016-05-21

--2. Which station is full most often? 
--I will interept "full" as having bikes docked at the station. To complete this query
--I need to join determine how many bikes are docked at each station and join the 
--status and station table on matching station_id. 

SELECT status.station_id, stations.name,
--Create empty_count to count bikes docked
	COUNT(CASE WHEN docks_available=0 THEN 1 END) AS empty_count 
FROM status
--Inner join station_id from status and stations table to see bikes docked at each station
JOIN stations
ON stations.station_id = status.station_id
GROUP BY 1, 2
ORDER BY empty_count DESC 
--Santa Clara at Almaden
	
--3. Return a list stations with a count of numbers of trips starting at the at station but ordered by dock count.
--There are 80 unique start_stations in the trips table, but once joined with stations,
--only 63 unique stations are returned. 

--Count how many bikes are docked at each start station
SELECT trips.start_station, stations.dockcount, COUNT(*) 
FROM trips
--Inner join stations to see number of trips at each station
JOIN stations
ON stations.name = trips.start_station
GROUP BY 1, 2
ORDER BY dockcount DESC 
	
--4. What's the length of the longest trip for each day it rains anywhere? 
--We will need two CTEs that will be joined on date. 
--The first CTE will extract rainy days from the weather table and the second will extract
--trips on rainy days. 

-- Create rainy_day table 
WITH rainy_day AS ( SELECT DATE(date) rainy_date 
FROM weather
WHERE events LIKE '%Rain%'
GROUP BY 1),

--Create rain_trip table
--Create date column to find trips on rainy day
rain_trip AS ( SELECT trip_id, duration, DATE(trips.start_date) AS rain_trip_date 
FROM trips
JOIN rainy_day
ON rainy_day.rainy_date = DATE(trips.start_date)
ORDER BY duration DESC)

SELECT rain_trip_date, MAX(duration) AS longest_trip
FROM rain_trip
GROUP BY 1
ORDER BY longest_trip DESC
