-- Drill: Using SQL to pull aggregated data from the Bay Area Bikeshare dataset 

-- 1. What was the hottest day in our data set? Where was that?
--The "hottest day" could also be interpreted as the day with the highest maximum temperature, 
--which would have occurred on November 17, 2015, in zip code area 94063, with a maximum temperature of 134F.
SELECT date, ZIP, MAX(MaxTemperatureF) MaxTemperatureF
FROM weather
GROUP BY weather.date, zip
ORDER BY maxtemperaturef DESC
LIMIT 1

--With a CTE
--Create hottest_day table
WITH hottest_day AS (
SELECT DATE(date) hottest_date
FROM weather
WHERE MaxTemperatureF = (SELECT MAX(MaxTemperatureF) FROM weather)
GROUP BY 1)

SELECT weather.date, MAX(weather.MaxTemperatureF) AS MaxTemperatureF, weather.zip
FROM weather
JOIN hottest_day 
ON DATE(weather.date) = DATE(hottest_date)
GROUP BY weather.date, weather.zip
ORDER BY MaxTemperatureF DESC
LIMIT 1

--The day with the highest mean temperature was on Septemeber 11, 2015, in area 94063, with a maximum temperature of 94F.
SELECT date, ZIP, MAX(MeanTemperatureF) MeanTemperatureF
FROM weather
GROUP BY weather.date, zip
ORDER BY meantemperaturef DESC
LIMIT 1

-- 2. How many trips started at each station?
--There were 80 unique stations with the number of start stations ranging from 1 to 23,591.
SELECT start_station, COUNT(*)
FROM trips
GROUP BY start_station

-- 3. What's the shortest trip that happened? 
--The shortest duration (60) occured on November 16,2015 at Mezes station with trip_id 1011650. 
SELECT trip_id, start_date, start_station, end_station, MIN(duration) as duration
FROM trips
GROUP BY trip_id, start_date, start_station, end_station
ORDER BY duration
LIMIT 1

-- 4. What is the average trip duration, by end station?
--There are 80 stations with average duration ranging from 257 to 4710.9
SELECT ROUND(AVG(duration),2), end_station
FROM trips
GROUP BY end_station, trips.duration
ORDER BY trips.duration DESC 




