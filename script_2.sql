INSERT INTO sportGroups(location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES
('Sofia-Mladost1', 'Mon', '08:00:00', 1, 1),
('Sofia-Mladost1', 'Mon', '09:00:00', 1, 3),
('Sofia-Lulin', 'Sun', '08:00:00', 2, 1),
('Sofia-Lulin', 'Sun', '09:30:00', 1, 1),
('Sofia-Center', 'Mon', '08:00:00', 6, 3),
('Plovdiv', 'Mon', '12:00:00', 1, 1);


INSERT INTO sportgr_student
VALUES
(1, 1),
(2, 1),
(3, 1),
(1, 2);

SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sports.name
FROM sportgroups JOIN sports
ON sportgroups.sport_id = sport_id;

SELECT coaches.name, sports.name
FROM coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id=sports.id);

SELECT DISTINCT coaches.name, sports.name
FROM coaches JOIN sportgroups
ON coaches.id=sportgroups.coach_id
JOIN sports
ON sportgroups.sport_id=sports.id;

INSERT INTO sportGroups(location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES
('Sofia-Nadezhda', 'Sun', '08:00', 1, NULL);

(SELECT sportgroups.location,
sportgroups.dayOfWeek,
coaches.name
FROM sportgroups LEFT JOIN coaches
ON sportgroups.coach_id=coaches.id)
UNION
(SELECT sportgroups.location, sportgroups.dayOfWeek, coaches.name
FROM sportgroups RIGHT JOIN coaches
ON sportgroups.coach_id=coaches.id
WHERE sportgroups.coach_id=null);

SELECT coaches.name AS CoachName, sports.name AS Sport
FROM coaches JOIN sports
ON coaches.id IN (
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id=sports.id);

SELECT sportgroups.location AS Location, sports.name AS Sport
FROM sportgroups JOIN sports
ON sportgroups.location IN (
SELECT sportgroups.location 
FROM sportgroups 
WHERE sportgroups.location LIKE 'Sofia%');

SELECT students.name, students.class, sportgroups.id
FROM students JOIN sportgroups
ON students.id IN (
	SELECT student_id
	FROM sportgr_student
	WHERE sportgr_student.sportgr_id=sportgroups.id)
WHERE sportgroups.id IN (
	SELECT id
	FROM sportgroups
	WHERE dayOfWeek = 'Mon'
	AND hourOfTraining = '08:00:00'
	AND coach_id IN (
		SELECT id
		FROM coaches
		WHERE name = 'Valentin')
	AND sport_id = (
		SELECT id
		FROM sports
		WHERE name = 'Tennis')); 


INSERT INTO students (name, egn, address, phone, class) 
VALUES
('Petko', '4007890122', 'Sofia-Nadezhda', '089300123', '6'),
('Maria', '5678900234', 'Sofia-Mladost', '088411245', '5'),
('Nikola', '6789002345', 'Sofia-Lulin', '087512345', '4'),
('Elena', '7890120456', 'Sofia-Center', '089923567', '6'),
('Dimitar', '8901034567', 'Plovdiv', '088812345', '7');

INSERT INTO sportGroups (location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES
('Sofia-Mladost', 'Wed', '10:00:00', 1, 1),  
('Sofia-Lulin', 'Fri', '14:00:00', 2, 1),    
('Sofia-Nadezhda', 'Sat', '09:00:00', 1, 3), 
('Plovdiv', 'Sun', '12:00:00', 6, 3),        
('Sofia-Center', 'Mon', '15:00:00', 2, 1);   

INSERT INTO sportgr_student (student_id, sportgr_id)
VALUES
(4, 1), 
(5, 1), 
(6, 2), 
(7, 3), 
(8, 4), 
(3, 5), 
(2, 2), 
(5, 2), 
(6, 1), 
(7, 5), 
(4, 3); 



SELECT s1.name AS Student1, s2.name AS Student2, sg.sport_id, sp.name AS Sport
FROM sportgr_student AS sg1
JOIN sportgr_student AS sg2 ON sg1.sportgr_id = sg2.sportgr_id AND sg1.student_id < sg2.student_id
JOIN students AS s1 ON sg1.student_id = s1.id
JOIN students AS s2 ON sg2.student_id = s2.id
JOIN sportGroups AS sg ON sg1.sportgr_id = sg.id
JOIN sports AS sp ON sg.sport_id = sp.id;

SELECT DISTINCT s1.name AS Student1, 
                s2.name AS Student2, 
                sp.name AS Sport
FROM sportgr_student AS sg1
JOIN sportgr_student AS sg2 
    ON sg1.sportgr_id = sg2.sportgr_id 
    AND sg1.student_id < sg2.student_id 
JOIN students AS s1 
    ON sg1.student_id = s1.id
JOIN students AS s2 
    ON sg2.student_id = s2.id
JOIN sportGroups AS sg 
    ON sg1.sportgr_id = sg.id
JOIN sports AS sp 
    ON sg.sport_id = sp.id;