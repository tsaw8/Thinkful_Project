SELECT 
	zip,
	maxtemperaturef
FROM
	weather
ORDER BY 
	maxtemperaturef DESC
/* 	maxtemp= 134 zip = 94063 */

SELECT 
	start_station, 
    COUNT(*)
FROM 
  	trips
GROUP BY 
  	start_station

SELECT 
	duration,
	trip_id
FROM 
  	trips
ORDER BY duration ASC;

SELECT 
	AVG(duration),
	end_station
FROM 
	trips
GROUP BY
	end_station





