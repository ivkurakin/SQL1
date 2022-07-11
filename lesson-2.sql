-- Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы 
-- (с перечнем полей, указанием индексов и внешних ключей)

DROP TABLE IF EXISTS enter_history;
CREATE TABLE enter_history (
	enter_user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    device_type ENUM('pc', 'apple', 'android'),
    device_name TEXT,
    city_enter  VARCHAR(255) COMMENT'для отображения, откуда был вход, если новый девайс',
	time_enter DATETIME DEFAULT NOW(),
	device_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (enter_user_id, device_id),
    FOREIGN KEY (enter_user_id) REFERENCES users(id)
   )COMMENT 'история посещений для проверки девайсов и отображения, когда пользователь был в сети';


DROP TABLE IF EXISTS search_history;
CREATE TABLE search_history (
	search_user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    search_request  TEXT,
	time_search DATETIME DEFAULT NOW(),
	search_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (search_user_id, search_id),
    FOREIGN KEY (search_user_id) REFERENCES users(id)
)COMMENT 'история поиска пользователя';

DROP TABLE IF EXISTS study_info;
CREATE TABLE study_info(
	organization_id BIGINT UNSIGNED NOT  NULL UNIQUE,
	student_id BIGINT UNSIGNED NOT NULL UNIQUE,
	organization_name VARCHAR(150)  COMMENT 'ВУЗ',
	faculty_name VARCHAR(255),
	INDEX organization_nam_idx(organization_name),
	FOREIGN KEY (student_id) REFERENCES users(id)
) COMMENT 'информация об учебе';

DROP TABLE IF EXISTS users_organization;
CREATE TABLE users_organization(
	user_id BIGINT UNSIGNED NOT  NULL UNIQUE,
	org_id BIGINT UNSIGNED NOT  NULL UNIQUE,
  	PRIMARY KEY (user_id, org_id), 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (org_id) REFERENCES study_info(organization_id)
);
