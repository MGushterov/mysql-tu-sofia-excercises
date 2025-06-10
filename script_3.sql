DROP TABLE IF EXISTS Programmers;
CREATE TABLE programmers(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
startWorkingDate DATE,
teamLead_id INT DEFAULT NULL,
CONSTRAINT FOREIGN KEY (teamLead_id) REFERENCES programmers(id)
);

INSERT INTO programmers (name, address, startWorkingDate, teamLead_id)
VALUES ('Ivan', 'Sofia', '1999-05-25', NULL),
		('Georgi', 'Bulgaria- Sofia Nadezhda', '2002-12-01', 1),
		('Todor', 'Sofia - Liylin 7', '2009-11-01', 1),
		('Sofiq', 'Sofia - Mladost 4', '2010-01-01', 1),
		('Teodor', 'Sofia - Obelya', '2011-10-01', NULL),
		('Iliya', 'Sofia - Nadezhda', '2000-02-01', 5),
		('Mariela', 'Sofia - Knyajevo', '2005-05-01', 5),
		('Elena', 'Sofia - Krasno Selo', '2008-04-01', 5),
		('Teodor', 'Sofia - Lozenetz', '2012-04-01', 5);
        
SELECT progr.name AS ProgrammerName, progr.address AS ProgrammerAddress, teamLeads.name AS TeamLeadName
FROM programmers AS progr JOIN programmers AS teamLeads
WHERE progr.teamLead_id=teamLeads.id;

CREATE TABLE taxesPayment(
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
group_id INT NOT NULL,
paymentAmount DOUBLE NOT NULL,
month INT,
year INT,
dateOfPayment DATETIME NOT NULL,
CONSTRAINT FOREIGN KEY (student_id) REFERENCES Students(id),
CONSTRAINT FOREIGN KEY (group_id) REFERENCES SportGroups(id)
);

insert into taxesPayment (student_id, group_id, 
paymentAmount, month, year, dateOfPayment)
values
(1, 1, 200, 1, 2023, now()),
(1, 1, 200, 2, 2023, now()),
(1, 1, 200, 3, 2023, now()),
(1, 1, 200, 4, 2023, now()),
(1, 1, 200, 5, 2023, now()),
(1, 1, 200, 6, 2023, now()),
(1, 1, 200, 7, 2023, now()),
(1, 1, 200, 8, 2023, now()),
(1, 1, 200, 9, 2023, now()),
(1, 1, 200, 10, 2023, now()),
(1, 1, 200, 11, 2023, now()),
(1, 1, 200, 12, 2023, now()),
 
(2, 1, 250, 1, 2023, now()),
(2, 1, 250, 2, 2023, now()),
(2, 1, 250, 3, 2023, now()),
(2, 1, 250, 4, 2023, now()),
(2, 1, 250, 5, 2023, now()),
(2, 1, 250, 6, 2023, now()),
(2, 1, 250, 7, 2023, now()),
(2, 1, 250, 8, 2023, now()),
(2, 1, 250, 9, 2023, now()),
(2, 1, 250, 10, 2023, now()),
(2, 1, 250, 11, 2023, now()),
(2, 1, 250, 12, 2023, now()),
 
(1, 2, 200, 2, 2022, now()),
 
(1, 2, 200, 1, 2022, now()),
(1, 2, 200, 2, 2022, now()),
(1, 2, 200, 3, 2022, now()),
(1, 2, 200, 4, 2022, now()),
(1, 2, 200, 5, 2022, now()),
(1, 2, 200, 6, 2022, now()),
(1, 2, 200, 7, 2022, now()),
(1, 2, 200, 8, 2022, now()),
(1, 2, 200, 9, 2022, now()),
(1, 2, 200, 10, 2022, now()),
(1, 2, 200, 11, 2022, now()),
(1, 2, 200, 12, 2022, now()),
 
(4, 2, 200, 1, 2022, now()),
(4, 2, 200, 2, 2022, now()),
(4, 2, 200, 3, 2022, now()),
(4, 2, 200, 4, 2022, now()),
(4, 2, 200, 5, 2022, now()),
(4, 2, 200, 6, 2022, now()),
(4, 2, 200, 7, 2022, now()),
(4, 2, 200, 8, 2022, now()),
(4, 2, 200, 9, 2022, now()),
(4, 2, 200, 10, 2022, now()),
(4, 2, 200, 11, 2022, now()),
(4, 2, 200, 12, 2022, now()),
 
(1, 1, 200, 1, 2021, now()),
(1, 1, 200, 2, 2021, now()),
(1, 1, 200, 3, 2021, now()),
(2, 1, 250, 1, 2021, now()),
 
(3, 1, 250, 1, 2021, now()),
(3, 1, 250, 2, 2021, now()),
(1, 2, 200, 1, 2021, now()),
(1, 2, 200, 2, 2021, now()),
(1, 2, 200, 3, 2021, now()),
(4, 2, 200, 1, 2021, now()),
(4, 2, 200, 2, 2021, now());

SELECT COUNT(coach_id) AS countOfSpWithCoaches 
FROM sportgroups;

SELECT sum(paymentAmount) AS SumOfPayments
FROM taxesPayment
WHERE student_id=4;

SELECT min(paymentAmount) AS MinOfPayments
FROM taxesPayment
WHERE student_id=1;

SELECT avg(paymentAmount) AS AvgOfPayments
FROM taxesPayment
WHERE student_id=1;

SELECT group_id AS GroupID, avg(paymentAmount) AS AverageOfStudentPayment
FROM taxespayment
GROUP BY group_id;

SELECT students.id, students.name AS StudentName, sum(paymentAmount) AS SumOFAllPayments, taxesPayment.month AS Month
FROM taxespayment JOIN students
ON taxespayment.student_id=students.id
GROUP BY month, student_id
HAVING SumOFAllPayments > 500
LIMIT 20;

CREATE VIEW football_students AS
SELECT students.name, students.class, sportGroups.id AS group_id
FROM students
JOIN sportgr_student ON sportgr_student.student_id = students.id
JOIN sportGroups ON sportgr_student.sportgr_id = sportGroups.id
JOIN coaches ON sportGroups.coach_id = coaches.id
WHERE sportGroups.dayOfWeek = 'Mon'
AND sportGroups.hourOfTraining = '08:00:00'
AND coaches.name = 'Ivan'
AND sportGroups.sport_id = (SELECT id FROM sports WHERE name = 'Football');
