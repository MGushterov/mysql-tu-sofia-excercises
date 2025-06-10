USE _92b_ksig;
DELIMITER |
CREATE PROCEDURE checkMothTax(IN studId INT, IN groupId INT, IN paymentMonth INT, IN paymentYear INT)
BEGIN
DECLARE result char(1);
SET result = 0;
	IF((SELECT paymentAmount
		FROM taxespayment
        WHERE student_id = studId
        AND group_id = groupId
        AND month = paymentMonth
        AND year = paymentYear) IS NOT NULL)
	THEN
		SET result = 1;
	ELSE 
		SET result = 0;
	END IF;

SELECT result AS IsTaxPaid;
END;
| DELIMITER ;
call checkMothTax(1, 1, 2, 2023);

DELIMITER |
CREATE PROCEDURE getPaymentPeriod(IN studId INT, IN groupId INT, IN paymentYear INT)
BEGIN
	DECLARE countOfMonths INT;
	DECLARE monthStr VARCHAR(10);
	DECLARE yearStr VARCHAR(10);
	SET monthStr = 'MONTH';
	SET yearStr = 'YEAR';
    
	SELECT COUNT(*)
    INTO countOfMonths
    FROM taxespayment
    WHERE student_id = studId
    AND group_id = groupId
    AND year = paymentYear;
    
    CASE countOfMonths
		WHEN 0 THEN SELECT 'This student has not paid for this group/year!' AS PAYMENT_PERIOD;
        WHEN 1 THEN SELECT CONCAT('ONE_', monthStr) AS PAYMENT_PERIOD;
        WHEN 3 THEN SELECT CONCAT('THREE_', monthSTR, 'S') AS PAYMENT_PERIOD;
        WHEN 6 THEN SELECT CONCAT('SIX_', monthSTR, 'S') AS PAYMENT_PERIOD;
        WHEN 12 THEN SELECT yearStr AS PAYMENT_PERIOD;
        ELSE
			SELECT CONCAT(countOfMonths, monthStr, 'S') AS PAYMENT_PERIOD;
	END CASE;
END;
| DELIMITER ;
CALL getPaymentPeriod(1, 1, 2023);

DROP PROCEDURE getAllPaymentsAmount;
DELIMITER |
CREATE PROCEDURE getAllPaymentsAmount(IN first_month INT, IN second_month INT, IN payment_year INT, IN stud_id INT) 
BEGIN
	DECLARE iterator INT;
	IF(first_month >= second_month)
    THEN
        SELECT 'Incorrect sequence of months!' as RESULT;
	ELSE IF((SELECT COUNT(*)
            FROM taxespayment
            WHERE student_id = stud_id) = 0)
    THEN SELECT 'Enter correct student id!' as RESULT;
        else
    SET ITERATOR = first_month;
        WHILE(iterator >= first_month AND iterator <= second_month)
        DO
            SELECT student_id, group_id, paymentAmount, month
            FROM taxespayment
            WHERE student_id = stud_id
            AND year = payment_year
            AND month = iterator;
            
            SET iterator = iterator + 1;
        END WHILE;
    END IF;
END IF;
END;
|
DELIMITER ;
 
CALL getAllPaymentsAmount(1, 2, 2023, 1);

DROP PROCEDURE getAllPaymentsAmountNew;
DELIMITER |
CREATE PROCEDURE getAllPaymentsAmountNew(IN first_month INT, IN second_month INT, IN payment_year INT, IN stud_id INT) 
BEGIN
	DECLARE iterator INT;
    CREATE TEMPORARY TABLE tempTbl(student_id int,
        group_id int,
        paymentAmount double,
        month int)
        ENGINE = Memory;
	IF(first_month >= second_month)
    THEN
        SELECT 'Incorrect sequence of months!' as RESULT;
	ELSE IF((SELECT COUNT(*)
            FROM taxespayment
            WHERE student_id = stud_id) = 0)
    THEN SELECT 'Enter correct student id!' as RESULT;
	ELSE
		SET ITERATOR = first_month;
        WHILE(iterator >= first_month AND iterator <= second_month)
        DO
			INSERT INTO tempTbl
            SELECT student_id, group_id, paymentAmount, month
            FROM taxespayment
            WHERE student_id = stud_id
            AND year = payment_year
            AND month = iterator;
            
            SELECT student_id, group_id, paymentAmount, month
            FROM taxespayment
            WHERE student_id = stud_id
            AND year = payment_year
            AND month = iterator;
            
            SET iterator = iterator + 1;
        END WHILE;
    END IF;
    SELECT * FROM tempTbl;
END IF;
DROP TABLE tempTbl;
END;
|
DELIMITER ;

call getAllPaymentsAmountNew(1, 2, 2023, 1);