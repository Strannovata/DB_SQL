DROP DATABASE IF EXISTS dz_4;
CREATE DATABASE dz_4;
USE dz_4;

DROP TABLE IF EXISTS shops;

CREATE TABLE `shops` (
	`id` INT,
    `shopname` VARCHAR (100),
    PRIMARY KEY (id)
);
CREATE TABLE `cats` (
	`name` VARCHAR (100),
    `id` INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES `shops` (id)
);

INSERT INTO `shops`
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO `cats`
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);

SELECT * FROM cats
JOIN shops;

-- Используя JOIN-ы, выполните следующие операции:
-- Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)

SELECT 
	cats.name,
    shops.shopname
FROM cats
JOIN shops
ON shops.id = cats.shops_id;

-- Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами: подзапрос и сам JOIN)

SELECT 
	cats.name,
    shops.shopname
FROM cats
JOIN shops
ON shops.id = cats.shops_id
WHERE cats.name IN ('Murzik');

SELECT 
    shops.shopname
FROM shops
JOIN (SELECT shops_id,
		name
		FROM cats 
        WHERE name = 'Murzik') catmur
ON shops.id = catmur.shops_id;

-- Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

SELECT 
	cats.name,
    shops.shopname
FROM cats
JOIN shops
ON shops.id = cats.shops_id
WHERE cats.name NOT IN ('Murzik', 'Zuza');

