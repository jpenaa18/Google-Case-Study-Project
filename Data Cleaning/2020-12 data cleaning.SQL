/* Data cleaning in PostgreSQL. Keywords used: SELECT, DISTINCT, GROUP BY, WHERE, CASE, UPDATE, ALTER, CREATE, DATE_PART */
-------------------------------------------------------------------------------------------------------------------
-- Because I'll be deleting rows, I will make a copy of our table. A csv of the file also exists
SELECT * 
INTO "202012_tripdata_copy"
FROM "202012_tripdata";

-- Looking at the different counts in ride_id. Ride id's are unique. 
-- This query yielded 5 distinct lengths with length of 16 being the most common. (all except < 100 rows) 
SELECT COUNT(ride_id), LENGTH(ride_id) 
FROM "202012_tripdata"
GROUP BY LENGTH(ride_id);

-- Finding rows where ride_id is not equal to 16 characters in length. 91 rows
SELECT * FROM "202012_tripdata"
WHERE LENGTH(ride_id) != 16;

-- Dropping rows with ride_ids != 16 characters in length. 91 rows deleted
DELETE FROM "202012_tripdata" 
WHERE LENGTH(ride_id) != 16

-- Looking at distinct values in rideable_type. (yields: electric_bike, docked_bike, classic_bike)
SELECT DISTINCT(rideable_type)
FROM "202012_tripdata";

-- Cleaning the data in rideable type using a CASE statement
UPDATE "202012_tripdata"
SET rideable_type = CASE 
	WHEN rideable_type = 'docked_bike' THEN 'docked bike'
	WHEN rideable_type = 'electric_bike' THEN 'electric bike'
	WHEN rideable_type = 'classic_bike' THEN 'classic bike'
	END;
  
-- Seeing if we could find start_station_name from start_station_id to avoid deleting those rows. 0 Rows returned 
 SELECT * FROM "202012_tripdata"
 WHERE end_station_name ISNULL
 AND end_station_id IS NOT NULL
 
 -- Selecting data that has null values. 17,647 rows returned
SELECT COUNT(*) FROM "202012_tripdata" 
WHERE start_station_naMe ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL

-- Dropping rows with null values in station or station id columns. 17,647 rows dropped
DELETE FROM "202012_tripdata"
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Looking at distinct values in member_casual column. Yields: member, casual. Looks good. 
SELECT DISTINCT(member_casual)
FROM "202012_tripdata";

-- Adding the day of the week column
ALTER TABLE "202012_tripdata"
ADD day_of_week INT

-- Inserting values into day_of_week column where Sunday = 1, and Saturday = 7
UPDATE "202012_tripdata"
SET day_of_week = (SELECT date_part('dow', started_at) +1
WHERE started_at IS NOT NULL);

-- Creating new table with the same data but now a calculated field for ride_length (end time - start time)
CREATE TABLE "202012_td"
AS
SELECT *, ended_at - started_at AS ride_length
FROM "202012_tripdata";
