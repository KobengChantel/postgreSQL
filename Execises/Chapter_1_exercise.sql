-- Chapter 1: Creating Your First Database and Table
--magine you’re building a database to catalog all the animals at your local
-- zoo You want one table to track the kinds of animals in the collection and
-- another table to track the specifics on each animal Write CREATE TABLE
-- statements for each table that include some of the columns you need Why
-- did you include the columns you chose?



CREATE TABLE animal_types (
   animal_type_id bigserial CONSTRAINT animal_types_key PRIMARY KEY,
   common_name varchar(100) NOT NULL,
   scientific_name varchar(100) NOT NULL,
   conservation_status varchar(50) NOT NULL
);

Select * From animal_types;

CREATE TABLE menagerie (
   menagerie_id bigserial CONSTRAINT menagerie_key PRIMARY KEY,
   animal_type_id bigint REFERENCES animal_types (animal_type_id),
   date_acquired date NOT NULL,
   gender varchar(1),
   acquired_from varchar(100),
   name varchar(100),
   notes text
);
Select * From animal_types;

-- 2. Now create INSERT statements to load sample data into the tables How
-- can you view the data via the pgAdmin tool? Create an additional INSERT
-- statement for one of your tables Purposely omit one of the required commas
-- separating the entries in the VALUES clause of the query What is the error
-- message? Would it help you find the error in the code?

INSERT INTO animal_types (common_name, scientific_name, conservation_status)
VALUES ('Bengal Tiger', 'Panthera tigris tigris', 'Endangered'),
       ('Arctic Wolf', 'Canis lupus arctos', 'Least Concern');

Select * From animal_types;

INSERT INTO menagerie (animal_type_id, date_acquired, gender, acquired_from, name, notes)
VALUES
(1, '1996/3/12', 'F', 'Dhaka Zoo', 'Ariel', 'Healthy coat at last exam.'),
(2, '2003/12/30', 'F', 'National Zoo', 'Freddy', 'Strong appetite.');
Select * From  menagerie;


-- 2b. 

INSERT INTO animal_types (common_name, scientific_name, conservation_status)
VALUES ('Javan Rhino', 'Rhinoceros sondaicus' ,'Critically Endangered');
Select * From animal_types;
