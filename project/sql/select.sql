-- SELECT 1 --
--Должен вернуть название всех книг(book) жанра "Роман", выпущенные до 2000 года--
SELECT work_nm
FROM work
INNER JOIN book ON work.id = book.work_id
WHERE book.publishing_dt < '2000-01-01' and genre_id = (
    SELECT id
    FROM genre
    WHERE genre_nm = 'Роман'
);


-- SELECT 2 --
-- Должен вернуть названия всех произведений информация о которых отсутствует в supply_content --
SELECT work_nm
FROM work
WHERE id NOT IN (
    SELECT work_id
    FROM product
    INNER JOIN book ON product.book_id = book.id
    WHERE product.id IN (
        SELECT product_id
        FROM supply_content
    )
);


-- SELECT 3 --
-- Должен посчитать количество произведений каждого жанра и вывести их в порядке увелчения номера жанра. --
SELECT DISTINCT genre_id, COUNT(1) OVER (PARTITION BY genre_id)
FROM work
ORDER BY genre_id;


-- SELECT 4 --
-- Должен вернуть сумаруню цену всез книг в каждом магазине. --
SELECT shop.id, shop_address, SUM(instance_cnt * price_amt)
FROM shop, product
WHERE shop.id = product.shop_id
GROUP BY shop.id
ORDER BY shop.id;


-- SELECT 5 --
-- Должен вернуть самых популярных доставщиков(самое большое количество поставок) --
SELECT deliverman_id
FROM (
    SELECT DISTINCT deliverman_id, COUNT(1) OVER (PARTITION BY deliverman_id) as cnt
    FROM supply
) as tmp
WHERE cnt = (
    SELECT MAX(cnt)
    FROM (
        SELECT DISTINCT deliverman_id, COUNT(1) OVER (PARTITION BY deliverman_id) as cnt
        FROM supply
    ) as tmp
);


-- SELECT 6 --
-- Должен вернуть самых широко предстваленных авторов --
SELECT author_nm
FROM author
WHERE id IN (
    SELECT author_id
    FROM (
        SELECT author_id, COUNT(1) as cnt
        FROM work
        GROUP BY author_id
        ORDER BY cnt DESC
        FETCH FIRST 5 ROWS ONLY
    ) as tmp
);
