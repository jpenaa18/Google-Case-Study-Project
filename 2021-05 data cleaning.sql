/* Data cleaning in PostgreSQL. Keywords used: SELECT, DISTINCT, GROUP BY, WHERE, CASE, UPDATE, ALTER, CREATE, DATE_PART */
-------------------------------------------------------------------------------------------------------------------

-- Previewing the data
SELECT * FROM "202105_tripdata"
LIMIT 1000

-- Because I'll be deleting rows, I will make a copy of our table. A csv of the file also exists
SELECT * 
INTO "202105_tripdata_copy"
FROM "202105_tripdata";

-- Looking at the different counts in ride_id. Ride id's are unique. 
SELECT COUNT(ride_id), LENGTH(ride_id) 
FROM "202105_tripdata"
GROUP BY LENGTH(ride_id);

-- Finding rows where ride_id is not equal to 16 characters in length
SELECT * FROM "202105_tripdata"
WHERE LENGTH(ride_id) != 16

-- Dropping rows where ride_id != 16. 332 rows dropped
DELETE FROM "202105_tripdata" 
WHERE LENGTH(ride_id) != 16

-- Looking at distinct values in rideable_type. yields: electric_bike, docked_bike, class_bike
SELECT DISTINCT(rideable_type)
FROM "202105_tripdata";

-- Cleaning the data in rideable type
UPDATE "202105_tripdata"
SET rideable_type = CASE 
	WHEN rideable_type = 'docked_bike' THEN 'docked bike'
	WHEN rideable_type = 'electric_bike' THEN 'electric bike'
	WHEN rideable_type = 'classic_bike' THEN 'classic bike'
	END;
	
  -- Seeing if we could find start_station_name from start_station_id. 0 Rows returned 
 SELECT * FROM "202105_tripdata"
 WHERE end_station_name ISNULL
 AND end_station_id IS NOT NULL;
 
-- Selecting data that has null values. 80,591 rows returned 
SELECT COUNT(*) FROM "202105_tripdata" 
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL
-- DELETING NULL VALUES WHERE THERE IS NO START STATION NAME. REFERENCE POINTS SUCH AS LAT & LONG WERE NOT ABLE TO YIELD STATION NAME
-- SELECTING DISTINCT STATION NAME WHEN GIVEN LAT & LONG ONLY RETURNED THE DISTINCT NULL VALUE FOR THOSE COORDINATES

-- Deleting null values in data. 80,591 rows dropped 
DELETE FROM "202105_tripdata"
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Looking at distinct values in member_casual column. member/casual. looks good
SELECT DISTINCT(member_casual)
FROM "202105_tripdata"

-- ADDING DAY OF THE WEEK COLUMN 
ALTER TABLE "202105_tripdata"
ADD day_of_week INT
				
-- Inserting values into day of week column where Sunday = 1 and Saturday = 7
UPDATE "202105_tripdata"
SET day_of_week = (SELECT date_part('dow', started_at)+1
WHERE started_at IS NOT NULL);
				
-- Creating new table with the same data but now a calculated field for ride length (end time - start time)
CREATE TABLE "202105_td"
AS
SELECT *, ended_at - started_at AS ride_length
FROM "202105_tripdata";



