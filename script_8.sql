DROP DATABASE IF EXISTS `2024_TU_Lab1`;
CREATE DATABASE `2024_TU_Lab1`;
USE `2024_TU_Lab1`;

CREATE TABLE publisher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(20) NOT NULL
);

CREATE TABLE book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ISBN CHAR(13) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    price DECIMAL(10,0) NOT NULL DEFAULT 0,
    category VARCHAR(20) NOT NULL,
    publisher_id INT NOT NULL
);

CREATE TABLE reader (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(320) NOT NULL UNIQUE,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    sex ENUM('male','female','other') NOT NULL,
    phone_no VARCHAR(100)
);

CREATE TABLE staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE account (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(320) UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE book_reader (
    book_id INT NOT NULL,
    reader_id INT NOT NULL,
    date_taken DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_returned DATETIME,
    PRIMARY KEY (book_id, reader_id),
    CONSTRAINT fk_br_book FOREIGN KEY (book_id) REFERENCES book(id),
    CONSTRAINT fk_br_reader FOREIGN KEY (reader_id) REFERENCES reader(id)
);

-- Establish all remaining foreign keys and additional columns
ALTER TABLE book
    ADD COLUMN maintained_by INT,
    ADD CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher(id),
    ADD CONSTRAINT fk_book_staff    FOREIGN KEY (maintained_by) REFERENCES staff(id);

ALTER TABLE reader
    ADD COLUMN account_id INT UNIQUE,
    ADD COLUMN staff_id   INT,
    ADD CONSTRAINT fk_reader_account FOREIGN KEY (account_id) REFERENCES account(id),
    ADD CONSTRAINT fk_reader_staff   FOREIGN KEY (staff_id)   REFERENCES staff(id);

ALTER TABLE staff
    ADD COLUMN account_id INT UNIQUE,
    ADD CONSTRAINT fk_staff_account FOREIGN KEY (account_id) REFERENCES account(id);

CREATE TABLE author (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE
);

ALTER TABLE book
    ADD COLUMN author_id INT,
    ADD CONSTRAINT fk_book_author FOREIGN KEY (author_id) REFERENCES author(id);

-- Populate publishers
INSERT INTO publisher (name, country) VALUES
 ('Penguin Random House', 'USA'),
 ('HarperCollins',          'USA'),
 ('Hachette Livre',         'France'),
 ('Springer Nature',        'Germany'),
 ('Macmillan Publishers',   'UK'),
 ('Simon & Schuster',       'USA'),
 ('Pearson',                'UK'),
 ('Wiley',                  'USA'),
 ('Oxford University Press','UK'),
 ('Random House',           'USA'),
 ('Scholastic',             'USA'),
 ('Cambridge University Press','UK'),
 ('Elsevier',               'Netherlands'),
 ('Bloomsbury Publishing',  'UK'),
 ('McGraw-Hill Education',  'USA'),
 ('Cengage Learning',       'USA'),
 ('Penguin Books',          'UK'),
 ('Houghton Mifflin Harcourt','USA'),
 ('Taylor & Francis',       'UK'),
 ('John Wiley & Sons',      'USA');

-- Populate accounts
INSERT INTO account (username, password) VALUES
 ('john_doe',       'JD@2024'),
 ('jane_smith',     'JS@1234'),
 ('mike_jones',     'MJpass987'),
 ('sara_williams',  'SW@password'),
 ('chris_brown',    'CBpass@123'),
 ('emily_jackson',  'EJ!pass'),
 ('david_clark',    'DCpass#789'),
 ('amy_taylor',     'AT@2024'),
 ('kevin_white',    'KWpass123!'),
 ('lisa_johnson',   'LJpass5678'),
 ('steve_miller',   'SM@pass2024'),
 ('rachel_green',   'RG!pass123'),
 ('alex_thompson',  'AT123@pass'),
 ('olivia_harris',  'OH@9876pass'),
 ('brandon_lee',    'BLpass#2024'),
 ('natalie_baker',  'NBpass!4321'),
 ('adam_robinson',  'ARpass@2024'),
 ('jennifer_davis', 'JDpass#2024'),
 ('ryan_moore',     'RM@pass123'),
 ('sophia_martin',  'SMpass@987');

-- Populate staff (must reference account IDs already inserted)
INSERT INTO staff (name, account_id) VALUES
 ('John Admin',        1),
 ('Jane Admin',        2),
 ('Michael Manager',   3),
 ('Samantha Smith',    4),
 ('David Johnson',     5),
 ('Emily Brown',       6),
 ('Robert Davis',      7),
 ('Jessica Wilson',    8),
 ('Christopher Taylor',9),
 ('Ashley Martinez',  10),
 ('Daniel Anderson',  11),
 ('Jennifer Thomas',  12),
 ('Matthew Lee',      13),
 ('Amanda Harris',    14),
 ('Kevin White',      15),
 ('Laura Garcia',     16),
 ('James Martinez',   17),
 ('Michelle Robinson',18),
 ('Brian Clark',      19),
 ('Stephanie Lewis',  20);

-- Populate authors
INSERT INTO author (name) VALUES
 ('John Smith'),
 ('Jane Doe'),
 ('Michael Johnson'),
 ('Sarah Williams'),
 ('Chris Brown'),
 ('Emily Wilson'),
 ('David Clark'),
 ('Amy Taylor'),
 ('Kevin White'),
 ('Lisa Johnson'),
 ('Steven Miller'),
 ('Rachel Green'),
 ('Alex Thompson'),
 ('Olivia Harris'),
 ('Brandon Lee'),
 ('Natalie Baker'),
 ('Adam Robinson'),
 ('Jennifer Davis'),
 ('Ryan Moore'),
 ('Sophia Martin');

-- Populate books (note escaping of Sorcerer's)
INSERT INTO book (ISBN, title, price, category, publisher_id, maintained_by, author_id) VALUES
 ('9780547928227', 'Harry Potter and the Sorcerer''s Stone',    20, 'Fiction',    1, 1, 1),
 ('9780439064866', 'Harry Potter and the Chamber of Secrets',   22, 'Fiction',    2, 2, 1),
 ('9780439136365', 'Harry Potter and the Prisoner of Azkaban',  25, 'Fiction',    3, 3, 1),
 ('9780439139601', 'Harry Potter and the Goblet of Fire',       30, 'Fiction',    4, 4, 1),
 ('9780439358071', 'Harry Potter and the Order of the Phoenix', 28, 'Fiction',    5, 5, 1),
 ('9780439784542', 'Harry Potter and the Half-Blood Prince',    27, 'Fiction',    6, 6, 1),
 ('9780545010221', 'Harry Potter and the Deathly Hallows',      32, 'Fiction',    7, 7, 1),
 ('9780312676849', 'The Hunger Games',                         18, 'Young Adult',8, 8, 2),
 ('9780439023481', 'Twilight',                                15, 'Young Adult',9, 9, 2),
 ('9780375831003', 'Eragon',                                  20, 'Fantasy',   10,10, 2),
 ('9780141439600', 'Pride and Prejudice',                     12, 'Classic',    1, 1, 3),
 ('9780140620590', 'To Kill a Mockingbird',                  13, 'Classic',    2, 2, 3),
 ('9780743273565', 'The Da Vinci Code',                      16, 'Mystery',    3, 3, 4),
 ('9780385514231', 'The Girl with the Dragon Tattoo',        18, 'Mystery',    4, 4, NULL),
 ('9780385537858', 'Inferno',                                19, 'Mystery',    5, 5, NULL),
 ('9780547577319', 'The Hobbit',                             22, 'Fantasy',    6, 6, NULL),
 ('9780553283686', 'A Game of Thrones',                      25, 'Fantasy',    7, 7, NULL),
 ('9780345337664', 'The Fellowship of the Ring',             21, 'Fantasy',    8, 8, NULL),
 ('9780345339705', 'The Two Towers',                         20, 'Fantasy',    9, 9, NULL),
 ('9780345342965', 'The Return of the King',                 23, 'Fantasy',   10,10, NULL);

-- Populate readers
INSERT INTO reader (email, first_name, last_name, address, sex, phone_no, account_id, staff_id) VALUES
 ('john.doe@example.com',    'John',     'Doe',      '123 Main St, Anytown, USA',    'male',   '123-456-7890',  1,  1),
 ('jane.smith@example.com',  'Jane',     'Smith',    '456 Elm St, Othertown, USA',   'female', '987-654-3210',  2,  2),
 ('mike.jones@example.com',  'Mike',     'Jones',    '789 Oak St, Another Town, USA','male',   '555-123-4567',  3,  3),
 ('sarah.williams@example.com','Sarah',   'Williams', '321 Maple St, Somewhere, USA', 'female', '777-888-9999',  4,  4),
 ('chris.brown@example.com', 'Chris',    'Brown',    '654 Pine St, Anywhere, USA',   'male',   '444-555-6666',  5,  5),
 ('emily.wilson@example.com','Emily',    'Wilson',   '987 Cedar St, Nowhere, USA',   'female', '222-333-4444',  6,  6),
 ('david.clark@example.com', 'David',    'Clark',    '456 Birch St, Elsewhere, USA', 'male',   '111-222-3333',  7,  7),
 ('amy.taylor@example.com',  'Amy',      'Taylor',   '789 Spruce St, Here, USA',     'female', '999-888-7777',  8,  8),
 ('kevin.white@example.com','Kevin',    'White',    '147 Oakwood Dr, Anytown, USA','male',   '777-666-5555',  9,  9),
 ('lisa.johnson@example.com','Lisa',     'Johnson',  '258 Maplewood Dr, Anywhere, USA','female','333-222-1111',10, 10),
 ('steven.miller@example.com','Steven',  'Miller',   '369 Elmwood Dr, Anywhere, USA','male',  '111-222-3333', 11,  1),
 ('rachel.green@example.com','Rachel',   'Green',    '987 Birchwood Dr, Anywhere, USA','female','444-555-6666',12,  2),
 ('alex.thompson@example.com','Alex',    'Thompson', '741 Pinebrook Dr, Anywhere, USA','male', '777-888-9999',13,  3),
 ('olivia.harris@example.com','Olivia',  'Harris',   '852 Maplehurst Dr, Anywhere, USA','female','333-444-5555',14,  4),
 ('brandon.lee@example.com','Brandon',  'Lee',      '963 Cedarhurst Dr, Anywhere, USA','male', '999-888-7777',15,  5),
 ('natalie.baker@example.com','Natalie', 'Baker',    '147 Birchhill Dr, Anywhere, USA','female','666-555-4444',16,  6),
 ('adam.robinson@example.com','Adam',    'Robinson', '258 Elmwood Dr, Anywhere, USA','male',  '222-333-4444',17,  7),
 ('jennifer.davis@example.com','Jennifer','Davis',    '369 Maplewood Dr, Anywhere, USA','female','555-666-7777',18,  8),
 ('ryan.moore@example.com','Ryan',      'Moore',    '741 Oakwood Dr, Anywhere, USA','male',   '888-999-0000',19,  9),
 ('sophia.martin@example.com','Sophia', 'Martin',   '852 Pinebrook Dr, Anywhere, USA','female','111-222-3333',20, 10);

-- Populate borrow records
INSERT INTO book_reader (book_id, reader_id, date_taken, date_returned) VALUES
 (1,  1, '2023-01-05', '2023-01-15'),
 (2,  2, '2023-02-10', NULL),
 (3,  3, '2023-03-20', '2023-03-30'),
 (4,  4, '2023-04-25', NULL),
 (5,  5, '2023-05-03', '2023-05-13'),
 (6,  6, '2023-06-15', NULL),
 (7,  7, '2023-07-20', '2023-07-30'),
 (8,  8, '2023-08-08', NULL),
 (9,  9, '2023-09-12', '2023-09-22'),
 (10, 10, '2023-10-30', NULL),
 (1,  2, '2023-01-10', '2023-01-20'),
 (2,  3, '2023-02-15', NULL),
 (3,  4, '2023-03-25', '2023-04-05'),
 (4,  5, '2023-04-10', NULL),
 (5,  6, '2023-05-20', '2023-05-30'),
 (6,  7, '2023-06-01', NULL),
 (7,  8, '2023-07-05', '2023-07-15'),
 (8,  9, '2023-08-18', NULL),
 (9,  10,'2023-09-22', '2023-10-02'),
 (10, 1, '2023-10-05', NULL);
 
 
-- NESTED SELECT
SELECT
  (SELECT r.email 
   FROM reader r 
   WHERE r.id = br.reader_id
  ) AS reader_email,
  
  (SELECT COUNT(*) 
   FROM book_reader br2 
   WHERE br2.reader_id = br.reader_id
  ) AS books_taken_count,
  
  (SELECT b.title 
   FROM book b 
   WHERE b.id = br.book_id
  ) AS book_title

FROM book_reader br
WHERE br.reader_id IN (
  SELECT id 
  FROM reader 
  WHERE email LIKE '%@example.com'
);


-- JOIN
ALTER TABLE publisher
	ADD COLUMN parent_id INT NULL,
	ADD CONSTRAINT fk_publisher_parent
	FOREIGN KEY (parent_id) REFERENCES publisher(id);
    
INSERT INTO publisher (name, country, parent_id) VALUES
  ('Penguin Classics',         'UK',  1),   
  ('Vintage Classics',         'UK',  1),
  ('HarperCollins Imprints',   'USA', 2),   
  ('Springer Press Berlin',    'Germany', 4), 
  ('Scholastic Kids',          'USA', 11),  
  ('Oxford Academic',          'UK', 9),    
  ('Cambridge English',        'UK', 12),   
  ('Elsevier Science',         'Netherlands', 13);
    
SELECT
  p_parent.id,
  p_parent.name,
  p_parent.country,
  COUNT(p_child.id) AS num_children
FROM publisher AS p_parent
LEFT JOIN publisher AS p_child
  ON p_child.parent_id = p_parent.id
GROUP BY
  p_parent.id,
  p_parent.name,
  p_parent.country
HAVING
  COUNT(p_child.id) > 0;

-- Cursor

DROP PROCEDURE IF EXISTS add_new_book;
DELIMITER |
CREATE PROCEDURE add_new_book(
    IN book_isbn              CHAR(13),
    IN book_title             VARCHAR(100),
    IN book_price             DECIMAL(10,0),
    IN book_category          VARCHAR(20),
    IN book_publisher_name    VARCHAR(100),
    IN book_publisher_country VARCHAR(20),
    IN book_author_name       VARCHAR(100)
)
add_book: BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE virtual_publisher_id INT DEFAULT NULL;
    DECLARE virtual_author_id INT DEFAULT NULL;
    DECLARE virtual_isbn CHAR(13);
    
    DECLARE cur_check_book CURSOR FOR
        SELECT ISBN FROM book WHERE ISBN = book_isbn;
    DECLARE cur_pub CURSOR FOR
        SELECT id FROM publisher WHERE name = book_publisher_name;
    DECLARE cur_auth CURSOR FOR
        SELECT id FROM author WHERE name = book_author_name;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    SET done = 0;
    OPEN cur_check_book;
      FETCH cur_check_book INTO virtual_isbn;
    CLOSE cur_check_book;
    IF done = 0 THEN
        SELECT 'Грешка: Книга с този ISBN вече съществува.' AS message;
        LEAVE add_book;
    END IF;

    SET done = 0;
    OPEN cur_pub;
      FETCH cur_pub INTO virtual_publisher_id;
    CLOSE cur_pub;
    IF done = 1 THEN
        INSERT INTO publisher(name, country)
        VALUES(book_publisher_name, book_publisher_country);
        SET virtual_publisher_id = LAST_INSERT_ID();
    END IF;

    SET done = 0;
    OPEN cur_auth;
      FETCH cur_auth INTO virtual_author_id;
    CLOSE cur_auth;
    IF done = 1 THEN
        INSERT INTO author(name)
        VALUES(book_author_name);
        SET virtual_author_id = LAST_INSERT_ID();
    END IF;

    INSERT INTO book(
        ISBN, title, price, category, publisher_id, author_id
    ) VALUES(
        book_isbn, book_title, book_price, book_category, virtual_publisher_id, virtual_author_id
    );

    SELECT CONCAT('Успешно добавена книга: ', book_title) AS message;
END add_book|
DELIMITER ;
CALL add_new_book(
  '1234567890124',
  'Книга-Тест-1',
  15,
  'Тест-1',
  'Publisher',
  'Bulgaria',
  'Ivan Stoyanov'
);	

CALL add_new_book(
  '9999999999999',
  'Уникален Тест',
  20,
  'Тест',
  'TestPub',
  'Bulgaria',
  'Ivan Ivanov'
);

CALL add_new_book(
  '9999999999999',
  'Уникален Тест Повторно',
  20,
  'Тест',
  'TestPub',
  'Bulgaria',
  'Ivan Ivanov'
);