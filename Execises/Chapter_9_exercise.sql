-- Chapter 9: Inspecting and Modifying Data
-- n this exercise, you’ll turn the meat_poultry_egg_inspect table into useful infor-
-- mation You need to answer two questions: how many of the plants in the table
-- process meat, and how many process poultry?
-- The answers to these two questions lie in the activities column Unfortu-
-- nately, the column contains an assortment of text with inconsistent input Here’s
-- an example of the kind of text you’ll find in the activities column:
-- Poultry Processing, Poultry Slaughter
-- Meat Processing, Poultry Processing
-- Poultry Processing, Poultry Slaughter
-- Inspecting and Modifying Data 153
-- The mishmash of text makes it impossible to perform a typical count that
-- would allow you to group processing plants by activity However, you can
-- make some modifications to fix this data Your tasks are as follows:

-- 1 Create two new columns called meat_processing and poultry_processing
-- in your table Each can be of the type boolean

-- 2 Using UPDATE, set meat_processing = TRUE on any row where the activities
-- column contains the text Meat Processing Do the same update on the
-- poultry_processing column, but this time look for the text Poultry Processing
-- in activities

-- 3 Use the data from the new, updated columns to count how many plants
-- perform each type of activity For a bonus challenge, count how many
-- plants perform both activitie


-- Answer:
-- a) Add the columns

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN meat_processing boolean;
ALTER TABLE meat_poultry_egg_inspect ADD COLUMN poultry_processing boolean;

SELECT * FROM meat_poultry_egg_inspect; -- view table with new empty columns

-- b) Update the columns

UPDATE meat_poultry_egg_inspect
SET meat_processing = TRUE
WHERE activities ILIKE '%meat processing%'; -- case-insensitive match with wildcards

UPDATE meat_poultry_egg_inspect
SET poultry_processing = TRUE
WHERE activities ILIKE '%poultry processing%'; -- case-insensitive match with wildcards

-- c) view the updated table

SELECT * FROM meat_poultry_egg_inspect;

-- d) Count meat and poultry processors

SELECT count(meat_processing), count(poultry_processing)
FROM meat_poultry_egg_inspect;

-- e) Count those who do both

SELECT count(*)
FROM meat_poultry_egg_inspect
WHERE meat_processing = TRUE AND
      poultry_processing = TRUE;
