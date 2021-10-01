/* Cleaning the September Dataset (532,958 rows) using PostgreSQL.
There are 13 columns beginning with ride_id is a unique id for each bike ride
Keywords used: SELECT, DISTINCT, GROUP BY, WHERE, CASE, UPDATE, ALTER, CREATE, DATE_PART */

-- Because I'll be deleting rows, I will make a copy of our table. A csv of the file also exists
SELECT * 
INTO "202008_tripdata_copy"
FROM "202008_tripdata";

-- Looking for inconsistencies in ride_id. Given it's a unique key, they should all be the same character length
-- The query below yielded 3 different character lengths for ride_id: 8, 9, 16
SELECT DISTINCT(LENGTH(ride_id))
FROM "202009_tripdata"

-- Looking at data where ride_id = 8 characters in length; 360 rows returned
SELECT ride_id 
FROM "202009_tripdata"
WHERE LENGTH(ride_id) = 8;

-- Looking at data where ride_id = 9; 15 rows returned
SELECT ride_id 
FROM "202009_tripdata"
WHERE LENGTH(ride_id) = 8;


-- Querying the data where ride_id = 16; returned 532,853 rows
SELECT ride_id 
FROM "202009_tripdata"
WHERE LENGTH(ride_id) = 16;

-- Dropping rows where ride_id != 16
DELETE FROM "202009_tripdata" 
WHERE LENGTH(ride_id) = 8
OR LENGTH(ride_id) = 9;

-- Looking at distinct values in rideable_type
SELECT DISTINCT(rideable_type)
FROM "202009_tripdata";
# yields: electric_bike, docked_bike

-- Cleaning the data in rideable type
UPDATE "202009_tripdata"
SET rideable_type = CASE 
	WHEN rideable_type = 'docked_bike' THEN 'docked bike'
	WHEN rideable_type = 'electric_bike' THEN 'electric bike'
	END;
 
-- DELETING NULL VALUES WHERE THERE IS NO START STATION NAME. REFERENCE POINTS SUCH AS LAT & LONG WERE NOT ABLE TO YIELD STATION NAME
-- SELECTING DISTINCT STATION NAME WHEN GIVEN LAT & LONG ONLY RETURNED THE DISTINCT NULL VALUE FOR THOSE COORDINATES
DELETE FROM "202009_tripdata"
WHERE start_station_name IS NULL;

-- DELETING NULL VALUES IN START_STATION_ID; 210 ROWS 
DELETE FROM "202009_tripdata"
WHERE start_station_id ISNULL;

-- DELEETING NULL VALUES IN END_STATION_NAME AND END_STATION_ID; 12663 rows affected
DELETE FROM "202009_tripdata"
WHERE end_station_name ISNULL
OR end_station_id ISNULL;

-- COUNTING ROWS LEFT AFTER DELETING DATA; 500033
SELECT COUNT(*)
FROM "202009_tripdata";

-- ADDING DAY OF THE WEEK COLUMN 
ALTER TABLE "202009_tripdata"
ADD day_of_week INT

-- INSERTING VALUES INTO DAY_OF_WEEK COLUMN WHERE SUNDAY = 1 AND SATURDAY = 7
UPDATE "202009_tripdata"
SET day_of_week = (SELECT date_part('dow', started_at)+1
WHERE started_at IS NOT NULL)

-- CREATING NEW TABLE WITH SAME DATA BUT NOW A CALCUATED FIELD FOR END TIME - START TIME TO CALC RIDE_LENGTH
CREATE TABLE "202009_td"
AS (
SELECT *, ended_at - started_at AS ride_length
FROM "202009_tripdata")


