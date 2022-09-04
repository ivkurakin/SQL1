-- Прислать предварительную версию курсового проекта:
-- DDL-команды;
-- Дамп БД (наполнение таблиц данными), не больше 10 строк в каждой таблице.


DROP DATABASE IF EXISTS football;
CREATE DATABASE football;
USE football;

DROP TABLE IF EXISTS players;
CREATE TABLE players (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT 'Игроки';

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	player_id BIGINT UNSIGNED NOT NULL UNIQUE,
    birthday DATE,  -- дата рождения
    birth_city VARCHAR(100),  -- город 
    birth_country VARCHAR(100), -- страна
	photo_id BIGINT UNSIGNED NULL, -- фотография игрока
    vk_page VARCHAR(120) UNIQUE,  -- страница в ВК
    heigh INT unsigned, -- рост
    `position` ENUM('нападающий', 'полузащитник', 'защитник', 'вратарь'), -- позиция на поле
	FOREIGN KEY (player_id) REFERENCES players(id)
   ) COMMENT 'Профили игроков';
   
    
DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
	team_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),  -- название команды
	team_city VARCHAR(100), -- город
	team_country VARCHAR(100), -- страна
    photo_id BIGINT UNSIGNED NULL, -- эмблема клуба
    website VARCHAR(120) UNIQUE,  -- сайт
    founded DATE, -- год оснавания
   	team_type BIT,  -- 0 - клуб, 1 - сборная
   	stadium_id BIGINT UNSIGNED NOT NULL -- стадион
   ) COMMENT 'Команды';
   

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
	id SERIAL,
	filename VARCHAR(255)  -- ссылка на файл
)COMMENT 'Все фотографии: игроки, эмблемы команд, стадион';

DROP TABLE IF EXISTS stadiums;
CREATE TABLE stadiums (
	id BIGINT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255),  -- название стадиона
	city VARCHAR(100),  -- город
	country VARCHAR(100), -- страна
    photo_id BIGINT UNSIGNED,  -- фотография стадиона
   	opened DATE,  -- год, когда построен
	capacity DOUBLE  NOT NULL, -- вместимость, тыс. человек
	FOREIGN KEY (photo_id) REFERENCES photos(id)
   ) COMMENT 'Стадионы';
  
DROP TABLE IF EXISTS tournaments;
CREATE TABLE tournaments (
	id  BIGINT UNSIGNED UNIQUE,
	name VARCHAR(255),  -- название турнира
	tour_type ENUM('внутренний', 'международный', 'сборные'),
	year_t YEAR,  -- год проведения
	winner BIGINT UNSIGNED NOT NULL, -- победитель
	PRIMARY KEY (id), 
	FOREIGN KEY (winner) REFERENCES teams(team_id),
	INDEX name_tournament_year(name, year_t)
   ) COMMENT 'Турниры';
   
DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
	id BIGINT UNSIGNED NOT null PRIMARY KEY,
	tournament_id BIGINT UNSIGNED,
	played_at DATETIME DEFAULT NOW(), -- дата проведения
	stadium_id BIGINT UNSIGNED NOT null, -- стадион проведения
	home_team BIGINT UNSIGNED NOT NULL,  -- хозяева
	gast_team BIGINT UNSIGNED NOT NULL,  -- гости
	home_goal INT,  -- голы хозяев
	gast_goal INT,  -- голы гостей
	FOREIGN KEY (home_team) REFERENCES teams(team_id),
	FOREIGN KEY (gast_team) REFERENCES teams(team_id),
	FOREIGN KEY (stadium_id) REFERENCES stadiums(id)
   ) COMMENT 'Матчи';
  
DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
	team_id BIGINT UNSIGNED NOT NULL,  -- команда
	tournament_id BIGINT UNSIGNED, -- null - международный
 	points INT,  -- очки
	sc_goals INT,   -- забитые голы
	con_goals INT,  -- пропущенные голы
	PRIMARY KEY (team_id, tournament_id), 
	FOREIGN KEY (team_id) REFERENCES teams(team_id),
	FOREIGN KEY (tournament_id) REFERENCES tournaments(id)
   ) COMMENT 'Статистика команд по турнирам';

  
DROP TABLE IF EXISTS player_team;
CREATE TABLE player_team (
	player_id BIGINT UNSIGNED NOT NULL, -- игрок
	team_id BIGINT UNSIGNED NOT NULL,  -- команда
	year_begin YEAR,  -- год начала выступления за команду
   	year_end YEAR,  -- год окончания выступления за команду
	FOREIGN KEY (team_id) REFERENCES teams(team_id),
	FOREIGN KEY (player_id) REFERENCES players(id)
   ) COMMENT 'История клубов игрока';
  
