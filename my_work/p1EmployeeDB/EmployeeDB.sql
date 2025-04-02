--Create department table
CREATE TABLE Department (
	depart_id integer PRIMARY KEY,
	depart_name VARCHAR(255) NOT NULL,
	depart_city VARCHAR
);
SELECT * FROM Department;

--Create Employees Table
CREATE TABLE Employees (
	emp_id integer PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	surname VARCHAR(255) NOT NULL,
	gender char NOT NULL,
	address character varying(50) NOT NULL,
	email VARCHAR(255) NOT NULL,
	depart_id integer NOT NULL,
	role_id integer NOT NULL,
	salary integer NOT NULL,
	overtime integer NOT NULL,
	FOREIGN KEY (depart_id) REFERENCES Department(depart_id)
);
Select * from Employees;
Drop Table Employees;

--Create Role table
CREATE TABLE Roles(
	role_id INT PRIMARY KEY,
    roles VARCHAR(50) NOT NULL
	
);
Select * From Roles;
Drop Table Roles;

--Create Table for salaries
CREATE TABLE Salaries (
    salary_id integer PRIMARY KEY,
    emp_id integer,
    role_id integer,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);
Select * From salaries;

-- Create Overtimes Table
CREATE TABLE Overtimes (
    overtime_id INT PRIMARY KEY,
    emp_id INT,
    overtime_hours DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);
Select * from Overtimes;

--STEP 3 INSERTING DATA

-- Insert into Departments
INSERT INTO Department (depart_id, depart_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');

-- Insert into Employees
INSERT INTO Employees (emp_id, first_name, surname, gender, address, email, depart_id, role_id, salary, overtime)
VALUES (1, 'Alice', 'Smith', 'F', '123 Main St', 'alice@example.com', 1, 1, 50000, 10);

INSERT INTO Employees (emp_id, first_name, surname, gender, address, email, depart_id, role_id, salary, overtime)
VALUES (2, 'John', 'Doe', 'M', '456 Elm St', 'john@example.com', 2, 2, 60000, 15);

INSERT INTO Employees (emp_id, first_name, surname, gender, address, email, depart_id, role_id, salary, overtime)
VALUES (3, 'Jane', 'Doe', 'F', '789 Oak St', 'jane@example.com', 1, 3, 55000, 12);

Select * from Employees;

-- Insert into Role
INSERT INTO roles (role_id, roles) VALUES
(1, 'Manager'),
(2, 'Developer'),
(3, 'Salesperson');
Select * from Roles;

INSERT INTO Salaries (salary_id, emp_id, role_id, salary)
VALUES 
(1, 1, 1, 75000.00),
(2, 2, 2, 80000.00),
(3, 3, 3, 50000.00);

DROP TABLE Salaries;
Select * from Salaries;

-- Insert into Overtimes
INSERT INTO Overtimes (overtime_id, emp_id, overtime_hours) VALUES
(1, 1, 10.5),
(2, 2, 5.0),
(3, 3, 2.0);
Select * From Overtimes;


--Step 4: LEFT JOIN Query
--Shorten table and column names, making the query easier to write and read.
--Aliases (e, d, s, j, o) are used consistently and appropriately to reference the tables
--To display department name, job title, salary figure, and overtime hours worked, you can use the following LEFT JOIN query
SELECT
    d.depart_name,
    j.roles,
    s.salary,
    o.overtime_hours
FROM
    Employees e
    LEFT JOIN Department d ON e.depart_id = d.depart_id
    LEFT JOIN Salaries s ON e.emp_id = s.emp_id
    LEFT JOIN Roles j ON e.role_id = j.role_id
    LEFT JOIN Overtimes o ON e.emp_id = o.emp_id;
