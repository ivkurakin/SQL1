/*Требования к курсовому проекту:
Составить общее текстовое описание БД и решаемых ею задач;
минимальное количество таблиц: 10;
скрипты создания структуры БД (DDL, с первичными ключами, индексами, внешними ключами);
создать ERDiagram для БД;
скрипты наполнения БД данными (дамп, не более 20 строк в таблицах);
скрипты характерных выборок (SELECT, включающие группировки, JOIN'ы, вложенные запросы);
представления (минимум 2);
Хранимая процедура / функция / триггер (на выбор, 1 шт.);*/

-- ОПИСАНИЕ БД
/* БД предназнаена для хранения футбольной информации и статистики.
Содержит в себе следующие таблицы:
players - содержит основную информацию о игроках (имя и фамилию);
profiles - содержит расширенную информацию о игроках (дату,город, страну рождения, ссылку на фотографию из таблицы photos, ссылку на страницу в вк, 
рост, пощзицию на поле);
teams - содержит информацию о командах (название, тип (сборная или клуб), город, страну, ссылку на эмблему из таблицы photos,
оффициальный сайт, дату основания, название домашнего стадиона);
photos - содержит фотографии игроков, стадионов и эмблемы;
stadiums - содержит информацию о стадионах (название, город, страну, ссылку на фотографию из таблицы photos, дата открытия, вместимость);
tournaments - содержит информацию о турнирах (название, тип ('внутренний', 'международный', 'сборные'), год проведения, текущий победитель);
matches - содержит информацию о матчах (турнир, дата проведения, стадион, хозяева, гости, голы хозяев, голы гостей);
rating  - содержит таблицы турниров (турнир, команды, очки, забитые и пропущенные голы );
player_team - содержит соотношение игрок -  клуб (игрок, клуб, год появление в клубе, год ухода из клуба);
players_statistic - содержит статистику игрока (игрок, матч,проведенные минуты в игре, гзабитые голы, голевые передачи, желтые и красные карточки).

Для демонстрации допущены следующие допущения: игроки могут прийти в клуб только в начале года, уйти в конце года.
Сезон турнира совпадает с годом.

Функции, процедуры и триггеры описаны при их создании.
Связи между таблицами приведены в DDL-файле и на ER-Diagram.*/


-- Поиск игроков, клубов, стадионов, для которых в базе данных нет фотографий (эмблем)
SELECT CONCAT(firstname,' ', lastname) AS full_name FROM profiles t1 JOIN players t2
ON t1.player_id = t2.id
WHERE photo_id IS NULL
UNION 
SELECT name FROM teams
WHERE photo_id IS NULL
UNION 
SELECT name FROM stadiums
WHERE photo_id IS NULL;

-- Добавление фото и обновление таблиц с ссылками на фото 
INSERT INTO photos(filename) VALUES 
('Заболотный.jpg'),
('Модрич.jpg'),
('ВэбАрена.jpg'),
('Аякс.jpg'),
('ЦCКА.jpg');

UPDATE profiles
SET photo_id = (SELECT id FROM photos WHERE filename = 'Заболотный.jpg')
WHERE player_id = (SELECT id FROM players  WHERE firstname = 'Андрей' AND lastname = 'Заболотный');

UPDATE profiles
SET photo_id = (SELECT id FROM photos WHERE filename = 'Модрич.jpg')
WHERE player_id = (SELECT id FROM players  WHERE firstname = 'Лука' AND lastname = 'Модрич');

UPDATE stadiums 
SET photo_id = (SELECT id FROM photos WHERE filename = 'ВэбАрена.jpg')
WHERE name = 'ВэбАрена';

UPDATE stadiums 
SET photo_id = (SELECT id FROM photos WHERE filename = 'Аякс.jpg')
WHERE name = 'Аякс';

UPDATE teams 
SET photo_id = (SELECT id FROM photos WHERE filename = 'ЦCКА.jpg')
WHERE name = 'ЦCКА';

-- Поиск легионера, выступающего за клуб не из своей страны
SELECT CONCAT(firstname,' ', lastname) AS full_name FROM profiles t1 JOIN players t2
ON t1.player_id = t2.id JOIN player_team t3 ON t1.player_id = t3.player_id JOIN 
teams t4 ON t3.team_id = t4.team_id 
WHERE t4.team_country != t1.birth_country AND year_end = YEAR(NOW());

-- Поиск самого вместительного стадиона
SELECT name, city, country FROM stadiums
ORDER BY capacity DESC LIMIT 1;

-- Поиск победителей разных турниров за определенный год
SELECT year_t, teams.name, tournaments.name FROM tournaments join teams
ON winner = team_id 
WHERE year_t = 2017;

-- Поиск победителей нескольких турниров
SELECT  teams.name, COUNT(*) FROM tournaments join teams
ON winner = team_id 
GROUP BY winner
HAVING count(*) > 1
ORDER BY count(*);

-- Вывод таблицы турнира
SELECT  name, points, sc_goals, con_goals, (sc_goals - con_goals) AS diff FROM teams t JOIN rating r
ON t.team_id = r.team_id
WHERE tournament_id = 2
ORDER BY points DESC, diff DESC;

-- Представление: статистика игрока по турниру
CREATE OR REPLACE VIEW avg_stat_tour AS
SELECT CONCAT(firstname,' ', lastname) player, tournaments.id tour, tournaments.name name_tour, tournaments.year_t year_tour,
COUNT(play) games, AVG(minutes) avg_time, SUM(goals) goals, SUM(assists) assists, SUM(yellow_card) yellow, 
SUM(red_card) red
FROM players_statistic JOIN players
ON player_id = id JOIN matches
ON play = matches.id JOIN tournaments 
ON matches.tournament_id = tournaments.id 
GROUP BY tour, player;
SELECT * FROM avg_stat_tour;

