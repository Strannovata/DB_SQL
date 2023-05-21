DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;
DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher
(	
	id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    
SELECT * from teacher; 
DROP TABLE IF EXISTS lesson;
CREATE TABLE lesson
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(id)
);
INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1),
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4),
    ("Нейронные сети", NULL); -- Учитель, который ведет данный предмет, временно отстутствует
  
-- Получим информацию об учителях, которые ведут уроки  
SELECT
	t.surname,
	t.id,
	l.teacher_id, -- Если внешний ключ l.teacher_id = первичоному ключу t.id,
	l.course -- то учитель ведет какой - то урок: "Авдеев" ведет "Знакомство с веб-технологиями"
FROM teacher t -- teacher = t, левая таблица
JOIN lesson l -- lesson = l
ON l.teacher_id = t.id;

-- Получим информацию обо всех преподавателях, даже если они не ведут уроки
SELECT
t.surname,
t.id,
l.teacher_id, -- Если внешний ключ l.teacher_id = первичоному ключу t.id,
l.course -- то учитель ведет какой - то урок: "Авдеев" ведет "Знакомство с веб-технологиями"
FROM teacher t -- Левая таблица указана во FROM-e
LEFT JOIN lesson l -- lesson = l, правая таблица в JOIN-е
ON l.teacher_id = t.id;

-- Получим информацию об учителях, которые не ведут уроки
SELECT
t.surname,
t.id,
l.teacher_id, -- Если внешний ключ l.teacher_id = первичоному ключу t.id,
l.course -- то учитель ведет какой - то урок: "Авдеев" ведет "Знакомство с веб-технологиями"
FROM teacher t -- Левая таблица указана во FROM-e
LEFT JOIN lesson l -- lesson = l, правая таблица в JOIN-е
ON l.teacher_id = t.id
WHERE l.teacher_id IS NULL; -- l.teacher_id = NULL

-- Получить информацию об учителях, которые ведут "Знакомство с веб-технологиями"
SELECT
t.surname,
t.id,
web_lesson.teacher_id, -- Если внешний ключ l.teacher_id = первичоному ключу t.id,
web_lesson.course -- то учитель ведет какой - то урок: "Авдеев" ведет "Знакомство с веб-технологиями"
FROM teacher t -- teacher = t, левая таблица
JOIN (SELECT course,teacher_id
FROM lesson WHERE course = "Знакомство с веб-технологиями") web_lesson
ON web_lesson.teacher_id = t.id;

-- CROSS JOIN
SELECT
t.*, -- получение всех данных из таблицы t= teacher
l.* -- получение всех данных из таблицы l = lesson
FROM teacher t
CROSS JOIN lesson l;

-- Получить информацию об учителях, которые ведут "Знакомство с веб-технологиями" и "Знакомство с языками программирования"
SELECT
t.surname,
t.id,
l.teacher_id,
l.course
FROM teacher t
JOIN lesson l
ON l.teacher_id = t.id
WHERE l.course IN ("Знакомство с веб-технологиями", "Знакомство с языками программирования");