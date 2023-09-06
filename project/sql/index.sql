-- Table author --
-- В таблице author, по столбцу author_nm, т.к. в основном нам удобнее искать информацию по имени автора --
CREATE INDEX ON author(author_nm);

-- Table book --
-- В таблице book, по столбцу publishing_dt, т.к. самая комплексная фильтрация будет по дате, остальное просто индексы --
CREATE INDEX ON book(publishing_dt);

-- Table deliverman --
-- В таблице deliverman, по столбцу id. Единственный информативный столбец по которому можно делать поиск. --
CREATE INDEX ON deliverman(id);

-- Table genre --
-- В таблице genre, по столбцу genre_nm, т.к. по имени намного удобнее делать фильтрацию чем по id. --
CREATE INDEX ON genre(genre_nm);

-- Table product --
-- В таблице product, по столбцам shop_id, book_id, т.к. чаще всего фильтрация будет по магазинам или книгам. --
CREATE INDEX ON product(shop_id, book_id);

-- Table publisher --
-- В таблице publisher, по столбцу id, т.к. во всех запросах будет отсеивание по id. --
CREATE INDEX ON publisher(id);

-- Table shop --
-- В таблице shop, по столбцу id, т.к. для фильтрации опять таки будет использоваться id магазина. --
CREATE INDEX ON shop(id);

-- Table supply --
-- В таблице supply, по столбцу deliverman_id, чаще всего будет интересно какие поставки были от какого доставщика. --
CREATE INDEX ON supply(deliverman_id);

-- Table supply_content --
-- В таблице supply_content, по столбцам supply_id и product_id, других стольцов нет, а делать по одному из них не имеет смысла т.к. столбцы равнозначны --
CREATE INDEX ON supply_content(supply_id, product_id) ;

-- Table work --
-- В таблице work, по столбцам author_id и genre_id, т.к. нас интересуют работы от каких то авторов или каких-то жанров. --
CREATE INDEX ON work(author_id, genre_id);