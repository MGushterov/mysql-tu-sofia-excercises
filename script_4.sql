ALTER TABLE sportgroups
DROP FOREIGN KEY sportgroups_ibfk_2;

ALTER TABLE sportgroups
ADD CONSTRAINT FOREIGN KEY coach_id_key (coach_id)
REFERENCES coaches(id)
ON DELETE SET NULL ON UPDATE CASCADE;

DELETE
FROM coaches
WHERE id = 3;

DELETE FROM sportgr_student
WHERE sportgr_id = 2
  AND student_id IN (
    SELECT student_id FROM (
       SELECT student_id FROM sportgr_student WHERE sportgr_id = 1
    ) AS temp
  );

UPDATE sportgr_student
SET sportgr_id = 1
WHERE sportgr_id = 2;


UPDATE taxesPayment
SET group_id = 1
WHERE group_id = 2;


DELETE FROM sportGroups
WHERE id = 2;


CREATE TABLE customer (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(20)
);

CREATE TABLE customer_accounts (
	id INT AUTO_INCREMENT PRIMARY KEY,
    amount DOUBLE NOT NULL,
    currency VARCHAR(20),
    customer_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO customer (name, address)
VALUES
('Ivan', 'Sofia'),
('Ana', 'Plovdiv'),
('Radost', 'Sofia'),
('Ivo', 'Stara Zagora');

INSERT INTO customer_accounts (amount, currency, customer_id)
VALUES
(4900, 'bgn', 1),
(1450000, 'eur', 1),
(10850, 'bgn', 2),
(17850, 'eur', 3);

BEGIN;

UPDATE accounts
SET amount = amount -50
WHERE id = 1;

UPDATE account
SET amount = amount + 50
WHERE id = 2;

COMMIT;