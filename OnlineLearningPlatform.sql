CREATE DATABASE  OnlineLearningPlatform ;
USE  OnlineLearningPlatform;

CREATE TABLE Instructors ( 
    InstructorID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 

CREATE TABLE Categories ( 
    CategoryID INT PRIMARY KEY, 
    CategoryName VARCHAR(50) 
); 

CREATE TABLE Courses ( 
    CourseID INT PRIMARY KEY, 
    Title VARCHAR(100), 
    InstructorID INT, 
    CategoryID INT, 
    Price DECIMAL(6,2), 
    PublishDate DATE, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID), 
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 
); 

CREATE TABLE Students ( 
    StudentID INT PRIMARY KEY, 
    FullName VARCHAR(100), 
    Email VARCHAR(100), 
    JoinDate DATE 
); 

CREATE TABLE Enrollments ( 
    EnrollmentID INT PRIMARY KEY, 
    StudentID INT, 
    CourseID INT, 
    EnrollDate DATE, 
    CompletionPercent INT, 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID), 
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) 
); 
 
INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 

INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 

INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 

INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3)


/*GROUP BY vs ORDER BY:

GROUP BY groups rows with identical values into summary rows

ORDER BY sorts the result set in ascending or descending order

GROUP BY is used with aggregate functions, ORDER BY just sorts data

HAVING vs WHERE:

WHERE filters rows before aggregation

HAVING filters groups after aggregation

HAVING is used with GROUP BY to filter aggregate results

Common beginner mistakes:

Forgetting to include non-aggregated columns in GROUP BY

Using WHERE instead of HAVING to filter aggregates

Confusing COUNT(*) with COUNT(column_name) (one counts NULLs)

Not understanding NULL handling in aggregate functions

COUNT(DISTINCT), AVG, SUM together:

When you need multiple aggregate metrics in one query

Example: COUNT(DISTINCT customers), AVG(order_value), SUM(revenue)

Common in analytical reports showing different dimensions

GROUP BY performance:

GROUP BY can be expensive as it requires sorting/grouping data

Indexes on GROUP BY columns can significantly improve performance

Appropriate indexes allow the database to avoid full table scans*/

SELECT COUNT(*) AS TotalStudents FROM Students;

SELECT COUNT(*) AS TotalEnrollments FROM Enrollments;

SELECT CourseID, AVG(Rating) 
FROM Enrollments 
GROUP BY CourseID;

SELECT InstructorID, COUNT(*) 
FROM Courses 
GROUP BY InstructorID;

SELECT CategoryID, COUNT(*) 
FROM Courses 
GROUP BY CategoryID;

SELECT CourseID, COUNT(StudentID) 
FROM Enrollments 
GROUP BY CourseID;

SELECT CategoryID, AVG(Price) 
FROM Courses 
GROUP BY CategoryID;


SELECT MAX(Price) FROM Courses;

SELECT CourseID, MIN(Rating), MAX(Rating), AVG(Rating)
FROM Enrollments
GROUP BY CourseID;

SELECT COUNT(*) 
FROM Enrollments 
WHERE Rating = 5;

SELECT CourseID, AVG(CompletionPercent)
FROM Enrollments
GROUP BY CourseID;

SELECT StudentID
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 1;

SELECT 
    CourseID,
    Price * (SELECT COUNT(*) FROM Enrollments WHERE CourseID = Courses.CourseID) AS MoneyEarned
FROM Courses;

SELECT 
    Instructors.InstructorID,
    Instructors.FullName,
    COUNT(DISTINCT Enrollments.StudentID) AS StudentCount
FROM 
    Instructors,
    Courses,
    Enrollments
WHERE 
    Instructors.InstructorID = Courses.InstructorID
    AND Courses.CourseID = Enrollments.CourseID
GROUP BY 
    Instructors.InstructorID, Instructors.FullName;



SELECT 
    Categories.CategoryName,
    COUNT(Enrollments.EnrollmentID) / COUNT(DISTINCT Courses.CourseID) AS AvgEnrollments
FROM 
    Categories
    LEFT JOIN Courses ON Categories.CategoryID = Courses.CategoryID
    LEFT JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY 
    Categories.CategoryName;

SELECT 
    Instructors.FullName,
    AVG(Enrollments.Rating) AS AvgRating
FROM 
    Instructors
    JOIN Courses ON Instructors.InstructorID = Courses.InstructorID
    JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY 
    Instructors.FullName;



SELECT TOP 3
    Courses.Title,
    COUNT(Enrollments.EnrollmentID) AS EnrollmentCount
FROM 
    Courses
    JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY 
    Courses.Title
ORDER BY 
    COUNT(Enrollments.EnrollmentID) DESC;


SELECT 
    Courses.Title,
    AVG(DATEDIFF(day, Enrollments.EnrollDate, GETDATE())) AS AvgDaysToComplete
FROM 
    Courses
    JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
WHERE 
    Enrollments.CompletionPercent = 100
GROUP BY 
    Courses.Title;

SELECT 
    Courses.Title,
    ROUND(100 * AVG(Enrollments.CompletionPercent), 0) AS CompletionPercentage
FROM 
    Courses
    JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY 
    Courses.Title;

SELECT 
    YEAR(Courses.PublishDate) AS Year,
    COUNT(*) AS CourseCount
FROM 
    Courses
GROUP BY 
    YEAR(Courses.PublishDate)
ORDER BY 
    Year;