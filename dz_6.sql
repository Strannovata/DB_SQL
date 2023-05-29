CREATE DATABASE IF NOT EXISTS dz_6;
USE dz_6;

-- Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней и часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS format_sec;
DELIMITER $$
CREATE FUNCTION format_sec(seconds INT)
RETURNS VARCHAR(45)
DETERMINISTIC
	BEGIN
		DECLARE days, hours, min, sec INT;
        DECLARE result VARCHAR(45);
		SET days = FLOOR(seconds / 86400);
        SET hours = FLOOR(seconds % 86400 / 3600);
        SET min = FLOOR(seconds % 86400 % 3600 / 60);
        SET sec = (seconds % 86400 % 3600 % 60);
        SET result = CONCAT(days, " days ", hours, " hours ", min, " minutes ", sec, " seconds");
	RETURN result;
END $$

-- Вызов функции
SELECT format_sec(145765);


-- Выведите только четные числа от 1 до 10.
-- Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER $$
CREATE PROCEDURE even_numbers(input_number INT)
BEGIN
	DECLARE n INT;
    DECLARE result VARCHAR(45) DEFAULT "";
    
    SET n = input_number;
    REPEAT
		IF n % 2 = 0 THEN
			SET result = CONCAT(result, n, ",");
		END IF;
        SET n = n + 1;
        UNTIL n > 10 -- Условие выхода из цикла
	END REPEAT;
    SET n = n + 1;
    SELECT result;
END$$

-- Вызов процедуры
CALL even_numbers(1);