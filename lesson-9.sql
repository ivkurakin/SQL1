-- ТРАНЗАКЦИИ, ПЕРЕМЕННЫЕ, ПРЕДСТАВЛЕНИЯ
-- ЗАДАНИЕ 1 В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
START TRANSACTION;
INSERT INTO sample.users (id, name) SELECT id, name FROM shop.users  WHERE id = 1;
DELETE FROM shop.users  WHERE id = 1;
COMMIT;

-- ЗАДАНИЕ2 Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.
CREATE OR REPLACE VIEW cat_prod AS
SELECT p.name AS name1,  c.name AS name2 FROM products AS p join catalogs AS c
ON p.catalog_id = c.id;
SELECT * FROM cat_prod;

-- ЗАДАНИЕ3 (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые
-- календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
-- если дата присутствует в исходном таблице и 0, если она отсутствует.
DROP TABLE IF EXISTS cur_date;
CREATE TABLE cur_date (
  created_at DATE
);

DROP TABLE IF EXISTS all_date;
CREATE TABLE all_date (
  created_at DATE 
);

INSERT INTO cur_date
  (created_at)
values
('2018-08-01'),
('2018-08-04'),
('2018-08-16'),
('2018-08-17');

INSERT INTO all_date
  (created_at)
VALUES
('2018-08-01'),
('2018-08-02'),
('2018-08-03'),
('2018-08-04'),
('2018-08-05'),
('2018-08-06'),
('2018-08-07'),
('2018-08-08'),
('2018-08-09'),
('2018-08-10'),
('2018-08-11'),
('2018-08-12'),
('2018-08-13'),
('2018-08-14'),
('2018-08-15'),
('2018-08-16'),
('2018-08-17'),
('2018-08-18'),
('2018-08-19'),
('2018-08-20'),
('2018-08-21'),
('2018-08-22'),
('2018-08-23'),
('2018-08-24'),
('2018-08-25'),
('2018-08-26'),
('2018-08-27'),
('2018-08-28'),
('2018-08-29'),
('2018-08-30'),
('2018-08-31');

SELECT a.created_at, IF (c.created_at IS NULL, 0, 1) AS similarity FROM all_date a LEFT JOIN cur_date c
ON a.created_at = c.created_at;
 
-- ЗАДАНИЕ4 (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, 
-- который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
CREATE OR REPLACE VIEW five_date AS SELECT created_at FROM all_date ORDER BY created_at DESC LIMIT 5;
SET @last_date := (SELECT min(created_at) FROM five_date);
DELETE FROM all_date WHERE created_at < @last_date;

-- АДМИНИСТРИРОВАНИЕ
-- ЗАДАНИЕ1 Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю
-- shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — 
-- любые операции в пределах базы данных shop.
CREATE USER shop_read;
CREATE USER shop;
GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop;

-- ЗАДАНИЕ2 (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, 
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts,
-- однако, мог бы извлекать записи из представления username.
DROP TABLE IF EXISTS accounts;
CREATE TABLE  accounts  (id INT, name TEXT, password TEXT);
CREATE VIEW username AS SELECT id, name FROM accounts;
CREATE USER user_read;
GRANT SELECT ON shop. username  TO shop_read;

-- ХРАНИМЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ, ТРИГГЕРЫ
-- ЗАДАНИЕ1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
DROP FUNCTION IF EXISTS hello;
delimiter //
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	IF(hour(now()) BETWEEN '6' AND '12') THEN
		return 'Доброе утро';
	ELSEIF(hour(now()) BETWEEN '12' AND '18') THEN
		return 'Добрый день';
	ELSEIF(hour(now()) BETWEEN '0' AND '6') THEN
		return 'Доброй ночи';
	ELSE
		return 'Добрый вечер';
	END IF;
end//
delimiter ;
select hello();

-- ЗАДАНИЕ2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие
--- обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, 
-- чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
DROP TRIGGER IF EXISTS both_null_insert;
DELIMITER //
CREATE TRIGGER both_null_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
IF (NEW.description IS NULL) AND (NEW.name IS NULL)  THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
END IF;
END//
DELIMITER ;

INSERT INTO products
  (price, catalog_id)
VALUES
  (7890.00, 1);
  
 DROP TRIGGER IF EXISTS both_null_update;
DELIMITER //
CREATE TRIGGER both_null_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
IF (NEW.description IS NULL) AND (NEW.name IS NULL)  THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
END IF;
END//
DELIMITER ;

UPDATE products
SET name = NULL, description = Null
WHERE id = 1;
 
-- ЗАДАНИЕ3 (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
DROP FUNCTION IF EXISTS fibonacci;
DELIMITER //
CREATE FUNCTION fibonacci (n INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE num1, num2, num3 INT;
	SET num1 = 1;
	SET num2 = 1;
	SET num3 = 0;
	IF(n = 1 OR n = 2) THEN
		RETURN num2;
	ELSE
		WHILE n > 2 DO
			SET num3 = num1 + num2;
			SET num1 = num2;
			SET num2 = num3;
			SET n = n - 1;
		END WHILE;
		RETURN num2;
	END IF;
END//
DELIMITER ;
SELECT fibonacci(10);
