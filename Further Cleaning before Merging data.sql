/* Keywords used: SELECT, UPDATE, ALTER, INTO, DISTINCT, INNER JOIN, WHERE*/

/* The data from 12 months was cleaned. To merge all the data, I attempted to union all tables. 
This wasn't possible as station_ids for Sept 2020 - Nov 2020 were different than the other 9 months 
of data (also had different data types). Station names were the same across the 12 months, 
the difference was in station ids for 3 months in 2020. */

/* To solve this, I created a table with station ids and station names that were pulled from August 
(one of the busiest months)
I would then set the station id from one table equal to the station id of the station_identifier table 
whenever the station names matched. */


-- Extracting start_station_names with their station ids 
SELECT *
INTO station_identifiers 
FROM 
(SELECT DISTINCT start_station_name, start_station_id FROM "202108_td") a

-- Viewing station ids and station names. station names are the same while station ids are different
-- I included start station ids and names from both tables to confirm start station names matched. They did.
SELECT DISTINCT a.start_station_id, b.start_station_id, a.start_station_name, b.start_station_name 
FROM "202011_td" a
INNER JOIN "station_identifiers" b
ON a.start_station_name = b.start_station_name

-- Before we can update the station id column, we'll have to change the datatype from int to varchar
ALTER TABLE "202009_td"
ALTER COLUMN start_station_id TYPE varchar(50);

-- Updating start station id column to match the rest of the id columns of other months 
UPDATE "202009_td"
SET start_station_id = station_identifiers.start_station_id
FROM station_identifiers
WHERE "202009_td".start_station_name = station_identifiers.start_station_name

/* Following the same process for October 2020 */

-- Updating datatype of start station id column for oct 2020
ALTER TABLE "202010_td"
ALTER COLUMN start_station_id TYPE varchar (50);

-- updating station ids for oct 2020 to match other months
UPDATE "202010_td"
SET start_station_id = station_identifiers.start_station_id
FROM station_identifiers
WHERE "202010_td".start_station_name = station_identifiers.start_station_name

/* Follwing the same processs for November 2020 */

-- updating station ids for Nov 2020 to match other months
UPDATE "202011_td"
SET start_station_id = station_identifiers.start_station_id
FROM station_identifiers
WHERE "202011_td".start_station_name = station_identifiers.start_station_name

-- updating station ids for Nov 2020 to match other months
ALTER TABLE "202011_td"
ALTER COLUMN start_station_id TYPE varchar (50);

/* End station id's had the same problem. Same process as the start station names was followed */

-- Extracting end_station_names with their station ids 
SELECT *
INTO endstation_identifiers 
FROM 
(SELECT DISTINCT end_station_name, end_station_id FROM "202108_td") a

-- Viewing station ids and station names. station names are the same while station ids are different
SELECT DISTINCT a.end_station_id, b.end_station_id, a.end_station_name, b.end_station_name FROM "202011_td" a
INNER JOIN "endstation_identifiers" b
ON a.end_station_name = b.end_station_name

-- To update station id column, we'll have to change the datatype from int to varchar: SEPT 2020
ALTER TABLE "202009_td"
ALTER COLUMN end_station_id TYPE varchar (50);

-- Updating start id column to match the rest of the id columns of other months: SEPT 2020
UPDATE "202009_td"
SET end_station_id = endstation_identifiers.end_station_id
FROM endstation_identifiers
WHERE "202009_td".end_station_name = endstation_identifiers.end_station_name

-- To update station id column, we'll have to change the datatype from int to varchar: OCT 2020
ALTER TABLE "202010_td"
ALTER COLUMN end_station_id TYPE varchar (50);

-- Updating start id column to match the rest of the id columns of other months: OCT 2020
UPDATE "202010_td"
SET end_station_id = endstation_identifiers.end_station_id
FROM endstation_identifiers
WHERE "202010_td".end_station_name = endstation_identifiers.end_station_name

-- To update station id column, we'll have to change the datatype from int to varchar: NOV 2020
ALTER TABLE "202011_td"
ALTER COLUMN end_station_id TYPE varchar (50);

-- Updating start id column to match the rest of the id columns of other months: NOV 2020
UPDATE "202011_td"
SET end_station_id = endstation_identifiers.end_station_id
FROM endstation_identifiers
WHERE "202011_td".end_station_name = endstation_identifiers.end_station_name
