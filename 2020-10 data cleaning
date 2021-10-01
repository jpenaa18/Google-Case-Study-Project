
/* Data cleaning in PostgreSQL. Keywords used: SELECT, DISTINCT, GROUP BY, WHERE, CASE, UPDATE, ALTER, CREATE, DATE_PART */
-------------------------------------------------------------------------------------------------------------------

-- CREATING A COPY OF TABLE AS WE'LL BE DELETING INFORMATION AS PART OF THE CLEANING PROCESS
SELECT * 
INTO "202010_tripdata_copy"
FROM "202010_tripdata";

-- VIEWING DISTINCT RIDE_ID LENGTHS AS PART OF THE CLEANING PROCESS - RETURNED VALUES OF 8,9,10,11,16
SELECT DISTINCT(LENGTH(ride_id))
FROM "202010_tripdata";

-- DELETING ROWS WHERE RIDE_ID IS OTHER THAN 16 257 ROWS DELETED
DELETE FROM "202010_tripdata" 
WHERE LENGTH(ride_id) IN (11,8,9,10);

-- Looking at distinct values in rideable_type. Yields electric_bike, docked_bike
SELECT DISTINCT(rideable_type)
FROM "202010_tripdata";

-- Cleaning data in rideable_type column 
UPDATE "202010_tripdata"
SET rideable_type = CASE
	WHEN rideable_type = 'docked_bike' THEN 'docked bike'
	WHEN rideable_type = 'electric_bike' THEN 'electric bike'
	END;
  
-- Deleting rows with null values in station names or id's; 49,315 rows deleted 
DELETE FROM "202010_tripdata"
WHERE start_station_name ISNULL
OR start_station_id ISNULL
OR end_station_name ISNULL
OR end_station_id ISNULL;

-- Adding day of the week column
ALTER TABLE "202010_tripdata"
ADD day_of_week INT;

-- Inserting values into day_of_week column where Sunday = 1 AND Saturday = 7
UPDATE "202010_tripdata"
SET day_of_week = (SELECT date_part('dow', started_at)+1
WHERE started_at IS NOT NULL);

-- Creating new table with the same data but now a calculated field for ride length (end time - start time)
CREATE TABLE "202010_td"
AS
SELECT *, ended_at - started_at AS ride_length
FROM "202010_tripdata";
