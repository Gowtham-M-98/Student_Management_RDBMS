# Student Management System (MySQL Project)

This is a **Student Management System** built using **MySQL**, which manages information about students, courses, enrollments, grades, and instructors. The project demonstrates relational database design, SQL query usage (including JOINs, Views, Subqueries, and Stored Procedures), and the ability to model real-world academic systems.

---

##  Features

- Store and manage **student** details
- Store **instructor** and **course** information
- Enroll students into courses
- Record and track **grades**
- Generate **transcripts**
- Use **JOINs**, **Views**, **Subqueries**, and **Stored Procedures**

---

##  Technologies Used

- **MySQL** – Relational database
- **SQL** – For creating schema, inserting data, and querying

---

## Database Tables

### 1. `Students`
Stores student information like name, date of birth, gender, and email.

### 2. `Instructors`
Stores instructor details and their department.

### 3. `Courses`
Stores course information and assigns each course to an instructor.

### 4. `Enrollments`
Tracks which student is enrolled in which course for a given semester.

### 5. `Grades`
Records the grades assigned to students per enrollment.

---

### Queries and Analysis

The project includes various SQL queries and data analysis tasks to extract valuable insights from the Students data. Some of the key queries implemented include:

**1. JOIN** - To retrieve data from multiple tables in a relational database, the JOIN clause can be used to combine records from **Students, Enrollments, Courses, and Grades** tables for the details about the students.

**2. VIEW** - Created a VIEW that provides a consolidated report of student academic records.

**3. SUBQUERY** - To fetch students who got an 'A' grade in the academic, a SUBQUERY is used.

**4. STORED PROCEDURE** - To count the enrollement as per the course, a stored procedure is used.

## Database Schema Overview

```plaintext
Students       <----> Enrollments <----> Courses <----> Instructors
                   |                  |
                   v                  v
                Grades            (via instructor_id)
