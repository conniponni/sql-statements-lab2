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
Normalisering till 1NF av tabellen (StudentID, Name, PhoneNumbers)

Problemet:
Den ursprungliga tabellen har kolumnen PhoneNumbers som innehåller flera telefonnummer
för samma student i ett enda fält, t.ex. "070-1234567, 073-5556677".
Detta bryter mot Första normalformen (1NF), där varje attribut ska vara atomärt (endast ett värde per cell).

Lösning – dela upp informationen i två tabeller:

1) Student
   - StudentID (primärnyckel)
   - Name

2) PhoneNumbers
   - StudentID (foreign key som refererar till Student.StudentID)
   - PhoneNumber (ett telefonnummer per rad)

Efter normaliseringen kommer varje telefonnummer att ligga i en separat rad i PhoneNumbers-tabellen.
En student med två telefonnummer får två rader i PhoneNumbers kopplade via samma StudentID.

Detta uppfyller 1NF eftersom:
* varje cell innehåller exakt ett värde
* tabellen blir enklare att söka i med SQL
* index och joins fungerar mer effektivt
* högre normalformer kan användas (t.ex. 2NF och 3NF)
* databasen blir mer skalbar och lättare att underhålla

Exempel efter normalisering:
Student:
10 | Maja
11 | Elias
12 | Sara
13 | Omar

PhoneNumbers:
10 | 070-1234567
10 | 073-5556677
11 | 070-8881122
12 | 072-9911223
12 | 072-9911224
13 | 076-3344556
*/

CREATE TABLE Student
(
    student_id INT PRIMARY KEY,
    name       VARCHAR(50) NOT NULL
);

CREATE TABLE PhoneNumbers
(
    student_id  INT,
    phonenumber VARCHAR(20) NOT NULL,
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

INSERT INTO PhoneNumbers (student_id, phonenumber)
VALUES (10, '070-1234567');

INSERT INTO PhoneNumbers (student_id, phonenumber)
VALUES (10, '073-5556677');

INSERT INTO PhoneNumbers (student_id, phonenumber)
VALUES (11, '070-8881122');

INSERT INTO PhoneNumbers (student_id, phonenumber)
VALUES (12, '072-9911223');

INSERT INTO PhoneNumbers (student_id, phonenumber)
VALUES (12, '072-9911224');

INSERT INTO PhoneNumbers (student_id, phonenumber)
VALUES (13, '076-3344556');



SELECT Student.student_id,
       Student.name,
       PhoneNumbers.phonenumber
FROM Student
         LEFT JOIN PhoneNumbers
                   ON Student.student_id = PhoneNumbers.student_id;



SELECT *
FROM PhoneNumbers;
