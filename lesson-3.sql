-- ЗАДАНИЕ1 Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице)


-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_23
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'voluptas',1),(2,'inventore',2),(3,'modi',3),(4,'eaque',4),(5,'sed',5),(6,'omnis',6),(7,'accusamus',7),(8,'sed',8),(9,'dolorem',9),(10,'harum',10),(11,'dolor',11),(12,'pariatur',12),(13,'dolorem',13),(14,'quia',14),(15,'harum',15);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,1,'approved','1982-07-03 21:13:40','2021-07-01 17:20:50'),(2,2,'requested','2005-12-24 09:58:20','1973-09-25 01:29:34'),(3,3,'requested','1981-04-01 04:36:18','2001-06-06 13:27:15'),(4,4,'approved','2003-06-26 15:41:41','1981-02-13 01:21:24'),(5,5,'unfriended','1993-10-17 18:26:12','1994-02-08 19:04:35'),(6,6,'requested','2010-10-17 20:57:20','2002-02-10 11:45:40'),(7,7,'declined','2011-09-24 03:15:05','2005-02-01 22:18:57'),(8,8,'approved','2001-06-20 02:15:31','1987-11-18 15:34:05'),(9,9,'unfriended','2009-09-04 05:33:15','2022-04-02 08:05:15'),(10,10,'requested','2012-03-18 04:27:26','1991-02-01 20:52:06'),(11,11,'approved','2021-09-08 14:25:43','2014-09-30 14:12:02'),(12,12,'unfriended','2013-03-19 18:04:22','2021-09-24 18:21:22'),(13,13,'requested','2016-10-25 10:16:15','1978-01-03 21:11:08'),(14,14,'declined','1995-05-14 01:56:54','1986-03-15 22:38:48'),(15,15,'approved','2021-04-15 05:41:19','1998-04-06 06:40:56');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,1,'1988-05-11 01:45:33'),(2,2,2,'2020-03-13 07:33:10'),(3,3,3,'2000-11-28 04:06:29'),(4,4,4,'2010-03-30 09:46:15'),(5,5,5,'1999-04-12 21:24:07'),(6,6,6,'1987-12-18 00:05:12'),(7,7,7,'1982-09-01 22:47:27'),(8,8,8,'2012-10-20 13:48:45'),(9,9,9,'2013-10-30 23:07:52'),(10,10,10,'1971-10-18 14:38:54'),(11,11,11,'2016-12-15 09:41:41'),(12,12,12,'1991-10-10 22:33:43'),(13,13,13,'2004-08-19 04:11:40'),(14,14,14,'2009-03-28 02:33:11'),(15,15,15,'1979-03-16 03:22:56');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,1,'Rerum tempora eaque magni provident. Delectus nesciunt illum est ea est ipsum. A voluptatem et quis est nobis delectus.','rerum',69873,NULL,'1999-10-12 00:35:44','2000-11-05 18:18:28'),(2,2,2,'Eligendi rerum quisquam ratione fuga ex. Qui unde dolores unde et maxime hic rerum minima. Molestias blanditiis exercitationem corporis est. Quisquam in eos officiis dolorum tempora omnis nihil.','quia',39981,NULL,'1984-01-01 02:31:42','2010-07-19 04:10:29'),(3,3,3,'Aut cum in ut sapiente. Ut omnis deserunt non sed modi et eos doloribus. Error dolorem et ut ullam.','provident',0,NULL,'2007-04-07 14:32:03','2019-01-05 03:31:38'),(4,4,4,'Deleniti autem enim exercitationem voluptatem. Quas saepe excepturi est quos rerum eos natus. Dolor in maiores vel enim totam.','quod',8,NULL,'2012-06-28 06:35:33','2000-12-25 21:53:54'),(5,1,5,'Et dolores est vel. Molestiae ullam suscipit doloremque mollitia cum amet esse. Sit quia quas quam ut quos aut culpa.','magni',0,NULL,'2017-09-16 07:34:11','2013-02-22 01:02:42'),(6,2,6,'Rerum quod a sequi labore veniam itaque. Et eum nulla vero illum. Molestiae non suscipit porro est est. Rerum ipsa velit corporis tenetur. Non eveniet sint sed voluptatibus vel doloremque nobis.','explicabo',4908160,NULL,'1997-11-19 02:21:35','2018-04-12 19:55:47'),(7,3,7,'Reiciendis nihil reiciendis animi quidem excepturi voluptatum et. Recusandae eos maxime ducimus amet tempore explicabo quos. Voluptatum exercitationem sed reprehenderit. Facere quis mollitia est dolores nobis quia ipsum enim.','facere',615,NULL,'2011-04-21 19:18:02','1983-11-12 05:52:15'),(8,4,8,'Quidem ipsa ut labore dolorem et. Modi beatae quisquam quasi officiis dolor. Eum facilis ad vel pariatur itaque.','aut',0,NULL,'1973-02-20 11:47:20','1975-06-20 21:57:58'),(9,1,9,'Qui non et rerum illum et sed laudantium. Facere iste totam porro dolores facilis est qui. Sapiente enim repudiandae maiores. Vitae doloremque est quam et earum fugiat rem.','quas',357,NULL,'2014-03-06 04:50:49','1970-03-27 01:12:07'),(10,2,10,'Dolorem tempora veritatis placeat. Deserunt adipisci molestias dolore quia inventore laboriosam. In explicabo odit ad est sunt culpa incidunt. Consequatur quis voluptas sed unde modi odio.','sint',243,NULL,'1987-05-22 13:32:15','2010-01-15 22:06:31'),(11,3,11,'Esse ea quae odio quod at quo minus ea. Sequi non dolorem deserunt dolorem dicta beatae atque. Nisi neque nobis sed assumenda voluptas.','enim',873503418,NULL,'2002-06-26 04:38:44','1986-09-18 19:24:30'),(12,4,12,'Inventore esse voluptatibus quam sed. Et aut totam debitis. Quia sit beatae ipsum ex in quidem. Sunt reiciendis vel excepturi aut eum in id.','maiores',2032,NULL,'2020-06-21 17:35:55','1972-12-23 18:31:08'),(13,1,13,'Ducimus rerum dolor aliquam minus quas est ex. Aut sit nesciunt quae ut natus sit ducimus natus. Ipsa labore corrupti quis perspiciatis at sit.','quia',2502186,NULL,'1984-06-08 20:05:16','2015-09-07 15:48:55'),(14,2,14,'Repudiandae non delectus non quibusdam voluptatum numquam voluptatem. Et qui voluptas voluptate numquam. Esse repudiandae illum sed praesentium quia. Dolores corrupti tempora et dolor rem suscipit.','ut',922,NULL,'1973-03-16 08:27:43','1980-05-21 22:37:22'),(15,3,15,'Veritatis totam voluptatem consequuntur est. Et dicta fuga consequuntur aliquam suscipit dignissimos ut. Et dolorum veniam debitis. Possimus voluptas sunt laboriosam ipsa quo.','qui',600,NULL,'2017-02-19 07:43:08','2019-03-27 18:46:07');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'in','1984-02-20 16:32:31','1987-08-15 00:26:51'),(2,'ipsum','1986-07-01 23:01:19','2021-02-20 20:51:13'),(3,'possimus','1993-04-20 10:31:45','1970-07-16 15:58:05'),(4,'architecto','1973-03-14 09:51:31','2020-09-17 23:19:23');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,1,'Tenetur hic qui voluptas autem voluptate neque earum. Aut impedit beatae est quo consectetur. Nesciunt repellendus id omnis accusantium placeat aperiam.','2003-05-18 00:00:00'),(2,2,2,'Ea sed quis accusamus itaque reiciendis et. Et itaque commodi sit ut odit similique sit. Magni molestiae et quas velit. Est odit eum itaque asperiores quod et.','1990-12-30 00:00:00'),(3,3,3,'Facere nemo qui voluptas molestias dicta. Qui odit quam neque nulla perspiciatis. Et quae sit qui in quod inventore atque impedit. Consequatur omnis quod voluptas temporibus ea quo.','1991-06-28 00:00:00'),(4,4,4,'Omnis fuga ipsa numquam rerum unde qui assumenda. Ullam velit itaque et enim illo corrupti quo. Est error harum tempora veritatis quae odio minus.','1976-06-09 00:00:00'),(5,5,5,'Incidunt suscipit delectus illum dolor iste. Est animi accusantium alias magni et accusamus debitis. Accusantium delectus dolorem animi autem.','2001-12-10 00:00:00'),(6,6,6,'Quam nisi quas cupiditate deleniti velit sed. Et qui repellendus voluptatem maiores reiciendis. Et atque vel non veritatis dolorem maxime. Impedit fuga cum id.','2021-12-27 00:00:00'),(7,7,7,'Voluptas vero aut nemo numquam qui quasi eaque vel. Nulla doloribus unde dolorem et sit. Dolore qui at qui ut quisquam sapiente. Voluptatem ea omnis repellendus debitis quod rerum.','1996-10-16 00:00:00'),(8,8,8,'Et non tempore expedita animi similique magni. Distinctio accusamus a dolor officia. Eius occaecati nesciunt architecto itaque quas a voluptatibus. Ullam id voluptatum molestias esse qui alias.','2018-12-07 00:00:00'),(9,9,9,'Quasi accusantium ut quos ducimus vel error minima. Pariatur dolorem doloremque corporis tenetur voluptatibus rerum. Neque qui dolores voluptatem cum quis et.','2005-07-16 00:00:00'),(10,10,10,'Voluptate eum adipisci minima sequi sunt. Aut sit autem explicabo qui velit id expedita. Aut eius pariatur et blanditiis quos sit nulla. Esse sapiente sapiente odit autem nemo consequuntur amet necessitatibus.','2003-07-25 00:00:00'),(11,11,11,'Accusantium assumenda explicabo voluptatem rerum voluptatem commodi. Perspiciatis eum beatae sit voluptates nemo explicabo. Illum voluptatem explicabo corporis quia nam a necessitatibus. Est voluptas magni nemo vel cumque.','2021-09-05 00:00:00'),(12,12,12,'Earum omnis ipsum autem dolores optio quaerat odit. Harum earum minima optio est placeat consequatur. Placeat ducimus quos odit omnis esse.','1973-04-11 00:00:00'),(13,13,13,'Ducimus dolores repellat omnis at voluptatem rem. Dolor reiciendis consectetur eveniet. Qui ullam ut et odit.','2013-12-21 00:00:00'),(14,14,14,'Ipsum aliquid ipsum quod voluptas quia. Aliquid numquam ex sequi maxime. Quos occaecati voluptatem vitae corporis. Ut sint tempore et ea.','1977-06-14 00:00:00'),(15,15,15,'Et deserunt ipsa tempora error quisquam enim rem. Optio quia aut voluptatum recusandae aut nisi. Quia sed animi pariatur qui provident quibusdam vitae.','1973-02-19 00:00:00');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'ipsam',1),(2,'deserunt',2),(3,'quis',3),(4,'cupiditate',4),(5,'quis',5),(6,'omnis',6),(7,'architecto',7),(8,'officiis',8),(9,'nemo',9),(10,'dolorem',10),(11,'aliquid',11),(12,'est',12),(13,'praesentium',13),(14,'magnam',14),(15,'ullam',15);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'f','1984-09-10',1,'1974-02-14 08:46:10',NULL),(2,'m','1976-12-27',2,'1982-09-25 06:33:08',NULL),(3,'f','2017-04-16',3,'2008-11-22 00:15:41',NULL),(4,'f','2004-04-09',4,'2004-01-14 17:04:18',NULL),(5,'m','1989-07-29',5,'1973-07-02 13:19:32',NULL),(6,'m','1971-01-11',6,'1978-08-27 13:20:33',NULL),(7,'f','2003-06-09',7,'2008-02-21 19:05:33',NULL),(8,'f','2020-07-11',8,'1989-12-20 14:36:34',NULL),(9,'m','1985-03-18',9,'1996-10-25 00:20:58',NULL),(10,'f','1982-01-09',10,'2021-02-02 09:55:00',NULL),(11,'f','1987-12-23',11,'2005-09-17 13:56:13',NULL),(12,'f','1982-02-14',12,'1992-01-02 03:58:57',NULL),(13,'m','2014-08-02',13,'1997-10-06 11:51:52',NULL),(14,'f','1998-03-27',14,'1987-05-06 11:41:19',NULL),(15,'m','1977-05-04',15,'2018-06-22 01:04:25',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='юзеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Brennon','Cole','njacobson@example.org','1ba6fd4b94ff29b54b023cfd421444c9838ac312',89125786699),(2,'Jennings','Ziemann','eichmann.dolores@example.com','384f8dfb355d67dedb7684f27be9cd81a03ca172',89448326499),(3,'Arianna','Farrell','leffler.thaddeus@example.org','d9940cea62e401f6cd37f7f04cc7e66aaec5091e',89544759968),(4,'Kamron','Mraz','wswaniawski@example.org','2de0b4a381f5b41a458fe85a8822f47b7c483c06',89643657049),(5,'Regan','Abernathy','herzog.brett@example.net','4a6182ba3d805ae4e9b21f94627d6cad6382604d',89645881603),(6,'Cortez','Sporer','kenneth04@example.org','259f7725c93dbcd665187574d2bb5df3d3bac686',89470507138),(7,'Tabitha','Herzog','tkirlin@example.net','431bdff7d10263ca7c6f28311dd6237cc7ff5ee6',89131603128),(8,'Rolando','Hilpert','elton.crist@example.com','e5104ca7fd51911a8c715deeef1c9e5d66aaa3df',89537831059),(9,'Kari','Shields','zechariah.okuneva@example.org','9f3a360acf57a470afce6ccc5cd993a0c00b762e',89377589417),(10,'Bernita','Ratke','kbartell@example.com','7e798adc768ba93c1b3cc43bb144ceea4ead0d34',89925473825),(11,'Brannon','McClure','abartell@example.org','da7ee05585ba8d7a1f804359f3ce099e7d506c82',89026548360),(12,'Susana','Schaefer','dylan.gleason@example.org','a33b7c66de9d39317627c915b1d55c5c6be43321',89967144186),(13,'Brandy','Lind','liliane21@example.net','31797bb31343880236133e25a74bac5ef99ef518',89011605371),(14,'Judah','O\'Kon','cmonahan@example.com','d99730c67f86433016dcf60a51d3523b1cebf763',89269002355),(15,'Libby','Hackett','loyce.muller@example.net','cbdcf72e41dceeddd6a758f304a27d624350aa86',89667690440);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-26 19:06:08



-- ЗАДАНИЕ2 Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.

SELECT DISTINCT firstname 
FROM users
ORDER BY firstname;

-- ЗАДАНИЕ3 Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
ALTER TABLE profiles ADD COLUMN is_active ENUM ('true', 'false') DEFAULT 'true';
UPDATE profiles
SET
	is_active = 'false'
WHERE 
	birthday  > CURDATE() - INTERVAL 18 year;

	
-- ЗАДАНИЕ4 Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
INSERT INTO messages values
('16','1','2','Voluptatem ut quaerat quia. Pariatur esse amet ratione qui quia. In necessitatibus reprehenderit et. Nam accusantium aut qui quae nesciunt non.','2023-08-28 22:44:29'),
('17','1','5','Voluptas omnis enim quia porro debitis facilis eaque ut. Id inventore non corrupti doloremque consequuntur. Molestiae molestiae deleniti exercitationem sunt qui ea accusamus deserunt.','2022-04-29 04:35:46');
DELETE FROM messages
WHERE created_at > NOW();