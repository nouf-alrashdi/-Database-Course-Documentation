create database aggregation_task;
use aggregation_task;

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

-- Instructors 
INSERT INTO Instructors VALUES 
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'), 
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21'); 

-- Categories 
INSERT INTO Categories VALUES 
(1, 'Web Development'), 
(2, 'Data Science'), 
(3, 'Business'); 

-- Courses 
INSERT INTO Courses VALUES 
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'), 
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'), 
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'), 
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01'); 

-- Students 
INSERT INTO Students VALUES 
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'), 
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'), 
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10'); 

-- Enrollments 
INSERT INTO Enrollments VALUES 
(1, 201, 101, '2023-04-10', 100, 5), 
(2, 202, 102, '2023-04-15', 80, 4), 
(3, 203, 101, '2023-04-20', 90, 4), 
(4, 201, 102, '2023-04-22', 50, 3), 
(5, 202, 103, '2023-04-25', 70, 4), 
(6, 203, 104, '2023-04-28', 30, 2), 
(7, 201, 104, '2023-05-01', 60, 3);

/*
1. What is the difference between GROUP BY and ORDER BY? 
   - Both are statements. GROUP BY is used to sort data by grouping them based on specified columns, while ORDER BY organizes the results in ascending or descending order, either alphabetically or numerically.

2. Why do we use HAVING instead of WHERE when filtering aggregate results?
   - HAVING is used for filtering results after aggregation, while WHERE filters rows before aggregation occurs.

3. What are common beginner mistakes when writing aggregation queries?
   - Running long queries without testing them on small datasets first.
   - Writing long queries without comments, making it hard for others to understand the logic.
   - Performing DELETE or UPDATE statements without a WHERE condition, which can accidentally delete all rows.

4. When would you use COUNT(DISTINCT ...), AVG(...), and SUM(...) together?
   - You would use COUNT(DISTINCT ...), AVG(...), and SUM(...) together to analyze the dataset in multiple ways simultaneously, gaining deeper insights for informed decision-making.

5. How does GROUP BY affect query performance and how can indexes help?
   - GROUP BY can slow down query performance as it requires organizing and aggregating data. Indexes can improve performance by allowing the database to quickly locate and sort the necessary rows, making aggregations more efficient.
*/

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students';
SELECT COUNT(*) AS total_students FROM Students;
SELECT COUNT(*) AS total_enrollments FROM Enrollments;

SELECT CourseID, AVG(Rating) AS average_rating 
FROM Enrollments 
GROUP BY CourseID;

SELECT InstructorID, COUNT(*) AS total_courses 
FROM Courses 
GROUP BY InstructorID;

SELECT CategoryID, COUNT(*) AS total_courses 
FROM Courses 
GROUP BY CategoryID;

SELECT CourseID, COUNT(DISTINCT StudentID) AS enrolled_students 
FROM Enrollments 
GROUP BY CourseID;

SELECT CategoryID, AVG(Price) AS average_price 
FROM Courses 
GROUP BY CategoryID;

SELECT MAX(Price) AS max_price FROM Courses;

SELECT CourseID, MIN(Rating) AS min_rating, MAX(Rating) AS max_rating, AVG(Rating) AS avg_rating 
FROM Enrollments 
GROUP BY CourseID;

SELECT COUNT(*) AS five_star_ratings 
FROM Enrollments 
WHERE Rating = 5;