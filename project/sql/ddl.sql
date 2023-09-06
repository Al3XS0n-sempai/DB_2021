DROP TABLE IF EXISTS author CASCADE;
CREATE TABLE author
(
    id INT PRIMARY KEY,
    author_nm VARCHAR(30) NOT NULL,
    country VARCHAR(30)
);

DROP TABLE IF EXISTS genre CASCADE;
CREATE TABLE genre
(
    id INT PRIMARY KEY,
    genre_nm VARCHAR(30) NOT NULL,
    genre_desc TEXT
);

DROP TABLE IF EXISTS work CASCADE;
CREATE TABLE work
(
    id INT PRIMARY KEY,
    author_id INT REFERENCES author (id),
    genre_id INT REFERENCES genre (id),
    work_nm VARCHAR(100)
);

DROP TABLE IF EXISTS publisher CASCADE;
CREATE TABLE publisher
(
    id INT PRIMARY KEY,
    publisher_nm VARCHAR(30) NOT NULL,
    publisher_url VARCHAR(100)
);

DROP TABLE IF EXISTS book CASCADE;
CREATE TABLE book
(
    id INT PRIMARY KEY,
    work_id INT NOT NULL REFERENCES work (id),
    publisher_id INT NOT NULL REFERENCES publisher (id),
    edition SMALLINT NOT NULL,
    publishing_dt DATE NOT NULL
);

DROP TABLE IF EXISTS deliverman CASCADE;
CREATE TABLE deliverman
(
    id INT PRIMARY KEY,
    service_nm VARCHAR(30) NOT NULL,
    service_address VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS shop CASCADE;
CREATE TABLE shop
(
    id INT PRIMARY KEY,
    shop_address VARCHAR(100) NOT NULL,
    opening_tm TIME NOT NULL,
    closing_tm TIME NOT NULL,
    shop_url VARCHAR(100)
);

DROP TABLE IF EXISTS supply CASCADE;
CREATE TABLE supply
(
    id INT PRIMARY KEY,
    deliverman_id INT NOT NULL REFERENCES deliverman (id),
    supply_dt DATE NOT NULL
);

DROP TABLE IF EXISTS product CASCADE;
CREATE TABLE product
(
    id INT PRIMARY KEY,
    shop_id INT NOT NULL REFERENCES shop (id),
    book_id INT NOT NULL REFERENCES book (id),
    instance_cnt INT NOT NULL,
    price_amt MONEY NOT NULL
);

DROP TABLE IF EXISTS supply_content CASCADE;
CREATE TABLE supply_content
(
    supply_id INT REFERENCES supply (id),
    product_id INT REFERENCES product (id),
    PRIMARY KEY(supply_id, product_id)
);