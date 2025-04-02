-- Creating all  the tables

CREATE TABLE zip_code (
    zip_code VARCHAR(4) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
 province VARCHAR(50) NOT NULL,
    CHECK (LENGTH(zip_code) <= 4)
);
Select * From zip_code;
Drop Table zip_code;

CREATE TABLE profession (
    profession_id SERIAL PRIMARY KEY,
    profession_name VARCHAR(100) UNIQUE NOT NULL
);
Select * From  profession;

CREATE TABLE status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL
);
Select * From  status;

CREATE TABLE seeking (
    seeking_id SERIAL PRIMARY KEY,
    seeking_name VARCHAR(100) NOT NULL
);
Select * From  seeking;

CREATE TABLE my_contacts (
    contact_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    gender VARCHAR(10),
    birthday DATE,
    profession_id INT,
    zip_code VARCHAR(4),
    status_id INT,
    FOREIGN KEY (profession_id) REFERENCES profession(profession_id),
    FOREIGN KEY (zip_code) REFERENCES zip_code(zip_code),
    FOREIGN KEY (status_id) REFERENCES status(status_id)
);
Select * From  my_contacts;

CREATE TABLE interests (
    interest_id SERIAL PRIMARY KEY,
    interest_name VARCHAR(100) NOT NULL
);
Select * From   interests;

CREATE TABLE contact_interest (
    contact_id INT,
    interest_id INT,
    PRIMARY KEY (contact_id, interest_id),
    FOREIGN KEY (contact_id) REFERENCES my_contacts(contact_id),
    FOREIGN KEY (interest_id) REFERENCES interests(interest_id)
);
Select * From  contact_interest ;

CREATE TABLE contact_seeking (
    contact_id INT,
    seeking_id INT,
    PRIMARY KEY (contact_id, seeking_id),
    FOREIGN KEY (contact_id) REFERENCES my_contacts(contact_id),
    FOREIGN KEY (seeking_id) REFERENCES seeking(seeking_id)
);
Select * From  contact_seeking;

-- Insert data into zip_code table

INSERT INTO zip_code (zip_code, city, province) VALUES
('1001', 'City1', 'Province1'),
('1002', 'City2', 'Province1'),
('2001', 'City3', 'Province2'),
('2002', 'City4', 'Province2'),
('3001', 'City5', 'Province3'),
('3002', 'City6', 'Province3'),
('4001', 'City7', 'Province4'),
('4002', 'City8', 'Province4'),
('5001', 'City9', 'Province5'),
('5002', 'City10', 'Province5'),
('6001', 'City11', 'Province6'),
('6002', 'City12', 'Province6'),
('7001', 'City13', 'Province7'),
('7002', 'City14', 'Province7'),
('8001', 'City15', 'Province8'),
('8002', 'City16', 'Province8'),
('9001', 'City17', 'Province9'),
('9002', 'City18', 'Province9');

-- Insert data into profession table

INSERT INTO profession (profession_name) VALUES
('Engineer'),
('Doctor'),
('Artist'),
('Teacher'),
('Lawyer');

-- Insert data into status table

INSERT INTO status (status_name) VALUES
('Single'),
('Married'),
('Divorced');

-- Insert data into seeking table

INSERT INTO seeking (seeking_name) VALUES
('Friendship'),
('Networking'),
('Romance');

-- Insert data into my_contacts table

INSERT INTO my_contacts (first_name, last_name, phone, email, gender, birthday, profession_id, zip_code, status_id) VALUES
('John', 'Doe', '555-1234', 'john@example.com', 'Male', '1990-01-01', 1, '1001', 1),
('Jane', 'Smith', '555-5678', 'jane@example.com', 'Female', '1985-05-15', 2, '2001', 2),
('Alice', 'Brown', '555-8765', 'alice@example.com', 'Female', '1992-07-22', 3, '3001', 1),
('Bob', 'Davis', '555-4321', 'bob@example.com', 'Male', '1988-02-10', 4, '4001', 2),
('Charlie', 'Miller', '555-8761', 'charlie@example.com', 'Male', '1987-03-13', 5, '5001', 1),
('David', 'Wilson', '555-3421', 'david@example.com', 'Male', '1991-04-04', 1, '6001', 1),
('Eve', 'Taylor', '555-1290', 'eve@example.com', 'Female', '1986-12-08', 2, '7001', 2),
('Frank', 'Anderson', '555-4567', 'frank@example.com', 'Male', '1993-11-20', 3, '8001', 1),
('Grace', 'Thomas', '555-9876', 'grace@example.com', 'Female', '1989-09-25', 4, '9001', 2),
('Hank', 'Jackson', '555-9871', 'hank@example.com', 'Male', '1990-06-06', 5, '1002', 1),
('Ivy', 'White', '555-6543', 'ivy@example.com', 'Female', '1994-08-08', 1, '2002', 1),
('Jack', 'Harris', '555-3456', 'jack@example.com', 'Male', '1985-11-11', 2, '3002', 2),
('Karen', 'Clark', '555-7654', 'karen@example.com', 'Female', '1991-10-10', 3, '4002', 1),
('Leo', 'Lewis', '555-1235', 'leo@example.com', 'Male', '1987-01-12', 4, '5002', 2),
('Mia', 'Robinson', '555-8762', 'mia@example.com', 'Female', '1990-03-18', 5, '6002', 1);

-- Insert data into interests table

INSERT INTO interests (interest_name) VALUES
('Sports'),
('Music'),
('Reading'),
('Traveling'),
('Cooking');



-- Assign exactly 2 interests per contact

-- Delete existing data
DELETE FROM contact_interest;
DELETE FROM contact_seeking;

-- Insert exactly 1 interest per contact
INSERT INTO contact_interest (contact_id, interest_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 1),
(6, 2),
(7, 3),
(8, 4),
(9, 1),
(10, 2),
(11, 3),
(12, 4),
(13, 1),
(14, 2),
(15, 3);
Select * From contact_interest;

-- Insert exactly 1 seeking per contact
INSERT INTO contact_seeking (contact_id, seeking_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2),
(6, 3),
(7, 1),
(8, 2),
(9, 3),
(10, 1),
(11, 2),
(12, 3),
(13, 1),
(14, 2),
(15, 3);
Select * From contact_seeking;

-- LEFT JOIN query to fetch the required data
SELECT 
    p.profession_name AS profession,
    z.zip_code, z.city, z.province,
    s.status_name AS status,
    STRING_AGG(i.interest_name, ', ' ORDER BY i.interest_name) AS interests,
    STRING_AGG(se.seeking_name, ', ' ORDER BY se.seeking_name) AS seeking
FROM 
    my_contacts c
LEFT JOIN 
    profession p ON c.profession_id = p.profession_id
LEFT JOIN 
    zip_code z ON c.zip_code = z.zip_code
LEFT JOIN 
    status s ON c.status_id = s.status_id
LEFT JOIN 
    contact_interest ci ON c.contact_id = ci.contact_id
LEFT JOIN 
    interests i ON ci.interest_id = i.interest_id
LEFT JOIN 
    contact_seeking cs ON c.contact_id = cs.contact_id
LEFT JOIN 
    seeking se ON cs.seeking_id = se.seeking_id
GROUP BY 
    c.contact_id, p.profession_name, z.zip_code, z.city, z.province, s.status_name;
