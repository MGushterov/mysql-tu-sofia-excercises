USE _92b_ksig;
DELIMITER |
CREATE PROCEDURE get_all_sport_groups_with_sport()
BEGIN
SELECT sg.location AS location_of_group,
	   sg.dayOfWeek AS training_day,
       sg.hourOfTraining AS training_hour,
       sp.name AS sport_name
FROM sportgroups AS sg
JOIN sports AS sp
ON sg.sport_id = sp.id;
END
| DELIMITER ;
CALL get_all_sport_groups_with_sport;

DELIMITER |
CREATE PROCEDURE proc_in (IN var VARCHAR(255))
BEGIN 
SET @coach_name = var;
END;
| DELIMITER ;

CALL proc_in('Ivan');
SELECT * FROM coaches
WHERE name = @coach_name;

DELIMITER |
CREATE PROCEDURE out_proc(OUT var VARCHAR(255))
BEGIN
SELECT var;
SET VAR = 'Ilian Todorov';
END;
| DELIMITER ;

SET @test_our_param = 'some name';
CALL out_proc(@test_our_param);
SELECT @test_our_param;

DELIMITER |
CREATE PROCEDURE proc_in_out (INOUT var VARCHAR(255))
BEGIN
SELECT var;
SET var = 'Ivan Todorov Petrov';
END;
| DELIMITER ;
SET @test_in_out_var = 'some name';
CALL proc_in_out(@test_in_out_var);
SELECT @test_in_out_var;

DELIMITER |
CREATE PROCEDURE transfer_money(
    INOUT from_id INT,
    INOUT to_id INT,
    INOUT transfer_amount DECIMAL(10,2)
)
BEGIN
    UPDATE customer_accounts
    SET amount = amount - transfer_amount
    WHERE id = from_id;
    
    UPDATE customer_accounts
    SET amount = amount + transfer_amount
    WHERE id = to_id;
END;
| DELIMITER ;
SET @src_id = 9;
SET @dest_id = 11;
SET @amt = 50.00;

CALL transfer_money(@src_id, @dest_id, @amt);
SELECT * FROM customer_accounts;
