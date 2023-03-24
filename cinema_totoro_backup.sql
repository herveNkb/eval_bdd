-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cinema_totoro
-- ------------------------------------------------------
-- Server version	10.6.11-MariaDB

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `booking_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_booking_film_show_id` FOREIGN KEY (`id`) REFERENCES `film_show` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,'2023-02-02 06:23:20'),(2,'2022-12-15 23:41:47'),(3,'2023-01-06 13:12:00'),(4,'2023-02-04 01:22:16'),(5,'2022-08-30 22:26:38'),(6,'2022-06-26 07:20:27'),(7,'2022-08-05 03:12:35');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_customer`
--

DROP TABLE IF EXISTS `booking_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_customer` (
  `booking_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`booking_id`,`customer_id`),
  KEY `FK_booking_customer_customer_id` (`customer_id`),
  CONSTRAINT `FK_booking_customer_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `FK_booking_customer_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_customer`
--

LOCK TABLES `booking_customer` WRITE;
/*!40000 ALTER TABLE `booking_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema_complex`
--

DROP TABLE IF EXISTS `cinema_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cinema_complex` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zip_code` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `phone_number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_cinema_complex_user_id` FOREIGN KEY (`id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema_complex`
--

LOCK TABLES `cinema_complex` WRITE;
/*!40000 ALTER TABLE `cinema_complex` DISABLE KEYS */;
INSERT INTO `cinema_complex` VALUES (1,'Totoro cinema','30 rue du trou noir',70313,'Ainvelle',485326908),(2,'Totoro complex','69 ave Jean Jaures',67002,'Barr',5376490),(3,'Totoro écran blanc','20 Village Green Place',25236,'Anteuil',390768225),(4,'Totoro 7eme art','247 rue du ciel',30758,'Alès',412549635);
/*!40000 ALTER TABLE `cinema_complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema_complex_booking`
--

DROP TABLE IF EXISTS `cinema_complex_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cinema_complex_booking` (
  `cinema_complex_id` int(10) unsigned NOT NULL,
  `booking_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cinema_complex_id`,`booking_id`),
  KEY `FK_cinema_complex_booking_booking_id` (`booking_id`),
  CONSTRAINT `FK_cinema_complex_booking_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `FK_cinema_complex_booking_cinema_complex_id` FOREIGN KEY (`cinema_complex_id`) REFERENCES `cinema_complex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema_complex_booking`
--

LOCK TABLES `cinema_complex_booking` WRITE;
/*!40000 ALTER TABLE `cinema_complex_booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `cinema_complex_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinema_rooms`
--

DROP TABLE IF EXISTS `cinema_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cinema_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hall_number` int(11) NOT NULL,
  `number_of_places` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_cinema_rooms_cinema_complex_id` FOREIGN KEY (`id`) REFERENCES `cinema_complex` (`id`),
  CONSTRAINT `FK_cinema_rooms_film_show_id` FOREIGN KEY (`id`) REFERENCES `film_show` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinema_rooms`
--

LOCK TABLES `cinema_rooms` WRITE;
/*!40000 ALTER TABLE `cinema_rooms` DISABLE KEYS */;
INSERT INTO `cinema_rooms` VALUES (1,1,50),(2,2,70),(3,3,80),(4,1,110);
/*!40000 ALTER TABLE `cinema_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name_customer` varchar(255) NOT NULL,
  `last_name_customer` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Iznogoud','Dupont','1986-03-22'),(2,'Marie','Pizza','1975-09-15'),(3,'Pierre','Molle','1938-10-21'),(4,'Bernard','Minet','1999-01-01'),(5,'Titi','Le Piaf','2000-07-02'),(6,'Jeanne','Moldu','2018-12-31'),(7,'Jacques','La Moule','2019-03-06');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_price_list`
--

DROP TABLE IF EXISTS `customer_price_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_price_list` (
  `customer_id` int(10) unsigned NOT NULL,
  `price_list_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`customer_id`,`price_list_id`),
  KEY `FK_customer_price_list_price_list_id` (`price_list_id`),
  CONSTRAINT `FK_customer_price_list_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_customer_price_list_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `price_list` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_price_list`
--

LOCK TABLES `customer_price_list` WRITE;
/*!40000 ALTER TABLE `customer_price_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_price_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film_show`
--

DROP TABLE IF EXISTS `film_show`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `film_show` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film_show`
--

LOCK TABLES `film_show` WRITE;
/*!40000 ALTER TABLE `film_show` DISABLE KEYS */;
INSERT INTO `film_show` VALUES (1,'2023-02-02 06:23:20'),(2,'2022-12-15 23:41:47'),(3,'2023-01-06 13:12:00'),(4,'2023-02-04 01:22:16'),(5,'2022-08-30 22:26:38'),(6,'2022-06-26 07:20:27'),(7,'2022-08-05 03:12:35'),(8,'2022-07-10 15:08:55'),(9,'2023-01-24 17:10:21'),(10,'2022-12-16 11:36:59'),(11,'2022-11-06 08:24:49'),(12,'2022-10-18 05:24:22'),(13,'2022-11-25 02:34:13'),(14,'2022-05-17 11:32:15'),(15,'2022-07-02 12:41:46'),(16,'2022-05-07 03:15:46'),(17,'2022-10-09 10:54:07'),(18,'2022-06-15 17:58:38'),(19,'2022-07-17 07:34:53'),(20,'2022-12-24 00:49:23');
/*!40000 ALTER TABLE `film_show` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `synopsis` longtext NOT NULL,
  `movie_type` varchar(100) NOT NULL,
  `duration` varchar(25) NOT NULL,
  `director` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_movie_film_show_id` FOREIGN KEY (`id`) REFERENCES `film_show` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,'Hounds, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Crime|Horror|Thriller','1h30','Franchioni'),(2,'Bad Company','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Action|Crime|Drama','2h45','Blasi'),(3,'Jesse Stone: Innocents Lost','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Crime|Drama','2h47','Creaser'),(4,'Valachi Papers,The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Crime|Drama','1h54','Klamman'),(5,'Fingers at the Window','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.U','Drama|Film-Noir|Mystery','2h33','Dunlap'),(6,'Lion King II: Simba\'s Pride, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Adventure|Animation|Children|Musical|Romance','1h48','Give'),(7,'Perfect Host, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Crime|Drama|Thriller','1h36','Kerwin'),(8,'Paperboy, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Thriller','2h54','Blood'),(9,'Aurora','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Romance|Sci-Fi','2h44','Giabucci'),(10,'Flower Drum Song','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Comedy|Musical|Romance','2h18','Peever'),(11,'Winning of Barbara Worth, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama|Romance|Western','3h52','Lenthall'),(12,'Spring Subway','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama|Romance','1h55','Brower'),(13,'They Came to Cordura','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Western','1h56','Riccetti'),(14,'Misunderstood','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama','2h34','Dobie'),(15,'Bekas','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama','3h21','Sleite'),(16,'Architect, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama','2h15','Pampling'),(17,'Shit Year','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama','3h54','Janowicz'),(18,'Brasher Doubloon, The','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Crime|Drama|Film-Noir|Mystery','2h23','Najera'),(19,'Failan','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Drama|Romance','2h14','Mills'),(20,'Sentimental Swordsman, The (To ching chien ko wu ching chien)','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.','Action|Adventure','2h41','Humburton');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'CB'),(2,'Espèces'),(3,'Chèque');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_list`
--

DROP TABLE IF EXISTS `price_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `price` float NOT NULL,
  `price_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_list`
--

LOCK TABLES `price_list` WRITE;
/*!40000 ALTER TABLE `price_list` DISABLE KEYS */;
INSERT INTO `price_list` VALUES (1,9.2,'Plein tarif'),(2,7.6,'Étudiant'),(3,5.9,'Moins de 14 ans');
/*!40000 ALTER TABLE `price_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_list_payment`
--

DROP TABLE IF EXISTS `price_list_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_list_payment` (
  `price_list_id` int(10) unsigned NOT NULL,
  `payment_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`price_list_id`,`payment_id`),
  KEY `FK_price_list_payment_payment_id` (`payment_id`),
  CONSTRAINT `FK_price_list_payment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_price_list_payment_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `price_list` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_list_payment`
--

LOCK TABLES `price_list_payment` WRITE;
/*!40000 ALTER TABLE `price_list_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `price_list_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ROLE_USER','ROLE_ADMIN') NOT NULL DEFAULT 'ROLE_USER',
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'gbraganza0@freewebs.com','$2y$10$ZzPYmLAS/.pbjx7kidD25OEIkCmB62rVdRvD4vAV7oL.IHv4L.eeC','ROLE_ADMIN','Sélène','Braganza'),(2,'lmoir1@reddit.com','$2y$10$rOPltkBiTNgqtsKNP9aFFOX1t4avYF.UYwTofzV7zKSHSer/wlWAy','ROLE_USER','Maëlle','Moir'),(3,'nparrin2@irs.gov','$2y$10$JtH/4.TN89mOzES.Sp42i.WUGx3PVOf4f63iXOF1Rj/e5ObHcemUq','ROLE_USER','Andréanne','Parrin'),(4,'dcone3@arstechnica.com','$2y$10$YVUV468TwpAdZ9HHKdBLpOzaGdVQCYqiALVedn5xsTtdh3s7fhQOy','ROLE_USER','Garçon','Cone'),(5,'arosone4@printfriendly.com','$2y$10$6R8wIFCg7pYy.fZzYExFqeqXTUlgqu.7zLOXdRWCPOwFTl02x7lSa','ROLE_USER','Athéna','Rosone');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-24 18:47:00
