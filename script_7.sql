USE _92b_ksig;

DROP TABLE IF EXISTS salaryPayments;
CREATE TABLE salaryPayments( 
	id INT AUTO_INCREMENT PRIMARY KEY, 
    coach_id INT NOT NULL, month TINYINT, 
    year YEAR, 
    salaryAmount double,
	dateOfPayment datetime not null,
	CONSTRAINT FOREIGN KEY (coach_id) references coaches (id),
	UNIQUE KEY(coach_id, month,year)
);

INSERT INTO coaches(name, egn)
VALUES
('Pepi',  '9901019080'),
('Andro', '9702023090'),
('Maria', '9609023456');


INSERT INTO salaryPayments(coach_id, month, year, salaryAmount, dateOfPayment)
VALUE
(1, 5, 2016, 2100, '2016-05-22 11:45:08');
INSERT INTO salaryPayments(coach_id, month, year, salaryAmount, dateOfPayment)
VALUES
(1, 4, 2016, 2100, '2016-04-22 11:45:08'),
(1, 6, 2016, 2200, '2016-06-22 11:45:08'),
(3, 4, 2016, 2500, '2016-04-22 11:45:08'),
(4, 5, 2016, 2400, '2016-05-22 11:45:08'),
(5, 6, 2016, 2200, '2016-06-22 11:45:08'),
(6, 7, 2016, 2200, '2016-07-22 11:45:08');

DROP PROCEDURE IF EXISTS CursorTest;
DELIMITER |
CREATE PROCEDURE CursorTest()
BEGIN
	DECLARE finished INT;
    DECLARE tempName VARCHAR(100);
    DECLARE tempEgn VARCHAR(10);
    DECLARE coachCursor CURSOR FOR
    SELECT name, egn
    FROM coaches JOIN salarypayments ON (coaches.id = salarypayments.coach_id)
    WHERE salaryAmount IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND set finished = 1;
    SET finished = 0;
    OPEN coachCursor;
    coach_loop: WHILE (finished = 0)
    DO
    FETCH coachCursor INTO tempName, tempEgn;
		IF (finished = 1)
			THEN 
            LEAVE coach_loop;
		END IF;
        SELECT tempName, tempEgn;
	END WHILE;
	CLOSE coachCursor;
    SET finished = 0;
    SELECT 'Finished!';
END;
| DELIMITER ;

CALL CursorTest();

DROP TABLE IF EXISTS salarypayments_log;
CREATE TABLE salarypayments_log (
	id INT AUTO_INCREMENT PRIMARY KEY,
    operation ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_coach_id INT,
    new_coach_id INT,
    old_month INT,
    new_month INT,
    old_year INT,
    new_year INT,
    old_salaryAmount DECIMAL,
    new_salaryAmount DECIMAL,
    old_dateOfPayment DATETIME,
    new_dateOfPayment DATETIME,
    dateOfLog DATETIME
);

DROP TRIGGER IF EXISTS after_salarypayment_update;
DELIMITER |
CREATE TRIGGER after_salarypayment_update AFTER UPDATE ON salarypayments
FOR EACH ROW
BEGIN 
INSERT INTO salarypayments_log (
	operation,
    old_coach_id,
    new_coach_id,
    old_month,
    new_month,
    old_year,
    new_year,
    old_salaryAmount,
    new_salaryAmount,
    old_dateOfPayment,
    new_dateOfPayment,
    dateOfLog 
)
VALUES 
('UPDATE', OLD.coach_id, NEW.coach_id, OLD.month, NEW.month, OLD.year, NEW.year, 
OLD.salaryAmount, NEW.salaryAmount, OLD.dateOfPayment, NEW.dateOfPayment, NOW());
END;
| DELIMITER ;

UPDATE salarypayments SET salaryAmount = 5000 WHERE id = 9;
SELECT * FROM salarypayments_log;

DELIMITER |
CREATE TRIGGER before_salary_update_to_zero BEFORE UPDATE ON salaryPayments
FOR EACH ROW
BEGIN
    IF NEW.salaryAmount < 0 THEN
        INSERT INTO salarypayments_log (
          operation,
          old_coach_id,
          new_coach_id,
          old_month,
          new_month,
          old_year,
          new_year,
          old_salaryAmount,
          new_salaryAmount,
          old_dateOfPayment,
          new_dateOfPayment,
          dateOfLog
        )
        VALUES (
          'UPDATE',
          OLD.coach_id,
          NEW.coach_id,
          OLD.month,
          NEW.month,
          OLD.year,
          NEW.year,
          OLD.salaryAmount,
          NEW.salaryAmount,
          OLD.dateOfPayment,
          NEW.dateOfPayment,
          NOW()
        );
        SET NEW.salaryAmount = 0;
    END IF;
END;
|
DELIMITER ;

UPDATE salaryPayments SET salaryAmount=-5000 WHERE id = 9;
 
SELECT * FROM salaryPayments;



DROP TRIGGER before_salary_update;
DELIMITER 
|
CREATE TRIGGER before_salary_update
BEFORE UPDATE ON salaryPayments
FOR EACH ROW
BEGIN
    IF NEW.salaryAmount < 0 THEN
		SET NEW.salaryAmount = OLD.salaryAmount;
        INSERT INTO salarypayments_log (old_coach_id, new_coach_id, old_month, new_month, old_salaryAmount, new_salaryAmount, old_dateOfPayment, new_dateOfPayment, dateAttempted)
        VALUES ('UPDATE', OLD.coach_id, NEW.coach_id, OLD.month, NEW.month, OLD.year, NEW.year, 
				OLD.salaryAmount, NEW.salaryAmount, OLD.dateOfPayment, NEW.dateOfPayment, NOW());
    END IF;
END;
|
DELIMITER ;
 
UPDATE salaryPayments
SET salaryAmount = -4000
WHERE coach_id = 6;
 
SELECT * FROM salarypayments_log;