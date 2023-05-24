CREATE DATABASE IF NOT EXISTS dz_5;

USE dz_5;

DROP TABLE cars;
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE OR REPLACE VIEW result AS 
SELECT	*
FROM cars
WHERE cost < 25000;

SELECT * FROM result;

--  Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

CREATE OR REPLACE VIEW result AS 
SELECT	*
FROM cars
WHERE cost < 30000;

SELECT * FROM result;

--  Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE OR REPLACE VIEW result1 AS 
SELECT	*
FROM cars
WHERE name IN ('Skoda', 'Audi');

SELECT * FROM result1;

-- На окошки:
-- Агрегация
-- Вывести всех сотрудников по должностям , исключив "Начальника" и "Уборщика"
-- общую ЗП по долж-ти(1)
-- проц. соотношение отдельно взятой ЗП к суммарной(2)
-- среднюю ЗП (3)
-- проц. соотношение отдельно взятой ЗП к средней (4)

USE lesson3;
SELECT * FROM staff;

SELECT
	salary, post, lastname,firstname,
	SUM(salary) OVER w AS sum_post,-- w = (PARTITION BY post)
	salary * 100 / SUM(salary) OVER w AS percent_sum,
	AVG(salary) OVER w AS avg_post,
	salary * 100 / AVG(salary) OVER w AS percent_avg
FROM staff
WHERE post NOT IN ('Начальник', 'Уборщик')
WINDOW w AS (PARTITION BY post);