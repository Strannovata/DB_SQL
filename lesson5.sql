USE lesson3;
SELECT * FROM staff;

-- Ранжирование
-- Выведем список всех сотрудников и укажем место в рейтинге по ЗП (по убыванию)
-- Макс = 1

SELECT
	DENSE_RANK() OVER(ORDER BY salary DESC) AS `rank`,
    salary,
    post
FROM staff;

-- Ранжирование
-- Выведем список всех сотрудников и укажем место в рейтинге по ЗП (по убыванию)
-- Макс = 1, по каждой должности

SELECT
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `rank`,
    salary,
    post,
    lastname,
    firstname
FROM staff;

-- Самые высокооплачиваемые сотрудники

SELECT 
	salary, post, lastname, firstname
FROM (SELECT
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `rank`,
    salary, post, lastname, firstname
FROM staff) AS rank_table
WHERE `rank` = 1
ORDER BY salary; -- ASC по возрастанию

-- Вывести всех сотрудников по должности
-- Общую ЗП по должности (1)
-- % соотношение отдельно взятой ЗП к суммарной (2)
-- Среднюю ЗП (3)
-- % соотношение отдельно взятой ЗП к средней (4)

SELECT
	salary, post, lastname,firstname,
	SUM(salary) OVER w AS sum_post,-- w = (PARTITION BY post)
	salary * 100 / SUM(salary) OVER w AS percent_sum,
	AVG(salary) OVER w AS avg_post,
	salary * 100 / AVG(salary) OVER w AS percent_avg
FROM staff
WINDOW w AS (PARTITION BY post);

-- Представления VIEWS

CREATE OR REPLACE VIEW result AS 
SELECT
	post,
    COUNT(*) AS count_post
FROM staff
GROUP BY post
ORDER BY count_post;

SELECT * FROM result
WHERE post != "Уборщик";
	
