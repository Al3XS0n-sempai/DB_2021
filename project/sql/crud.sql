-- CRUD 1 --
INSERT INTO author VALUES (21, 'Гуголь', 'Россия');
SELECT * FROM author;
UPDATE author
SET author_nm = 'Гоголь'
WHERE id = 21;
DELETE FROM author WHERE author_nm = 'Гоголь';


-- CRUD 2 --
INSERT INTO work VALUES (53, 10, 0, 'Неизданное из неизданного');
SELECT * FROM work;
UPDATE work
SET work_nm = 'Уже изданно'
WHERE id = 53;
DELETE FROM work WHERE id = 53;


-- CRUD 3 --
INSERT INTO book VALUES (53, 16, 9, 4, '2062-01-01');
SELECT * FROM book;
UPDATE book
SET publishing_dt = CURRENT_DATE
WHERE id = 53;
DELETE FROM book WHERE id = 53;


-- CRUD 4 --
INSERT INTO deliverman VALUES (12, 'Тяп ляп', 'Книжная, 17б');
SELECT * FROM deliverman;
UPDATE deliverman
SET service_address = '--'
WHERE id = 12;
DELETE FROM deliverman WHERE id = 12;


-- CRUD 5 --
INSERT INTO genre VALUES (9, 'Небылица', 'Выдуманная, не правдоподобная история');
SELECT * FROM genre;
UPDATE genre
SET genre_nm = 'Выдумка'
WHERE id = 9;
DELETE FROM genre WHERE id = 9;


-- CRUD 6 --
INSERT INTO product VALUES (9999, 1, 4, 50, 999.99);
SELECT * FROM product;
UPDATE product
SET instance_cnt = 2
WHERE id = 9999;
DELETE FROM product WHERE id = 9999;


-- CRUD 7 --
INSERT INTO publisher VALUES (11, 'Становник', NULL);
SELECT * FROM publisher;
UPDATE publisher
SET publisher_url = 'stanovnik.ru'
WHERE id = 11;
DELETE FROM publisher WHERE id = 11;


-- CRUD 8 --
INSERT INTO shop VALUES (7, 'Магазинная, 71', '10:00:01', '15:05:05', NULL);
SELECT * FROM shop;
UPDATE shop
SET shop_url = 'supershop.com'
WHERE id = 7;
DELETE FROM shop WHERE shop_url = 'supershop.com';
