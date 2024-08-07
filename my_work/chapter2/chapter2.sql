-- 2.1  Querying all rows and columns from the teachers table
SELECT * FROM teachers;
-- 2.2 Querying a subset of columns
	SELECT last_name, first_name, salary FROM teachers;
-- 2.3 Querying distinct values in the school column
SELECT DISTINCT school 
FROM teachers;
-- 2.4 Querying distinct pairs of values in the school and salary column
SELECT DISTINCT school, salary 
FROM teachers;
-- 2.5 Sorting a column with ORDER BY
SELECT first_name, last_name, salary 
FROM teachers
ORDER BY salary DESC
-- 2.6  Sorting multiple columns with ORDER BY
SELECT last_name, school, hire_date 
FROM teachers
u ORDER BY school ASC, hire_date DESC;
 -- 2-7: Filtering rows using WHERE
SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

-- : Comparison and Matching Operators in PostgreSQL
 -- equals operator to find teachers whose first name is Janet:
SELECT first_name, last_name, school
FROM teachers
WHERE first_name = 'Janet;
	
-- school names in the table but exclude F.D. Roosevelt HS using the not equal operator: 
SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS';
	
-- e we use the less than operator to list teachers hired before January 1, 2000 (using the date format YYYY-MM-DD):
SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';
	
-- find teachers who earn $43,500 or more using the >= operator:	
SELECT first_name, last_name, salary
FROM teachers
WHERE salary >= 43500;
	
--he next query uses the BETWEEN operator to find teachers who earn 
--between $40,000 and $65,000. Note that BETWEEN is inclusive, meaning the 
--result will include values matching the start and end ranges specified:
	
SELECT first_name, last_name, school, salary
FROM teachers
WHERE salary BETWEEN 40000 AND 65000;

-- Using LIKE and ILIKE with WHERE
--2.8Filtering with LIKE and ILIKE
	
SELECT first_name
FROM teachers
WHERE first_name LIKE 'sam';

SELECT first_name
FROM teachers
WHERE first_name ILIKE 'sam%';

-- Combining Operators with AND and OR
-- Combining operators using AND and OR
SELECT *
FROM teachers
WHERE school = 'Myers Middle School'
 AND salary < 40000;

SELECT *
FROM teachers
WHERE last_name = 'Cole'
 OR last_name = 'Bush';

SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS'
 AND (salary < 38000 OR salary > 40000);

--Putting It All Together

-- Listing 2-10: A SELECT statement including WHERE and ORDER B
	
SELECT first_name, last_name, school, hire_date, salary
FROM teachers
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC; 

-- Wrapping Up


