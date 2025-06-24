CREATE DATABASE CDB;
USE CDB;

CREATE TABLE department (
    DNum INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL,
    Manager_SSN CHAR(11) NOT NULL,
    Manager_Hire_Date DATE
);


CREATE TABLE employee (
    SSN CHAR(11) PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    Birth_Date DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    Supervisor_SSN CHAR(11),
    DNum INT NOT NULL,
    Hire_Date DATE NOT NULL,
    FOREIGN KEY (DNum) REFERENCES department(DNum),
    FOREIGN KEY (Supervisor_SSN) REFERENCES employee(SSN)
);


CREATE TABLE project (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    DNum INT NOT NULL,
    FOREIGN KEY (DNum) REFERENCES department(DNum)
);

CREATE TABLE works_on (
    Employee_SSN CHAR(11),
    PNumber INT,
    Hours DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (Employee_SSN, PNumber),
    FOREIGN KEY (Employee_SSN) REFERENCES employee(SSN),
    FOREIGN KEY (PNumber) REFERENCES project(PNumber)
);


CREATE TABLE employee_dependent (
    Employee_SSN CHAR(11),
    Dependent_Name VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Birth_Date DATE NOT NULL,
    PRIMARY KEY (Employee_SSN, Dependent_Name),
    FOREIGN KEY (Employee_SSN) REFERENCES employee(SSN)
);

ALTER TABLE department
ADD CONSTRAINT fk_manager
FOREIGN KEY (Manager_SSN) REFERENCES employee(SSN);

INSERT INTO department (DNum, DName, Manager_SSN, Manager_Hire_Date)
VALUES 
(1, 'Human Resources', '000-00-0001', '2010-05-15'),
(2, 'IT', '000-00-0002', '2012-03-20'),
(3, 'Finance', '000-00-0003', '2011-07-10'),
(4, 'Marketing', '000-00-0004', '2013-01-25'),
(5, 'Operations', '000-00-0005', '2014-09-05');



INSERT INTO employee (SSN, Pname, Lname, Birth_Date, Gender, Supervisor_SSN, DNum, Hire_Date)
VALUES
('111-11-1111', 'Mohammed', 'Al-Khalid', '1975-04-12', 'M', NULL, 1, '2010-05-15'),
('222-22-2222', 'Fatima', 'Al-Najjar', '1980-08-23', 'F', NULL, 2, '2012-03-20'),
('333-33-3333', 'Ali', 'Al-Haddad', '1978-11-05', 'M', NULL, 3, '2011-07-10'),
('444-44-4444', 'Noor', 'Al-Sabahi', '1982-02-17', 'F', NULL, 4, '2013-01-25'),
('555-55-5555', 'Khalid', 'Al-Maliki', '1977-09-30', 'M', NULL, 5, '2014-09-05');



UPDATE department SET 
    Manager_SSN = CASE DNum 
        WHEN 1 THEN '111-11-1111'
        WHEN 2 THEN '222-22-2222'
        WHEN 3 THEN '333-33-3333'
        WHEN 4 THEN '444-44-4444'
        WHEN 5 THEN '555-55-5555'
    END,
    Manager_Hire_Date = CASE DNum
        WHEN 1 THEN '2010-05-15'
        WHEN 2 THEN '2012-03-20'
        WHEN 3 THEN '2011-07-10'
        WHEN 4 THEN '2013-01-25'
        WHEN 5 THEN '2014-09-05'
    END;


INSERT INTO employee (SSN, Pname, Lname, Birth_Date, Gender, Supervisor_SSN, DNum, Hire_Date)
VALUES
('666-66-6666', 'Sarah', 'Al-Rahman', '1985-06-14', 'F', '111-11-1111', 1, '2015-08-12'),
('777-77-7777', 'Ahmed', 'Al-Saadi', '1983-03-25', 'M', '222-22-2222', 2, '2016-04-18'),
('888-88-8888', 'Layla', 'Al-Farsi', '1987-12-08', 'F', '333-33-3333', 3, '2017-02-22'),
('999-99-9999', 'Omar', 'Al-Qurashi', '1984-07-19', 'M', '444-44-4444', 4, '2018-05-30'),
('101-01-0101', 'Aisha', 'Al-Bakr', '1986-10-11', 'F', '555-55-5555', 5, '2019-11-15');

INSERT INTO project (PNumber, PName, Location, City, DNum)
VALUES
(101, 'HR System Upgrade', 'Headquarters', 'Riyadh', 1),
(102, 'Network Security', 'Data Center', 'Dubai', 2),
(103, 'Annual Budget', 'Finance Tower', 'Doha', 3),
(104, 'Product Launch', 'Marketing Pavilion', 'Abu Dhabi', 4),
(105, 'Warehouse Automation', 'Industrial Zone', 'Jeddah', 5);


INSERT INTO works_on (Employee_SSN, PNumber, Hours)
VALUES
('666-66-6666', 101, 35.50),
('777-77-7777', 102, 40.00),
('777-77-7777', 103, 15.25),
('888-88-8888', 103, 30.75),
('888-88-8888', 104, 10.00),
('999-99-9999', 104, 25.50),
('999-99-9999', 105, 20.00),
('101-01-0101', 105, 37.50),
('101-01-0101', 101, 5.00),
('666-66-6666', 102, 12.75);



INSERT INTO employee_dependent (Employee_SSN, Dependent_Name, Gender, Birth_Date)
VALUES
('111-11-1111', 'Mariam Al-Khalid', 'F', '2005-03-18'),
('111-11-1111', 'Amina Al-Khalid', 'F', '1977-08-22'),
('222-22-2222', 'Yousef Al-Najjar', 'M', '2010-11-05'),
('333-33-3333', 'Zainab Al-Haddad', 'F', '2015-04-30'),
('444-44-4444', 'Abdullah Al-Sabahi', 'M', '1980-07-12'),
('555-55-5555', 'Huda Al-Maliki', 'F', '2012-09-15'),
('666-66-6666', 'Ibrahim Al-Rahman', 'M', '2018-02-28'),
('777-77-7777', 'Mona Al-Saadi', 'F', '1985-01-10'),
('888-88-8888', 'Hamad Al-Farsi', 'M', '2017-06-20'),
('999-99-9999', 'Fatma Al-Qurashi', 'F', '1983-12-03');


SELECT *
FROM employee;

SELECT Pname, Lname, Birth_Date
FROM employee
WHERE Gender = 'F';

SELECT DName, Manager_SSN
FROM department;

SELECT PName, Location
FROM project
WHERE City = 'Dubai';

SELECT Employee_SSN, SUM(Hours) AS TotalHoursWorked
FROM works_on
GROUP BY Employee_SSN;

UPDATE employee
SET Lname = 'Ahmed'
WHERE SSN = '111-11-1111';

UPDATE project
SET Location = 'New Headquarters'
WHERE PName = 'HR System Upgrade';

UPDATE works_on
SET Hours = Hours + 5
WHERE Employee_SSN = '777-77-7777' AND PNumber = 102;

DELETE FROM employee_dependent
WHERE Employee_SSN = '111-11-1111' AND Dependent_Name = 'Mariam Al-Khalid';

