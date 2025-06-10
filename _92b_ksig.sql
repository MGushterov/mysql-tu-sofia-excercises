CREATE DATABASE _92b_ksig;
USE _92b_ksig;
CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE,
phone VARCHAR(10) NULL DEFAULT NULL,
class VARCHAR(5) NULL DEFAULT NULL
);

CREATE TABLE sports(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE coaches(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE
);


CREATE TABLE sportGroups(
id INT AUTO_INCREMENT PRIMARY KEY,
location VARCHAR(50) NOT NULL,
dayOfWeek ENUM('Mon', 'Tus', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'),
hourOfTraining TIME NOT NULL,
sport_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (sport_id) REFERENCES sports(id),
coach_id INT,
CONSTRAINT FOREIGN KEY (coach_id) REFERENCES coaches(id),
UNIQUE KEY (location, dayOfWeek, hourOfTraining)
);

CREATE TABLE sportgr_student(
student_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (student_id) REFERENCES students(id),
sportgr_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (sportgr_id) REFERENCES sportGroups(id),
PRIMARY KEY (student_id, sportgr_id)
);

INSERT INTO sports
VALUES
(NULL, 'Football'),
(NULL, 'Volleyball'),
(NULL, 'Tennis');

INSERT INTO coaches(name, egn)
VALUES
('Ivan', '1234567890'),
('Petar', '2345678901'),
('Kaloyan', '3456789012');

INSERT INTO students(name, egn, address, phone, class)
VALUES
('Ilyan', '1234567890', 'Sofia-Mladost', '089233266', '4'),
('Ivan', '2345678901', 'Sofia-Lulin', '885200030', '5'),
('Ana', '3456789012', 'Sofia-Center', '089200266', '5');

UPDATE coaches
set name='Valentin'
WHERE id=3;

DELETE FROM coaches
WHERE id=2;

SELECT * 
FROM students;

SELECT *
FROM students
WHERE id>=1 and id<=2;

SELECT *
FROM students
WHERE name like 'I%';