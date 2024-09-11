-- Chapter 2: Beginning Data Exploration with SELECT

--1. The school district superintendent asks for a list of teachers in each school
-- Write a query that lists the schools in alphabetical order along with teach-
-- ers ordered by last name A–Z

SELECT school, first_name, last_name
FROM teachers
ORDER BY school, last_name;

--2. Write a query that finds the one teacher whose first name starts with the
-- letter S and who earns more than $40,000

SELECT first_name, last_name, school, salary
FROM teachers
WHERE first_name LIKE 'S%' -- remember that LIKE is case-sensitive!
      AND salary > 40000;

--3. Rank teachers hired since January 1, 2010, ordered by highest paid to
-- lowes

SELECT last_name, first_name, school, hire_date, salary
FROM teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;




