/* Now that all of our data is consistent (IDs for stations across different months are now the same) and datatypes are the same
we can merge all of our data. Because we want all rows, we can use a UNION ALL statement to union all 12 months. This should be no problem now as there
are the same number of columns and each columns datatype matches */


-- Merging data into a new table 
SELECT * INTO td_2021 FROM (
SELECT * FROM "202009_td"
UNION ALL
SELECT * FROM "202010_td"
UNION ALL 
SELECT * FROM "202011_td"
UNION ALL
SELECT * FROM "202012_td"
UNION ALL
SELECT * FROM "202101_td"
UNION ALL
SELECT * FROM "202102_td"
UNION ALL
SELECT * FROM "202103_td"
UNION ALL
SELECT * FROM "202104_td"
UNION ALL
SELECT * FROM "202105_td"
UNION ALL
SELECT * FROM "202106_td"
UNION ALL 
SELECT * FROM "202107_td"
UNION ALL
SELECT * FROM "202108_td") td_2021

/*Successfully run. Total query runtime: 13 secs 423 msec.
4230495 rows affected. */

