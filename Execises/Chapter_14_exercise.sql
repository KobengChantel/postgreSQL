-- Chapter 14: Analyzing Spatial Data with PostGIS

-- 1. Earlier, you found which U S county has the largest area Now, aggre-
-- gate the county data to find the area of each state in square miles (Use
-- the statefp10 column in the us_counties_2010_shp table ) How many states
-- are bigger than the Yukon-Koyukuk area?

SELECT statefp10 AS st,
       round (
              ( sum(ST_Area(geom::geography) / 2589988.110336))::numeric, 2
             ) AS square_miles
FROM us_counties_2010_shp
GROUP BY statefp10
ORDER BY square_miles DESC;

-- 2 Using ST_Distance(), determine how many miles separate these two
-- farmers’ markets: the Oakleaf Greenmarket (9700 Argyle Forest Blvd,
-- Jacksonville, Florida) and Columbia Farmers Market (1701 West Ash
-- Street, Columbia, Missouri) You’ll need to first find the coordinates for
-- both in the farmers_markets table (Hint: You can also write this query
-- using the Common Table Expression syntax you learned in Chapter 12 )

WITH
    market_start (geog_point) AS
    (
     SELECT geog_point
     FROM farmers_markets
     WHERE market_name = 'The Oakleaf Greenmarket'
    ),
    market_end (geog_point) AS
    (
     SELECT geog_point
     FROM farmers_markets
     WHERE market_name = 'Columbia Farmers Market'
    )
SELECT ST_Distance(market_start.geog_point, market_end.geog_point) / 1609.344 -- convert to meters to miles
FROM market_start, market_end;


-- 3 More than 500 rows in the farmers_markets table are missing a value in the
-- county column, which is an example of dirty government data Using the
-- us_counties_2010_shp table and the ST_Intersects() function, perform a
-- spatial join to find the missing county names based on the longitude and
-- latitude of each market Because geog_point in farmers_markets is of the
-- geography type and its SRID is 4326, you’ll need to cast geom in the census
-- table to the geography type and change its SRID using ST_SetSRID()

SELECT census.name10,
       census.statefp10,
       markets.market_name,
       markets.county,
       markets.st
FROM farmers_markets markets JOIN us_counties_2010_shp census
    ON ST_Intersects(markets.geog_point, ST_SetSRID(census.geom,4326)::geography)
    WHERE markets.county IS NULL
ORDER BY census.statefp10, census.name10;