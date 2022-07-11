-- ЗАДАНИЕ1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети.
INSERT INTO orders (user_id) VALUES
  (2),
  (4),
  (6),
  (4),
  (2);
SELECT  name FROM users
	WHERE id IN (SELECT user_id  FROM orders);

-- ЗАДАНИЕ2 Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT t1.name AS product, t2.name AS category FROM products AS t1 JOIN catalogs AS t2 
	ON t1.catalog_id = t2.id;
 
 -- ЗАДАНИЕ3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 -- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights 
 -- с русскими названиями городов.
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  `label` VARCHAR(255) PRIMARY KEY,
  `name` VARCHAR(255)
);
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255),
  `to` VARCHAR(255),
  FOREIGN KEY (`from`) REFERENCES cities(`label`),
  FOREIGN KEY (`to`) REFERENCES cities(`label`)
); 

INSERT INTO cities (`label`, `name`) VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
 
 INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
 
SELECT id, t1.`name`, t2.`name`
FROM flights JOIN cities AS t1
ON `from` = t1.label JOIN cities AS t2 ON `to` = t2.label 
ORDER BY id;
