-- 1. Создание БД
CREATE DATABASE IF NOT EXISTS lesson3; -- Создаем БД, если она не существует

-- 2. Подключение к БД 
USE lesson3;

-- 3. Наполнение: таблица 
DROP TABLE IF EXISTS staff; -- Удалит таблицу, если она существует
CREATE TABLE staff -- Создадим таблицу с чистой совестью - она уже была удалена
(
	id INT PRIMARY KEY AUTO_INCREMENT, -- id = 1, id++ - инкремент (id = id + 1)
    firstname VARCHAR(45), 
	lastname VARCHAR(45),
    post VARCHAR(45),
    seniority INT, 
    salary DECIMAL(8,2), -- 8 знаков всего и 2 знака в дробной части
    -- 8 - 2 = 6 знаков в целой части: от -999 999 до 999 999
    age INT
);

-- 4. Заполнение таблицы данными
INSERT staff(firstname, lastname, post, seniority,salary,age)
VALUES ("Петр", "Петров", "Начальник", 8, 70000, 30); -- id = 1
INSERT staff (firstname, lastname, post, seniority, salary, age)
VALUES
  ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
  ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
  ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
  ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
  ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
  ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
  ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
  ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
  ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
  ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
  ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
  ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
SELECT *
FROM staff;
-- ЗП: от самой большой к самой маленькой
-- ORDER BY (сортировка) - по воз - ю, по уб - ю
SELECT firstname, lastname, salary -- Фам, имя и зп
FROM staff 
ORDER BY salary DESC; -- Исходное значение(ASC) - по в-ю, DESC - по убыванию

-- Сортировка по именам и фамилиям в алф. порядке по убыванию (Я -> A)
SELECT lastname, firstname, salary -- Фам, имя и зп
FROM staff 
ORDER BY lastname DESC, firstname DESC, salary ;

-- Вывод ограниченного количества строк-LIMIT, уникальные - DISTINCT
SELECT DISTINCT lastname
FROM staff 
ORDER BY lastname; -- а -> я,
-- Топ-5 людей с самой высокой ЗП
SELECT firstname, lastname, salary -- Фам, имя и зп
FROM staff 
ORDER BY salary DESC
LIMIT 5;

-- id = 3,4,5
SELECT id, firstname, lastname, salary -- Фам, имя и зп
FROM staff 
LIMIT 2, 3; -- id = 1 , 2 пропустил, вывел следующие 3: id = 3,4,5

-- Группировка GROUP BY + HAVING
-- Для каждой должности вывести:
-- суммарная ЗП по должности
-- количество сотрудников по должности
-- разница между макс и мин ЗП внутри должности 
-- макс и мин ЗП внутри должности
-- средняя ЗП по должности
SELECT 
	post AS "Должности",
    SUM(salary) AS "Суммарная ЗП",
    COUNT(salary) AS "Количество сотрудников по должности",
    MAX(salary) AS "макс ЗП",
    MIN(salary)  AS "мин ЗП",
    MAX(salary) - MIN(salary) AS "разница между макс и мин ЗП внутри должности ",
    AVG(salary) AS "средняя ЗП по должности"
FROM staff
WHERE post != "Уборщик" -- До группирвоки исключаем Уборщиков
GROUP BY post -- только уникальные занимаемые должности;
HAVING AVG(salary) > 30000; -- НА сформированные группы накладывается дополнительный фильтр 
