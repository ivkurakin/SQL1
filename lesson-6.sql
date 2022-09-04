-- ЗАДАНИЕ1 Пусть задан некоторый пользователь. Из всех пользователей соц. сети 
-- найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT  * FROM users
	WHERE id = (SELECT from_user_id  FROM messages
 	WHERE to_user_id = 2
 	GROUP BY from_user_id
  	ORDER BY count(id) DESC LIMIT 1);

-- ЗАДАНИЕ2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
SELECT count(*) as 'cnt'  FROM media 
	WHERE user_id IN (SELECT user_id  FROM profiles
  	WHERE  TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10) 
  	AND id IN (SELECT media_id  FROM likes);
 
 -- ЗАДАНИЕ3 Определить кто больше поставил лайков (всего): мужчины или женщины.
 SELECT CASE (gender)
         WHEN 'm' THEN 'male'
         WHEN 'f' THEN 'female'
    END AS gender  FROM profiles     
  	WHERE user_id IN (SELECT user_id FROM likes)
  	GROUP BY(gender)
  	ORDER BY count(user_id) DESC LIMIT 1;