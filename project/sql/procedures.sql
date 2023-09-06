-- Procedures 1 --
/*
    buy_book(купить книгу)
    Аргументы:
        1) product_id - id продукта
        2) cnt - количество сколько покупаем
    Семантика, если экземпляров product_id хватает для покупки, то покупаем.
    Иначе ничего не делаем.
    Реализация такова, что можно добавлять новые экземпляры в product_id,
    если cnt отрицательный, то есть:
        buy_book(10, -100) = добавить 100 экземпляров книг с product_id = 10
*/
CREATE OR REPLACE PROCEDURE buy_book(
    product_id INT,
    cnt INT
)
LANGUAGE plpgsql
AS $$
    BEGIN
        UPDATE bookstrores.product
        SET instance_cnt = CASE WHEN instance_cnt >= cnt THEN instance_cnt - cnt
                                ELSE instance_cnt
                            END
        WHERE id = product_id;

        COMMIT;
    END;
$$;


-- Procedures 2 --
 /*
    add_new_work(Добавить новое произведение)
    Аргументы:
        1) _work_nm VARCHAR(100) - название
        2) _author_id INT - id автора
        3) _genre_id INT - id жанра
        4) _work_id INT - id нового произведения(по умолчанию -1)
    Семантика, создаем новое произведение в таблице с заданными значениями
    Если _work_id не указан то берется максимальный уже существующий и прибавляется 1
*/
CREATE OR REPLACE PROCEDURE add_new_work(
    _work_nm VARCHAR(100),
    _author_id INT,
    _genre_id INT,
    _work_id INT DEFAULT -1
)
LANGUAGE plpgsql
AS $$
    BEGIN
        IF _work_id <> -1 THEN
            INSERT INTO bookstrores.work VALUES (_work_id, _author_id, _genre_id, _work_nm);
        ELSE
            INSERT INTO bookstrores.work VALUES ((SELECT MAX(id) + 1 FROM bookstrores.work),
                                                 _author_id, _genre_id, _work_nm);
        END IF;
    END;
$$;