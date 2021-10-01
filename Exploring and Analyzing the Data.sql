/* Types of queries and keywords: Data aggregation, window functions, date functions,
   descriptive analysis. */

-- Calculating percentage of rides by type or user (casual or member)
SELECT member_casual, ROUND((COUNT(*) * 100.00) / (SELECT COUNT(*) FROM td_2021), 2)
FROM td_2021
GROUP BY member_casual

-- Counting total number of trips by month (Least: Feb, Jan; Greatest: Jul, Aug)
SELECT DATE_TRUNC('month', started_at) AS month, COUNT(*);
FROM td_2021
GROUP BY month
ORDER BY COUNT(*) DESC;

/* Counting number of trips by month grouped by ridery type
Rider type "member" is usually greater than casual riders except in summer months (Jun-Aug) 
where we see an increase in casual riders */
SELECT member_casual, DATE_TRUNC('month', started_at) as month, COUNT(*)
FROM td_2021
GROUP BY month, member_casual;

-- Finding the average ride length for bike rides in months 09/2020-08/2021. -- 23:30 minutes
SELECT AVG(ride_length) FROM td_2021

-- Finding the average length of each bike ride for each month
SELECT AVG(ride_length), DATE_TRUNC('month', started_at) AS month
FROM td_2021
GROUP BY DATE_TRUNC('month', started_at);

-- Finding the average length of each bike ride for each month grouped by rider type
SELECT member_casual, AVG(ride_length), DATE_TRUNC('month', started_at) AS month
FROM td_2021
GROUP BY DATE_TRUNC('month', started_at), member_casual;

-- Finding the median ride length for bike rides in months 09/2020-08/2021. -- 13:00 minutes
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ride_length) FROM td_2021;

-- Finding the max bike ride length. --38 days, 20 hours 24 minutes (an outlier)
SELECT MAX(ride_length) FROM td_2021

-- Finidng the min bike ride length. -- 1:00 minute
SELECT MIN(ride_length) FROM td_2021;

-- Finding the mode (value that appears most often) of ride length. -- 7:00 minutes
SELECT MODE() 
	WITHIN GROUP (ORDER BY ride_length)
FROM td_2021;

-- Counting the amount of 7 min bike rides. -- 219,420
SELECT COUNT(ride_length)
FROM td_2021
WHERE ride_length = '00:07:00';

-- Calc mode day of the week. Result: (Saturday)
SELECT MODE()
	WITHIN GROUP (ORDER BY day_of_week)
FROM td_2021

-- Most popular days for bike riding with avg ride lengths
SELECT member_casual, day_of_week, COUNT(*), AVG(ride_length) AS avg_ride_length FROM td_2021
GROUP BY member_casual, day_of_week
ORDER BY day_of_week

-- Most popular days for bike riding DESC (Sat, Sun, Fri,...)
SELECT day_of_week, COUNT(*) FROM td_2021
GROUP BY day_of_week
ORDER BY COUNT(*) DESC

-- Count of trips over 12 months made by rider type 
SELECT member_casual, COUNT(*) FROM td_2021
GROUP BY member_casual;

-- Count of trips made over 12 months. Grouped by rider type and day of week
SELECT member_casual, day_of_week, COUNT(*) FROM td_2021
GROUP BY member_casual, day_of_week
ORDER BY day_of_week;

-- Calculating average ride length by rider_type
SELECT member_casual, AVG(ride_length) AS avg_ride_length
FROM td_2021
GROUP BY member_casual;

-- Calc the average ride length for rider type by day of week (casual riders ride for much longer than members)
SELECT member_casual, day_of_week, AVG(ride_length) AS avg_ride_length
FROM td_2021
GROUP BY day_of_week, member_casual
ORDER BY day_of_week

-- Selecting most common trip made (Streeter Dr & Grand to Streeter Dr & Grand Ave)
SELECT MODE() WITHIN GROUP
	(ORDER BY trip_made)
FROM (SELECT CONCAT(start_station_name, ' to ', end_station_name) AS trip_made FROM td_2021) a

-- Selecting top ten most common trips made by casual riders with count of rides, and average ride length
-- All top ten trips > 30 min, 2 are over 1 hr in ride length
SELECT member_casual, trip_made, COUNT(trip_made), AVG(ride_length)
FROM (
	SELECT *, CONCAT(start_station_name, ' to ', end_station_name) AS trip_made FROM td_2021
	) A
WHERE member_casual = 'casual'
GROUP BY member_casual, trip_made
ORDER BY COUNT(trip_made) DESC
LIMIT 10

-- Selecting top ten most common trips made by annual/member riders with count of rides, and average ride length
-- Parking garage to law school area. Most trips (9/10) have an average ride_length of <10min. 
SELECT member_casual, trip_made, COUNT(trip_made), AVG(ride_length)
FROM (
	SELECT *, CONCAT(start_station_name, ' to ', end_station_name) AS trip_made FROM td_2021
	) A
WHERE member_casual = 'member'
GROUP BY member_casual, trip_made
ORDER BY COUNT(trip_made) DESC
LIMIT 10

-- Most popular hours for using bike sharing service
--Breaking down rides by the hour
SELECT EXTRACT(hour FROM started_at) as hour_of_ride, COUNT(*)
FROM td_2021
GROUP BY hour_of_ride
ORDER BY COUNT(*) DESC;

--Breaking down count of rides by the hour and type of rider
/* Most popular hours are between 4p-6p for both members & casual riders
and least popular hours are between 2a-5a for both types of riders */
SELECT member_casual, EXTRACT(hour FROM started_at) as hour_of_ride, COUNT(*)
FROM td_2021
GROUP BY member_casual, hour_of_ride
ORDER BY member_casual, COUNT(*) DESC

/* Adding type of bikes to the mix (from query above)
casual riders: ride more in afternoon hours and ride classic bikes more
member riders: same findings */
SELECT member_casual, rideable_type, EXTRACT(hour FROM started_at) as hour_of_ride, COUNT(*)
FROM td_2021
GROUP BY member_casual, hour_of_ride, rideable_type
ORDER BY member_casual, COUNT(*) DESC


