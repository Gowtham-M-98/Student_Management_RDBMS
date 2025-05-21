CREATE DATABASE StudentManagement;
USE StudentManagement;

-- Students Table
CREATE TABLE Students (student_id INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(50), last_name VARCHAR(50), dob DATE,
gender ENUM('Male', 'Female', 'Other'), email VARCHAR(100) UNIQUE);

INSERT INTO Students (first_name, last_name, dob, gender, email) VALUES
('John', 'Doe', '2000-01-01', 'Male', 'john.doe@example.com'),
('Jane', 'Smith', '1999-05-10', 'Female', 'jane.smith@example.com'),
('Michael', 'Brown', '2001-03-22', 'Male', 'michael.brown@example.com'),
('Emily', 'Davis', '2000-07-19', 'Female', 'emily.davis@example.com'),
('Chris', 'Wilson', '1998-12-15', 'Male', 'chris.wilson@example.com'),
('Sophie', 'Taylor', '1999-11-11', 'Female', 'sophie.taylor@example.com'),
('David', 'Lee', '2000-02-14', 'Male', 'david.lee@example.com'),
('Laura', 'Walker', '2001-06-25', 'Female', 'laura.walker@example.com'),
('Daniel', 'Hall', '2002-01-20', 'Male', 'daniel.hall@example.com'),
('Emma', 'Moore', '2001-08-30', 'Female', 'emma.moore@example.com');

SELECT * FROM Students;

-- Instructors Table
CREATE TABLE Instructors (instructor_id INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(50), last_name VARCHAR(50), department VARCHAR(50),
email VARCHAR(100) UNIQUE);

INSERT INTO Instructors (first_name, last_name, department, email) VALUES
('Alan', 'Turing', 'Computer Science', 'alan.turing@example.com'),
('Marie', 'Curie', 'Physics', 'marie.curie@example.com'),
('Isaac', 'Newton', 'Mathematics', 'isaac.newton@example.com'),
('Ada', 'Lovelace', 'Chemistry', 'ada.lovelace@example.com'),
('Richard', 'Feynman', 'Biology', 'richard.feynman@example.com');

SELECT * FROM Instructors;

-- Courses Table
CREATE TABLE Courses (course_id INT AUTO_INCREMENT PRIMARY KEY, 
course_name VARCHAR(100), credits INT, instructor_id INT,
FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id));

INSERT INTO Courses (course_name, credits, instructor_id) VALUES
('Data Structures', 3, 1), ('Human Anatomy', 4, 5),
('Quantum Physics', 3, 2), ('Linear Algebra', 3, 3),
('Molecular Structure', 4, 5);

SELECT * FROM Courses;

-- Enrollments Table
CREATE TABLE Enrollments (enrollment_id INT AUTO_INCREMENT PRIMARY KEY, 
student_id INT, course_id INT, semester VARCHAR(10), enrollment_date DATE,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id));

INSERT INTO Enrollments (student_id, course_id, semester, enrollment_date) VALUES
(1, 1, 'Spring', '2025-01-15'),
(2, 1, 'Spring', '2025-01-15'),
(3, 2, 'Spring', '2025-01-16'),
(4, 3, 'Spring', '2025-01-17'),
(5, 3, 'Spring', '2025-01-17'),
(6, 4, 'Spring', '2025-01-18'),
(7, 5, 'Spring', '2025-01-19'),
(8, 2, 'Spring', '2025-01-20'),
(9, 1, 'Spring', '2025-01-20'),
(10, 4, 'Spring', '2025-01-21');

-- Grades Table
CREATE TABLE Grades (grade_id INT AUTO_INCREMENT PRIMARY KEY, 
enrollment_id INT, grade CHAR(2),
FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id));

INSERT INTO Grades (enrollment_id, grade) VALUES
(1, 'A'), (2, 'B'),
(3, 'A'), (4, 'B'),
(5, 'C'), (6, 'A'),
(7, 'B'), (8, 'B'),
(9, 'A'), (10, 'A');

-- Using JOINS - Fetch student name, course name, and grade
SELECT s.first_name, s.last_name, c.course_name, g.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id;

-- Using View - StudentTranscript View (a consolidated report of student academic records)
CREATE VIEW StudentTranscript AS
SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name,
c.course_name, c.credits, e.semester, g.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id;

SELECT * FROM StudentTranscript WHERE student_id = 1;

-- Using SubQuery - Fetch students who got an 'A' grade
SELECT first_name, last_name
FROM Students
WHERE student_id IN (SELECT e.student_id
FROM Enrollments e
JOIN Grades g ON e.enrollment_id = g.enrollment_id
WHERE g.grade = 'A');

-- Using Stored Procedures - Count the enrollement per courses
DELIMITER $$
CREATE PROCEDURE CountEnrollmentsPerCourse()
BEGIN
    SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrolled
    FROM Courses c
    LEFT JOIN Enrollments e ON c.course_id = e.course_id
    GROUP BY c.course_id;
END $$
DELIMITER ;

CALL CountEnrollmentsPerCourse();

