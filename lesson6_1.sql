USE lesson3;

SELECT * FROM staff;

-- Функция будет принимать 2 параметра:
-- текущая дата, дата рождения человекаalter
SELECT NOW();
DROP FUNCTION IF EXISTS get_age;
CREATE FUNCTION get_age
(
	curr_date DATETIME,
    date_bith DATE
)
RETURNS INT
DETERMINISTIC
RETURN (YEAR(curr_date) - YEAR(date_bith));

-- Вызов функции

SELECT get_age(NOW(),"1983-11-03") AS "Вызов функции для подсчета возраста";

-- Создать процедуру, которая будет печатать все цифры от N до 1
-- n = 5: "5,4,3,2,1"

DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers
(
	input_number INT
)
BEGIN
	DECLARE n INT; -- n = input_number
    DECLARE result VARCHAR(45) DEFAULT "";
    
    SET n = input_number;
    REPEAT
		SET result = CONCAT(result, n, ",");
        SET n = n - 1;
        
        UNTIL n <= 0 -- Условие выхода из цикла
	END REPEAT;
    SELECT result;
END$$

-- Вызов процедуры

CALL print_numbers(7); -- N = 7

