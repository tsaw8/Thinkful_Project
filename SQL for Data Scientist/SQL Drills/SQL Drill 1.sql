SELECT 
	trip_id,
	duration
FROM
	trips
WHERE 
	duration > 500
ORDER BY duration

SELECT 
	*
FROM 
	stations
WHERE 
	station_id = 84
  
  SELECT 
	MinTemperatureF
FROM 
	weather
WHERE 
	Events = 'Rain' AND 
	zip = 94301