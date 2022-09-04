-- ЗАДАНИЕ1 Пусть задан некоторый пользователь. Из всех пользователей соц. сети 
-- найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT   u2.*  FROM users AS u1
JOIN messages AS m join users AS u2
ON u1.id = to_user_id AND u2.id = from_user_id
WHERE to_user_id = 2
GROUP BY from_user_id
ORDER BY count(u1.id) DESC LIMIT 1;

-- ЗАДАНИЕ2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
SELECT count(*) AS 'cnt'  FROM media AS m JOIN profiles AS p JOIN likes AS l 
ON p.user_id = m.user_id AND m.id = l.media_id 
WHERE  TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10;
 
 -- ЗАДАНИЕ3 Определить кто больше поставил лайков (всего): мужчины или женщины.
 SELECT CASE (gender)
         WHEN 'm' THEN 'male'
         WHEN 'f' THEN 'female'
    END AS gender  FROM profiles AS p JOIN likes AS l    
  	ON p.user_id = l.user_id 
  	GROUP BY(gender)
  	ORDER BY count(*) DESC LIMIT 1;