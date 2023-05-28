DROP TABLE IF EXISTS bankaccounts;

CREATE TABLE bankaccounts
	(accountno varchar(20) PRIMARY KEY NOT NULL,
    funds decimal(8,2));
    
INSERT INTO bankaccounts VALUES("ACC1", 1000);
INSERT INTO bankaccounts VALUES("ACC2", 1000);

-- Изменим баланс на аккаунтах
/*
START TRANSACTION; -- Начало транзакции
	UPDATE bankaccounts SET funds=funds-500 WHERE accountno='ACC1'; -- 1000 - 500 = 500
	UPDATE bankaccounts SET funds=funds+500 WHERE accountno='ACC2'; -- 1500
COMMIT; -- Сохранение
*/
/*
START TRANSACTION; -- Начало транзакции
	UPDATE bankaccounts SET funds=funds-500 WHERE accountno='ACC1'; -- 1000 - 500 = 500
	UPDATE bankaccounts SET funds=funds+500 WHERE accountno='ACC2'; -- 1500
ROLLBACK; -- Откат, попадание в состояние до транзакции
SELECT * FROM bankaccounts;
*/

START TRANSACTION; -- Начало транзакции
SELECT "Блокировка счета";
SAVEPOINT test;
UPDATE bankaccounts SET funds=funds-500 WHERE accountno='ACC1'; -- 1000 - 500 = 500
UPDATE bankaccounts SET funds=funds+500 WHERE accountno='ACC2'; -- 1500 (НО не сохранится)
ROLLBACK TO SAVEPOINT test; -- Откат, попадаем в состояние до транзакции

SELECT * FROM bankaccounts;