DROP TABLE IF EXISTS players_statistic;
CREATE TABLE  players_statistic (
	player_id BIGINT UNSIGNED NOT NULL,  -- игрок
	play BIGINT UNSIGNED NOT null,  -- матч
   	minutes INT UNSIGNED, -- проведенные минуты в игре
	goals INT,  -- забитые голы
   	assists INT,  -- голевые передачи
   	yellow_card BIT,  -- желтые карточки
   	red_card BIT, -- красные карточки   	
	FOREIGN KEY (play) REFERENCES matches(id),
	FOREIGN KEY (player_id) REFERENCES players(id)
   ) COMMENT 'Статистика игрока';
  
ALTER TABLE profiles ADD CONSTRAINT fk_photo_id
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    ON UPDATE CASCADE
    ON DELETE cascade;

 ALTER TABLE teams ADD CONSTRAINT fk_phototeam_id
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    ON UPDATE CASCADE
    ON DELETE cascade;
   
  ALTER TABLE teams ADD CONSTRAINT fk_stadiumteam_id
    FOREIGN KEY (stadium_id) REFERENCES stadiums(id);
    
   
INSERT INTO players (firstname, lastname) VALUES
('Криштиано','Роналду'),
('Лионель','Месси'),
('Юрий','Жирков'),
('Егор','Титов'),
('Филиппо','Индзаги'),
('Андреас','Иньеста'),
('Давор','Шукер'),
('Василий','Березуцкий'),
('Андрей','Аршавин'),
('Михаэль','Баллак'),
('Андрей','Заболотный'),
('Лука','Модрич');

INSERT INTO photos (filename) VALUES 
('Роналдо.jpg'),
('Месси.jpg'),
('Жирков.jpg'),
('Титов.jpg'),
('Индзаги.jpg'),
('Иньеста.jpg'),
('Шукер.jpg'),
('Березуцкий.jpg'),
('Аршавин.jpg'),
('Баллак.jpg'),
('Спартак.jpg'),
('сборнаяРоссии.jpg'),
('Арсенал.jpg'),
('сборнаяХорватии.jpg'),
('МЮ.jpg'),
('Реал.jpg'),
('Барселона.jpg'),
('Милан.jpg'),
('Сити.jpg'),
('сборнаяАргентины.jpg'),
('стЛужники.jpg'),
('стВинсенто.jpg'),
('стДинамоКиров.jpg'),
('стНоуКамп.jpg'),
('стЭмирейтс.jpg'),
('стСан-сиро.jpg'),
('стДинамоЗагреб.jpg'),
('стЭтихад.jpg'),
('стОлд_Траффорд.jpg'),
('стАргентина.jpg');


INSERT INTO profiles (player_id, birthday, birth_city, birth_country, photo_id, vk_page, heigh, `position` ) VALUES
(1,'1985-06-19', 'Лиссабон', 'Португалия', 1,  'vk.123415635126', 195, 'нападающий'),
(2,'1987-07-15', 'Росарио', 'Аргентина', 2, 'vk.1237587635126', 170, 'нападающий'),
(3,'1983-08-30', 'Тамбов', 'Россия', 3, 'vk.12675676535126', 185, 'защитник'),
(4,'1979-10-08', 'Москва', 'Россия', 4, 'vk.12378635126', 181, 'полузащитник'),
(5,'1977-06-15', 'Милан', 'Италия', 5, 'vk.4356865126', 190, 'нападающий'),
(6,'1975-01-14', 'Барселона', 'Испания', 6, 'vk.31213415635126', 170, 'полузащитник'),
(7,'1969-12-30', 'Сплит', 'Хорватия', 7, 'vk.12535325635126', 190,'нападающий'),
(8,'1981-03-06', 'Москва', 'Россия', 8, 'vk.112313415635126',195, 'защитник'),
(9,'1981-04-22', 'Санкт-Петербург', 'Россия', 9, 'vk.187815635126', 170, 'полузащитник'),
(10,'1979-03-19', 'Берлин', 'Германия', 10, 'vk.1213415635126', 198, 'полузащитник'),
(11,'1990-11-11', 'Москва', 'Россия', NULL, 'vk.121354985635126', 201, 'нападающий'),
(12,'1979-03-25', 'Загреб', 'Хорватия', NULL, 'vk.253415635126', 170, 'полузащитник');

INSERT INTO stadiums (id, name, city, country, photo_id, opened, capacity) VALUES
(1,'Лужники', 'Химки', 'Россия', 21,   '1956-06-27', 30.0),
(2,'Винсенто', 'Мадрид', 'Испания', 22, '1927-08-08', 75.0),
(3,'Динамо', 'Киров', 'Россия', 23, '1950-01-06', 9.5),
(4,'НоуКамп', 'Барселона', 'Испания', 24, '1935-12-12', 84.5),
(5,'Эмирейтс', 'Лондон', 'Англия', 25,  '2007-10-23', 56.4),
(6,'Сан-Сиро', 'Милан', 'Италия', 26, '1915-05-31', 66.0),
(7,'Динамо', 'Загреб', 'Хорватия', 27,  '1950-04-04', 20.2),
(8,'Этихад', 'Манчестер', 'Англия', 28, '2014-12-31', 63.5),
(9,'Олд Траффорд', 'Манчестер', 'Англия', 29, '1956-01-31', 71.0),
(10,'Аргентина', 'Буэнос-Айрос', 'Аргентина', 30, '2020-09-09', 77.0),
(11,'ВЭБ Арена', 'Москва', 'Россия', NULL, '2016-05-09', 35.0),
(12,'Аякс', 'Амстердам', 'Нидерланды', NULL, '2010-10-08', 67.0);

