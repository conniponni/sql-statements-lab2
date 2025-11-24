CREATE DATABASE my_database;
USE my_database;
CREATE USER 'appuser'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON my_database.* TO 'appuser'@'localhost';
FLUSH PRIVILEGES;
CREATE TABLE person
(
    person_id  INT AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name  VARCHAR(20) NOT NULL,
    dob        DATE,
    income     DOUBLE,
    PRIMARY KEY (person_id)
);
INSERT INTO person (first_name, last_name, dob, income)
VALUES ('Anna', 'Karlsson', '1995-03-12', 45000);

INSERT INTO person (first_name, last_name, dob, income)
VALUES ('Erik', 'Johansson', '1988-11-02', 51000);

INSERT INTO person (first_name, last_name, dob, income)
VALUES ('Maria', 'Nilsson', '2001-07-24', 32000);

INSERT INTO person (first_name, last_name, dob, income)
VALUES ('David', 'Svensson', '1992-01-15', 60000);

INSERT INTO person (first_name, last_name, dob, income)
VALUES ('Elin', 'Lindgren', '1999-05-30', 38000);

SELECT *
FROM person;

UPDATE person
SET first_name = 'Sofia'
WHERE person_id = 1;

DELETE
FROM person
WHERE person_id = 2;

/*
DEL 6
Normalisering till 1NF av tabellen (StudentID, name, courses)

Kolumnen Courses innehåller flera kurser i samma fält, som bryter mot normalformen (1NF) där alla attribut ska vara atomära -> endast ett värde per cell.

Lösning -> dela upp informationen i två tabeller:

1) Student
- StudentID (primärnyckel)
- Name

2) StudentCourse
- StudentID (foreign key som refererar till Student.ID)
- Course

Genom att ha en seperat tabell för courses som innehåller studentid och courses uppfylles 1NF eftersom varje kolumn nu innehåller ett enda värde.

1NF är viktigt så att:
* data kan sökas korrekt med sql
* index fungerar effektivt
* joins och sql-operationer är effektiva
* högre normalformer kan byggas korrekt
* systemet är skalbart och lätt att underhålla
 */
CREATE TABLE Student
(
    student_id INT PRIMARY KEY,
    name       VARCHAR(50) NOT NULL
);

CREATE TABLE StudentCourse
(
    student_id INT,
    course     VARCHAR(50) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Student (student_id)
);

INSERT INTO Student (student_id, name)
VALUES (10, 'Maja');

INSERT INTO Student (student_id, name)
VALUES (11, 'Elias');

INSERT INTO Student (student_id, name)
VALUES (12, 'Sara');

INSERT INTO Student (student_id, name)
VALUES (13, 'Omar');

INSERT INTO StudentCourse (student_id, course)
VALUES (10, 'Math');

INSERT INTO StudentCourse (student_id, course)
VALUES (10, 'English');

INSERT INTO StudentCourse (student_id, course)
VALUES (10, 'Biology');

INSERT INTO StudentCourse (student_id, course)
VALUES (11, 'Math');

INSERT INTO StudentCourse (student_id, course)
VALUES (11, 'Chemistry');

INSERT INTO StudentCourse (student_id, course)
VALUES (12, 'Physics');

INSERT INTO StudentCourse (student_id, course)
VALUES (12, 'Math');

INSERT INTO StudentCourse (student_id, course)
VALUES (12, 'English');

INSERT INTO StudentCourse (student_id, course)
VALUES (13, 'Biology');

SHOW TABLES;

SELECT Student.student_id,
       Student.name,
       StudentCourse.student_id,
       course
FROM Student
         LEFT JOIN StudentCourse
                   ON Student.student_id = StudentCourse.student_id;