-- Представление: максимальное количество голов в турнире
CREATE OR REPLACE VIEW max_goals_tour AS
SELECT tour, name_tour, year_tour, MAX(goals) as max_goals
FROM  avg_stat_tour
GROUP BY tour;
SELECT * FROM max_goals_tour;

-- Вывод информации для определенного чемпионата за все года
SELECT  year_tour, max_goals FROM max_goals_tour
WHERE name_tour = 'Чемпионат Испании'
ORDER BY year_tour;

-- Поиск лучшего бомбардира
SELECT player, max_goals  FROM avg_stat_tour  t1 JOIN max_goals_tour t2
ON t1.tour = t2.tour
WHERE t1.goals = t2.max_goals;

-- Представление: статистика игрока за все время
CREATE OR REPLACE VIEW avg_stat AS
SELECT CONCAT(firstname,' ', lastname) player, COUNT(play) games, AVG(minutes) avg_time, SUM(goals) goals, SUM(assists) assists, SUM(yellow_card) yellow, 
SUM(red_card) red
FROM players_statistic JOIN players
ON player_id = id
GROUP BY player; 

-- Вызов представления
SELECT * FROM avg_stat;

-- Поиск статистики для конкретного игрока
SELECT player, games, goals FROM avg_stat
WHERE player = 'Криштиано Роналду';


-- Функция: поиск клуба, в котором игрок выступал в конкретном году
DROP FUNCTION IF EXISTS carrier;
DELIMITER //
CREATE FUNCTION carrier(name_pl VARCHAR(255), year_f int)  -- почему-то не прошел тип данных year
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE find VARCHAR(255);
	SET find = (SELECT name FROM teams t1 JOIN player_team t2
	ON t1.team_id  = t2.team_id JOIN players t3 ON t2.player_id = t3.id 
	WHERE t3.lastname = name_pl AND (year_f BETWEEN t2.year_begin  AND t2.year_end));
	IF (find IS NOT NULL) THEN 
	RETURN find;
	ELSE
		RETURN 'Не играл в этом году';
	END IF;
END//
DELIMITER ;
SELECT carrier('Месси', 2022) AS search_result;
SELECT carrier('Месси', 2017) AS search_result;

-- Триггер: при участии команды в матче учитываем голы и добавляем очки в таблице rating
DROP TRIGGER IF EXISTS new_match;
DELIMITER //
CREATE TRIGGER new_match AFTER INSERT ON matches
FOR EACH ROW
BEGIN
UPDATE rating
SET rating.sc_goals = rating.sc_goals + NEW.home_goal,
rating.con_goals = rating.con_goals + NEW.gast_goal
WHERE rating.tournament_id = NEW.tournament_id and rating.team_id = NEW.home_team;
UPDATE rating
SET rating.sc_goals = rating.sc_goals + NEW.gast_goal,
rating.con_goals = rating.con_goals + NEW.home_goal
WHERE rating.tournament_id =NEW.tournament_id and rating.team_id = NEW.gast_team;
IF (NEW.gast_goal < NEW.home_goal)  THEN
	UPDATE rating
	SET rating.points = rating.points + 3
	WHERE rating.tournament_id = NEW.tournament_id AND rating.team_id = new.home_team;
ELSEIF (NEW.gast_goal = NEW.home_goal)  THEN
	UPDATE rating
	SET rating.points = rating.points + 1
	WHERE rating.tournament_id = NEW.tournament_id AND (rating.team_id = NEW.home_team OR rating.team_id = NEW.gast_team);
ELSE
	UPDATE rating
	SET rating.points = rating.points + 3
	WHERE rating.tournament_id = NEW.tournament_id AND rating.team_id = NEW.gast_team;
END IF;
END//
DELIMITER ;

INSERT INTO matches (id, tournament_id,stadium_id, home_team, gast_team, home_goal, gast_goal)
VALUES (13, 7, 1, 3, 5, 2, 1);
SELECT * FROM rating;


-- Процедура: для двух играющих команд вывести: три последних матчей для каждой + три последних матчей между собой
DROP PROCEDURE IF EXISTS last_matches;
DELIMITER //
CREATE PROCEDURE last_matches(name_host VARCHAR(255), name_gast VARCHAR(255))  -- почему-то не прошел тип данных year
BEGIN
	(SELECT DATE(played_at), t1.name, t2.name, home_goal, gast_goal FROM matches m JOIN teams t1
	ON home_team = t1.team_id  JOIN teams t2  ON gast_team = t2.team_id
	WHERE t1.name  = name_host OR t2.name = name_host
	ORDER BY played_at DESC LIMIT 3)
	UNION ALL
	(SELECT DATE(played_at), t1.name, t2.name, home_goal, gast_goal FROM matches m JOIN teams t1
	ON home_team = t1.team_id  JOIN teams t2  ON gast_team = t2.team_id
	WHERE t1.name  = name_gast OR t2.name = name_gast
	ORDER BY played_at DESC LIMIT 3)
	UNION ALL
	(SELECT DATE(played_at), t1.name, t2.name, home_goal, gast_goal FROM matches m JOIN teams t1
	ON home_team = t1.team_id  JOIN teams t2  ON gast_team = t2.team_id
	WHERE (t1.name  = name_host AND t2.name = name_gast) OR (t2.name  = name_host AND t1.name = name_gast)
	ORDER BY played_at DESC LIMIT 3);
END//
DELIMITER ;

CALL last_matches('Барселона', 'Реал');

