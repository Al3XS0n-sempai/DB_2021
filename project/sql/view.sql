-- VIEW 1 --
-- Представляет собой сводную таблицу по поставкам(id поставки, что поставляли, кому и кто был доставщиком) --
CREATE VIEW supply_info
AS (
    SELECT supply_id, product_id, shop_id, deliverman_id
    FROM (
        SELECT *
        FROM supply_content
        INNER JOIN product p ON p.id = supply_content.product_id
    ) AS tmp
    INNER JOIN supply ON supply_id = supply.id
);


-- VIEW 2 --
-- Статистика по магазинам(количество товара, сумарная стоимость представленного товара) --
CREATE VIEW shop_statistics
AS
(
    SELECT shop.id, SUM(instance_cnt) AS total_product, SUM(instance_cnt * price_amt) AS total_price
    FROM shop
    INNER JOIN product ON shop.id = product.shop_id
    GROUP BY shop.id
    ORDER BY shop.id
);


-- VIEW 3 --
-- Статистика по жанрам (название, сколько экзепляров работ этого жанра)--
CREATE VIEW genre_statistics
AS (
    SELECT genre_id, genre_nm, instance_cnt
    FROM genre
             INNER JOIN (
        SELECT genre_id, SUM(instance_cnt) AS instance_cnt
        FROM work
                 INNER JOIN (
            SELECT work_id, SUM(instance_cnt) AS instance_cnt
            FROM book
                     INNER JOIN product ON book.id = book_id
            GROUP BY work_id
        ) AS tmp ON work.id = tmp.work_id
        GROUP BY genre_id
        ORDER BY genre_id
    ) AS tmp1 ON tmp1.genre_id = genre.id
);

-- VIEW 4 --
/*
    Статистика по издателям(id, название издателя, количество напечатанных экзепляров, суммарная цена всех напечатанных
    экземпляров)
*/
CREATE VIEW publisher_statistics
AS (
    SELECT id, publisher_nm, total_instance, total_price
    FROM publisher
    INNER JOIN (
        SELECT publisher_id, SUM(instance_cnt) AS total_instance, SUM(instance_cnt * price_amt) AS total_price
        FROM book
        INNER JOIN product ON book.id = product.book_id
        GROUP BY publisher_id
    ) AS tmp ON publisher.id = tmp.publisher_id
);


-- VIEW 5 --
/*
    Таблица состаящая из названия произведения и типа цены(дешевая < $400 или дорагая >= $400)
    При этом сама цена не хранится(сокрытие)
 */
CREATE VIEW work_price_tp
AS (
    SELECT work_nm,
       CASE WHEN price_amt::NUMERIC::INT < 400 THEN 'Cheap'
            ELSE 'Expensive'
            END AS price_tp
    FROM product
    INNER JOIN book b on b.id = product.book_id
    INNER JOIN work w on w.id = b.work_id
);


-- VIEW 6 --
/*
    Представляет собой некую сборную информацию об авторе(имя, пример работы, и страна)
    Причем страна может принимать значение либо Россия, либо Зарубежный(такое цензурное сокрытие)
*/
CREATE VIEW author_info
AS
(
    SELECT author_nm,
           work_example,
           CASE
               WHEN country = 'Россия' THEN country
               ELSE 'Зарубежный'
               END AS country
    FROM author
    INNER JOIN (
        SELECT author_id, MIN(work_nm) AS work_example
        FROM work
        GROUP BY author_id
    ) AS tmp ON author.id = tmp.author_id
);