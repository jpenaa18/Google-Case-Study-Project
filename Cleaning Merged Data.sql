-- Deleting rows where bikes were being serviced. 4 rows dropped
DELETE FROM td_2021
WHERE start_station_name = 'DIVVY CASSETTE REPAIR MOBILE STATION';

-- Deleting more rows where bikes were being tested
DELETE FROM td_2021
WHERE start_station_name = 'WATSON TESTING - DIVVY';

-- Deleting dirty data where start time was after end time (as long as 20 days). 37,441 rows deleted.
DELETE FROM td_2021
WHERE start_station_name = 'WATSON TESTING - DIVVY';

UPDATE td_2021
SET day_of_week = CASE
	WHEN day_of_week = '1' THEN 'Sunday'
	WHEN day_of_week = '2' THEN 'Monday'
	WHEN day_of_week = '3' THEN 'Tuesday'
	WHEN day_of_week = '4' THEN 'Wednesday'
	WHEN day_of_week = '5' THEN 'Thursday'
	WHEN day_of_week = '6' THEN 'Friday'
	WHEN day_of_week = '7' THEN 'Saturday'
	END

