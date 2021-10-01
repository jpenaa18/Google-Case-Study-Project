-- Because I'll be deleting rows, I will make a copy of our table. A csv of the file also exists
SELECT * 
INTO "202102_tripdata_copy"
FROM "202102_tripdata";

-- Looking at the different counts in ride_id. Ride id's are unique. All ride_ids have a character length of 16. Looks good. 
SELECT COUNT(ride_id), LENGTH(ride_id) 
FROM "202101_tripdata"
GROUP BY LENGTH(ride_id);

-- Looking at distinct values in rideable_type. yields: electric_bike, docked_bike, class_bike
SELECT DISTINCT(rideable_type)
FROM "202102_tripdata";

-- Cleaning the data in rideable type
UPDATE "202102_tripdata"
SET rideable_type = CASE 
	WHEN rideable_type = 'docked_bike' THEN 'docked bike'
	WHEN rideable_type = 'electric_bike' THEN 'electric bike'
	WHEN rideable_type = 'classic_bike' THEN 'classic bike'
	END;
  
  -- Seeing if we could find start_station_name from start_station_id. 0 Rows returned 
 SELECT * FROM "202101_tripdata"
 WHERE end_station_name ISNULL
 AND end_station_id IS NOT NULL
 
 -- Selecting data that has null values. 6626 rows returned 
SELECT COUNT(*) FROM "202102_tripdata" 
WHERE start_station_naMe ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Deleting null values in data. 6626 rows dropped 
DELETE FROM "202102_tripdata"
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Looking at distinct values in member_casual column. member/casual. looks good
SELECT DISTINCT(member_casual)
FROM "202101_tripdata"

-- ADDING DAY OF THE WEEK COLUMN 
ALTER TABLE "202102_tripdata"
ADD day_of_week INT

-- Inserting values into day of week column where Sunday = 1 and Saturday = 7
UPDATE "202102_tripdata"
SET day_of_week = (SELECT date_part('dow', started_at)+1
WHERE started_at IS NOT NULL);

-- Creating new table with the same data but now a calculated field for ride length (end time - start time)
CREATE TABLE "202102_td"
AS
SELECT *, ended_at - started_at AS ride_length
FROM "202102_tripdata";