INSERT INTO teams (team_id, name, team_city, team_country, photo_id, website, founded, team_type,  stadium_id) VALUES
(1,'Спартак', 'Москва', 'Россия', 11,  'spartak@.ru', '1922-01-01', 0, 1),
(2,'Россия', NULL, 'Россия', 12, 'Russia@.ru', NULL, 1, 1),
(3,'Арсенал', 'Лондон', 'Англия', 13, 'arsenal@.com', '1917-01-01', 0, 5),
(4,'Хорватия', NULL, 'Хорватия', 14, 'Croatia@.com', NULL, 1, 7),
(5,'МЮ', 'Манчестер', 'Англия', 15, 'MU@.com', '1899-01-01', 0, 9),
(6,'Реал', 'Мадрид', 'Испания', 16, 'REAL@.esp', '1896-01-01', 0, 2),
(7,'Барселона', 'Барселона', 'Испания', 17, 'barca@.esp', '1926-01-01', 0, 4),
(8,'Милан', 'Милан', 'Италия', 18, 'milan@.com','1901-01-01', 0, 6),
(9,'Сити', 'Манчестер', 'Англия', 19, 'CITY@.com', '1959-01-01', 0, 8),
(10,'Аргентина', NULL, 'Аргентина', 20, 'argentina@.arg', NULL, 1, 9),
(11,'ЦСКА', 'Москва', 'Россия', NULL, 'csca@.ru', '1922-01-01', 0, 11);


INSERT INTO tournaments (id, name, tour_type, year_t,  winner) VALUES
(1,'Чемпионат России',  'внутренний', '2017', 1),
(2,'Чемпионат Испании',  'внутренний', '2014', 7),
(3,'Чемпионат Испании',  'внутренний', '2017', 5),
(4,'Лига Чемпионов',  'международный', '2022', 6),
(5,'Кубок России',  'внутренний', '2017', 1),
(6,'Чемпионат России',  'внутренний', '1992', 1),
(7,'Чемпионат Англии',  'внутренний', '1999', 5),
(8,'Чемпионат Испании',  'внутренний', '1998', 6),
(9,'Лига Чемпионов',  'международный', '2004', 6),
(10,'Чемпионат Испании',  'внутренний', '2022', 6);

 
INSERT INTO matches (id, tournament_id, played_at, stadium_id,  home_team, gast_team, home_goal, gast_goal) VALUES
(1, 2, '2014-10-23', 2, 6, 7, 3, 0 ),
(2, 3, '2017-05-06', 4, 7, 6, 0, 1 ),
(3, 7, '1999-12-31', 9, 5, 9, 2, 1 ),
(4, 9, '2022-02-09', 1, 1, 3, 4, 0 ),
(5, 9, '2004-10-23', 4, 7, 8, 0, 0 ),
(6, 9, '1992-11-11', 7, 1, 3, 2, 3 ),
(7, 9, '2004-03-04', 2, 6, 5, 4, 3 ),
(8, 8, '1998-01-06', 2, 6, 7, 1, 1 ),
(9, 4, '2022-09-30', 6, 8, 1, 3, 1 ),
(10,7, '1999-09-30', 5, 3, 5, 3, 0 );

INSERT INTO rating (team_id, tournament_id, points, sc_goals,  con_goals) VALUES
(3, 7, 68, 68, 32),
(5, 7, 74, 61, 38),
(9, 7, 44, 37, 40),
(6, 2, 77, 55, 19),
(7, 2, 77, 66, 24),
(6, 3, 90, 74, 22),
(7, 3, 74, 65, 38);

INSERT INTO player_team (player_id, team_id, year_begin, year_end) VALUES
(1, 5, 2004, 2010),
(1, 6, 2010, 2017),
(1, 5, 2019, 2022),
(2, 7, 2008, 2017),
(9, 3, 2009, 2013),
(4, 1, 1997, 2014),
(5, 8, 1999, 2010),
(6, 7, 2003, 2017),
(7, 6, 1996, 2000),
(7, 3, 2000, 2001),
(7, 3, 2004, 2022);

INSERT INTO players_statistic  (player_id, play, minutes, goals, assists, yellow_card, red_card) VALUES
(1, 1, 66, 0, 0, 0, 0),
(1, 3, 90, 2, 2, 0, 0),
(1, 7, 75, 3, 0, 1, 0),
(2, 7, 33, 1, 0, 0, 0),
(2, 2, 88, 4, 0, 1, 0),
(3, 4, 56, 0, 0, 1, 0),
(4, 5, 60, 0, 0, 1, 0),
(5, 7, 90, 0, 2, 0, 0),
(6, 6, 90, 1, 1, 1, 0);

