# Однострочный комментa
-- После "--" ставится пробелa
/* 
Стили:
PascalCase: PrintArray;
camelCase: firstValue;
kebab-case: first-variable;
В SQL используем:
snake_case: first_value;
UPPER_SNAKE_CASE: FIRST_VALUE
*/

-- 1. Создание БД
-- IF EXISTS - если существует
-- IF NOT EXISTS - если не существует
CREATE DATABASE IF NOT EXISTS lesson1; -- Создаем БД с именем lesson1, если она до этого не существовала

-- 2. Выбор БД для работы
USE lesson1; -- Подключение к БД  с именем lesson1

-- 3. Создание таблицы с инфо о студентах: почта, номер телефона, имя студента
DROP TABLE IF EXISTS student; -- Удаляете таблицу student если она существует
CREATE TABLE student
(
# имя_столбца тип_данных ограничения
id INT PRIMARY KEY AUTO_INCREMENT, -- первичный ключ, целое число
firstname VARCHAR(45), -- строка с именем студента, длина которой 45 символов
mobile_phone VARCHAR(45),
email VARCHAR(20) -- после последнего столбца запятая не ставится
);

-- 4. Заполнение таблицы данными
-- INSERT [INTO] table (столбец1, столбец2)
-- VALUES (значение1, значение2)
INSERT student (firstname, mobile_phone, email)
VALUES
("Александр", "+7-999-888-77-66", "alex@gmail.com"), -- id = 1
("Артем", "+7-888-888-77-66", "art@gmail.com"), -- id = 2
("Андрей", "+7-898-888-77-66", "andr@gmail.com"), -- id = 3
("Александра", "+7-777-888-77-66", "alexa@gmail.com"), -- id = 4
("Виктор", "+7-999-888-77-66", "vict@gmail.com"), -- id = 5
("Владимир", "+7-000-888-77-66", "vlad@gmail.com"); -- id = 6

-- 5. Посмотрим на наши труды
SELECT * FROM student; -- "*" - "дурной" тон

-- 6. Выбор ограниченного количества столбцов: имена и почтовые адреса студентов
SELECT firstname, mobile_phone
FROM student;

-- 7. Выводим имя и почтовый адрес студента по имени "Артем"
SELECT firstname, mobile_phone
FROM student
WHERE firstname = "Артем"; -- Получаем имя и почту Артема

-- 8. Выводим имя и почтовый адрес студентов, имена которых начинаются с "А"
SELECT firstname, mobile_phone
FROM student
WHERE firstname LIKE "А%";

-- 9. 
SELECT firstname, mobile_phone
FROM student
WHERE firstname LIKE "%р%";

-- 10. Выводим имя и почтовый адрес студентов, исключив Артема
SELECT firstname, mobile_phone
FROM student
WHERE firstname != "Артем";

 