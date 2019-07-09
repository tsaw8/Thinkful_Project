-- Drill: Using SQL to pull aggregated data from the Bay Area Bikeshare dataset 

--1. The IDs and durations for all trips of duration greater than 500, ordered by duration. 
SELECT trip_id, duration
FROM trips
WHERE duration >500
ORDER BY duration DESC

--2. Every column of the stations table for station id 84.
SELECT *
FROM stations
WHERE station_id = 84

--3. The min temperatures of all the occurrences of rain in zip 94301.
SELECT MinTemperatureF
FROM weather
WHERE ZIP = '94301' AND Events LIKE '%Rain%'
