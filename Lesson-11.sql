-- ОПТИМИЗАЦИЯ ЗАПРОСОВ
-- ЗАДАНИЕ1 Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  log_id SERIAL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  table_name VARCHAR(255),
  key_id INT UNSIGNED,
  content VARCHAR(255)
)  ENGINE=Archive;

DROP TRIGGER IF EXISTS insert_into_users;
DELIMITER //
CREATE TRIGGER insert_into_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
INSERT INTO logs (table_name, key_id, content) VALUES ('users', NEW.id, NEW.name);
END//
DELIMITER ;
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05');
 
DROP TRIGGER IF EXISTS insert_into_catalogs;
DELIMITER //
CREATE TRIGGER insert_into_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
INSERT INTO logs (table_name, key_id, content) VALUES ('catalogs', NEW.id, NEW.name);
END//
DELIMITER ;
INSERT INTO catalogs VALUES
  (NULL, 'Сканеры');

DROP TRIGGER IF EXISTS insert_into_products;
DELIMITER //
CREATE TRIGGER insert_into_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
INSERT INTO logs (table_name, key_id, content) VALUES ('products', NEW.id, NEW.name);
END//
DELIMITER ;
INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1);

-- ЗАДАНИЕ2 (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- DROP PROCEDURE IF EXISTS insert_n;
-- delimiter //
-- CREATE PROCEDURE insert_n(n INT)
-- begin
-- while n > 0 DO
-- insert into users (name) values ('Ivan');
-- set n = n-1;
-- END while;
-- end//
-- delimiter ;
-- call insert_n(1000000)
-- РАБОТАЕТ ДОЛГО

INSERT INTO users (name, birthday_at) SELECT t1.name, t1.birthday_at FROM users t1, users t2, users t3, users t4, users t5, users t6, users t7, users t8 LIMIT 1000000;
SELECT COUNT(*) FROM users;

