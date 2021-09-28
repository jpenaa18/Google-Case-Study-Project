
-- Extracting start_station_names with their station ids 
SELECT *
INTO station_identifiers 
FROM 
(SELECT DISTINCT start_station_name, start_station_id FROM "202108_td") a

-- Viewing station ids and station names. station names are the same while station ids are different
SELECT DISTINCT a.start_station_id, b.start_station_id, a.start_station_name, b.start_station_name FROM "202011_td" a
INNER JOIN "station_identifiers" b
ON a.start_station_name = b.start_station_name


-- To update station id column, we'll have to change the datatype from int to varchar
ALTER TABLE "202009_td"
ALTER COLUMN start_station_id TYPE varchar (50);

-- Updating start id column to match the rest of the id columns of other months 
UPDATE "202009_td"
SET start_station_id = station_identifiers.start_station_id
FROM station_identifiers
WHERE "202009_td".start_station_name = station_identifiers.start_station_name

-- Updating datatype of start station id column for oct 2020
ALTER TABLE "202009_td"
ALTER COLUMN start_station_id TYPE varchar (50);

-- updating station ids for oct 2020 to match other months
UPDATE "202010_td"
SET start_station_id = station_identifiers.start_station_id
FROM station_identifiers
WHERE "202010_td".start_station_name = station_identifiers.start_station_name

-- updating station ids for Nov 2020 to match other months
UPDATE "202011_td"
SET start_station_id = station_identifiers.start_station_id
FROM station_identifiers
WHERE "202011_td".start_station_name = station_identifiers.start_station_name

-- updating station ids for Nov 2020 to match other months
ALTER TABLE "202011_td"
ALTER COLUMN start_station_id TYPE varchar (50);

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
