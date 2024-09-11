-- Chapter 11: Working with Dates and Times

--1.  Using the New York City taxi data, calculate the length of each ride
-- using the pickup and drop-off timestamps Sort the query results from the
-- longest ride to the shortest Do you notice anything about the longest or
-- shortest trips that you might want to ask city officials about?

SELECT
    trip_id,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    tpep_dropoff_datetime - tpep_pickup_datetime AS length_of_ride
FROM nyc_yellow_taxi_trips_2016_06_01
ORDER BY length_of_ride DESC;

-- 2 Using the AT TIME ZONE keywords, write a query that displays the date
-- and time for London, Johannesburg, Moscow, and Melbourne the moment
-- January 1, 2100, arrives in New York City

SELECT '2100-01-01 00:00:00-05' AT TIME ZONE 'US/Eastern' AS new_york,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Europe/London' AS london,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Africa/Johannesburg' AS johannesburg,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Europe/Moscow' AS moscow,
       '2100-01-01 00:00:00-05' AT TIME ZONE 'Australia/Melbourne' AS melbourne;

-- 3 As a bonus challenge, use the statistics functions in Chapter 10 to cal-
-- culate the correlation coefficient and r-squared values using trip time
-- and the total_amount column in the New York City taxi data, which
-- represents the total amount charged to passengers Do the same with
-- the trip_distance and total_amount columns Limit the query to rides
-- that last three hours or less
SELECT
    round(
          corr(total_amount, (
              date_part('epoch', tpep_dropoff_datetime) -
              date_part('epoch', tpep_pickup_datetime)
                ))::numeric, 2
          ) AS amount_time_corr,
    round(
        regr_r2(total_amount, (
              date_part('epoch', tpep_dropoff_datetime) -
              date_part('epoch', tpep_pickup_datetime)
        ))::numeric, 2
    ) AS amount_time_r2,
    round(
          corr(total_amount, trip_distance)::numeric, 2
          ) AS amount_distance_corr,
    round(
        regr_r2(total_amount, trip_distance)::numeric, 2
    ) AS amount_distance_r2
FROM nyc_yellow_taxi_trips_2016_06_01
WHERE tpep_dropoff_datetime - tpep_pickup_datetime <= '3 hours'::interval;
