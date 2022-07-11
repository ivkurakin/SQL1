-- ОПЕРАТОРЫ
-- ЗАДАНИЕ1 Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.

-- Вставка тестовой строки
INSERT INTO users (name, created_at, updated_at)
VALUES ('test',NULL,NULL);

UPDATE users 
SET
	created_at = CURRENT_TIMESTAMP
WHERE 
	created_at IS NULL;
	
UPDATE users 
SET
	updated_at = CURRENT_TIMESTAMP
WHERE 
	updated_at IS NULL;

-- Удаление тестовой строки
DELETE FROM users
WHERE name='test';

-- ЗАДАНИЕ2 Таблица users была неудачно спроектирована.
-- Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате 
-- "20.10.2017 8:10". Необходимо преобразовать поля к типу
-- DATETIME, сохранив введеные ранее значения.

-- Для тестирования создаем таблицу user_test.
DROP TABLE IF EXISTS users_test;
CREATE TABLE users_test (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(256),
  updated_at VARCHAR(256)
) COMMENT = 'Покупатели test';
INSERT INTO users_test (name, created_at, updated_at)
VALUES ('test', '20.10.2017 8:10', '20.10.2017 8:10');

ALTER TABLE users_test 
ADD COLUMN created_at_new DATETIME, ADD COLUMN updated_at_new DATETIME;
UPDATE users_test
SET created_at_new = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
    updated_at_new = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');
ALTER TABLE users_test 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_new TO created_at, RENAME COLUMN updated_at_new TO updated_at;

DROP TABLE IF EXISTS users_test;

-- ЗАДАНИЕ3 В таблице складских запасов storehouses_products в поле value могут встречаться
-- самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
-- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

-- Вставка тестовых строк
INSERT INTO storehouses_products (value)
VALUES
(0), (2500), (0), (30), (500), (1);
SELECT *
FROM storehouses_products
ORDER BY IF (value > 0, 0, 1), value;


-- ЗАДАНИЕ4 (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')
SELECT name, birthday_at 
FROM users 
WHERE MONTHNAME(birthday_at) IN ('may', 'august');


-- ЗАДАНИЕ5 (по желанию)Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
SELECT *
FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY FIELD (id, 5, 1, 2);

-- АГРЕГАЦИЯ
-- ЗАДАНИЕ1 Подсчитайте средний возраст пользователей в таблице users
select round(avg (timestampdiff(year, birthday_at, curdate())), 0)  as avg_age
from users; 

-- ЗАДАНИЕ2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть,
-- что необходимы дни недели текущего года, а не года рождения.
SELECT  DAYNAME(DATE_FORMAT(birthday_at, '2022-%m-%d') ), COUNT(id) 
FROM users
GROUP BY (DAYNAME(DATE_FORMAT(birthday_at, '2022-%m-%d')));

