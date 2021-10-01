
/* Data cleaning in PostgreSQL. Keywords used: SELECT, DISTINCT, GROUP BY, WHERE, CASE, UPDATE, ALTER, CREATE, DATE_PART */
-------------------------------------------------------------------------------------------------------------------

-- Because I'll be deleting rows, I will make a copy of our table. A csv of the file also exists
SELECT * 
INTO "202011_tripdata_copy"
FROM "202011_tripdata";

-- Looking at the different counts in ride_id. Ride id's are unique. This query yielded 5 distinct lengths with length of 16 making up almost all (all except < 200) 
SELECT COUNT(ride_id), LENGTH(ride_id) 
FROM "202011_tripdata"
GROUP BY LENGTH(ride_id);

-- Deleting rows where ride_id is not 16 characters in length. 160 rows were deleted 
-- Dropping rows where ride_id != 16
DELETE FROM "202011_tripdata" 
WHERE LENGTH(ride_id) != 16;

-- Looking at distinct values in rideable_type. yields: electric_bike, docked_bike
SELECT DISTINCT(rideable_type)
FROM "202011_tripdata";

-- Cleaning data in rideable_type
UPDATE "202011_tripdata"
SET rideable_type = CASE
	WHEN rideable_type = 'docked_bike' THEN 'docked bike'
	WHEN rideable_type = 'electric_bike' THEN 'electric bike'
	END;
  
 -- Seeing if we could find start_station_name from start_station_id. 0 rows returned 
 SELECT * FROM "202011_tripdata"
 WHERE start_station_name ISNULL
 AND start_station_id IS NOT NULL;
 
 -- Same query as above was run with end_station_name and ID. 0 rows returned
 
 -- Counting rows with null values in station names or ID's. 36,901 rows returned
SELECT COUNT(*) FROM "202011_tripdata" 
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Dropping rows with null values in station names or station IDs. 36,901 rows dropped
DELETE FROM "202011_tripdata"
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Looking at distinct values in member_casual column. only 2 values (casual & member).
SELECT DISTINCT(member_casual)
FROM "202011_tripdata"

-- ADDING DAY OF THE WEEK COLUMN 
ALTER TABLE "202011_tripdata"
ADD day_of_week INT

-- INSERTING VALUES INTO DAY_OF_WEEK COLUMN WHERE SUNDAY = 1 AND SATURDAY = 7
UPDATE "202011_tripdata"
SET day_of_week = (SELECT date_part('dow', started_at)+1
WHERE started_at IS NOT NULL)

-- Creating new table with the same data but now a calculated field for ride length (end time - start time)
CREATE TABLE "202011_td"
AS
SELECT *, ended_at - started_at AS ride_length
FROM "202011_tripdata";
