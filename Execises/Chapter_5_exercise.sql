-- Chapter 5: Basic Math and Stats with SQL

-- 1. Write a SQL statement for calculating the area of a circle whose radius is
-- 5 inches. Do you need parentheses in your calculation? Why or why not?

-- Answer:
-- (The formula for the area of a circle is: pi * radius squared.)

SELECT 3.14 * 5 ^ 2;
-- The result is an area of 78.5 square inches.
-- Note: You do not need parentheses because exponents and roots take precedence
-- over multiplication. However, you could include parentheses for clarity. This
-- statement produces the same result:

SELECT 3.14 * (5 ^ 2);

--2. Using the 2010 Census county data, find out which New York state county
-- has the highest percentage of the population that identified as “American
-- Indian/Alaska Native Alone ” What can you learn about that county from
-- online research that explains the relatively large proportion of American
-- Indian population compared with other New York counties
-- - Franklin County, N.Y., with 7.4%. The county contains the St. Regis Mohawk

SELECT geo_name,
       state_us_abbreviation,
       p0010001 AS total_population,
       p0010005 AS american_indian_alaska_native_alone,
       (CAST (p0010005 AS numeric(8,1)) / p0010001) * 100
           AS percent_american_indian_alaska_native_alone
FROM us_counties_2010
WHERE state_us_abbreviation = 'NY'
ORDER BY percent_american_indian_alaska_native_alone DESC;

--3. Was the 2010 median county population higher in California or New York
--the median for each state one at a time:
SELECT percentile_cont(.5)
        WITHIN GROUP (ORDER BY p0010001)
FROM us_counties_2010
WHERE state_us_abbreviation = 'NY';

SELECT percentile_cont(.5)
        WITHIN GROUP (ORDER BY p0010001)
FROM us_counties_2010
WHERE state_us_abbreviation = 'CA';
--Or both in one query
SELECT state_us_abbreviation,
       percentile_cont(0.5)
          WITHIN GROUP (ORDER BY p0010001) AS median
FROM us_counties_2010
WHERE state_us_abbreviation IN ('NY', 'CA')
GROUP BY state_us_abbreviation;
--query shows the median for each state:

SELECT state_us_abbreviation,
       percentile_cont(0.5)
          WITHIN GROUP (ORDER BY p0010001) AS median
FROM us_counties_2010
GROUP BY state_us_abbreviation;
