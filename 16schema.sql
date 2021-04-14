CREATE DATABASE  IF NOT EXISTS `traindb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `traindb`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: cs336db.clalzaidb2sl.us-east-2.rds.amazonaws.com    Database: traindb
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `userid` varchar(45) NOT NULL,
  `passw` varchar(45) DEFAULT NULL,
  `ssn` int(9) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ssn`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin1','admin1',111111111,'viv',NULL),('admin2','admin2',222222222,'alex',NULL),('admin3','admin3',333333333,'milan',NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `at`
--

DROP TABLE IF EXISTS `at`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `at` (
  `train_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `arrival_time` time DEFAULT NULL,
  `dept_time` time DEFAULT NULL,
  PRIMARY KEY (`train_id`,`station_id`),
  KEY `station_id_idx` (`station_id`),
  CONSTRAINT `stationid` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`),
  CONSTRAINT `trainid` FOREIGN KEY (`train_id`) REFERENCES `train` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `at`
--

LOCK TABLES `at` WRITE;
/*!40000 ALTER TABLE `at` DISABLE KEYS */;
INSERT INTO `at` VALUES (10001,111,'07:15:00','07:20:00'),(10001,112,'07:30:00','07:35:00'),(10001,113,'07:45:00','07:47:00'),(10001,114,'07:56:00','08:00:00'),(10001,115,'08:08:00','08:10:00'),(10001,116,'08:15:00','08:20:00'),(10001,120,'08:30:00','09:00:00');
/*!40000 ALTER TABLE `at` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `resNum` int(11) NOT NULL,
  `transitname` varchar(45) DEFAULT NULL,
  `train_id` int(11) DEFAULT NULL,
  `origin_id` int(11) DEFAULT NULL,
  `dest_id` int(11) DEFAULT NULL,
  `faretype` varchar(45) DEFAULT NULL,
  `fare` int(11) DEFAULT NULL,
  PRIMARY KEY (`resNum`),
  KEY `transitline_idx` (`transitname`),
  KEY `train_id_idx` (`train_id`),
  KEY `origin_idx` (`origin_id`),
  KEY `dest_idx` (`dest_id`),
  CONSTRAINT `dest` FOREIGN KEY (`dest_id`) REFERENCES `station` (`id`),
  CONSTRAINT `origin` FOREIGN KEY (`origin_id`) REFERENCES `station` (`id`),
  CONSTRAINT `res_id` FOREIGN KEY (`resNum`) REFERENCES `reservation` (`resNum`),
  CONSTRAINT `train_id` FOREIGN KEY (`train_id`) REFERENCES `train` (`id`),
  CONSTRAINT `transitline` FOREIGN KEY (`transitname`) REFERENCES `transitLine` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1000,'northeastern corridor',10001,111,116,'roundtrip',200),(1001,'main line',10002,111,120,'one way',40),(1003,'north jersey coast line',10004,112,115,'one way',40),(1004,'northeastern corridor',10001,112,116,'one way',60),(1005,'raritan valley line',10003,111,116,'roundtrip',200),(1006,'northeastern corridor',10002,111,116,'roundtrip',200),(1007,'raritan valley line',10003,111,120,'one way',50),(1008,'main line',10002,113,111,'roundtrip',350),(1009,'north jersey coast line',10004,120,117,'roundtrip',200),(1010,'morristown line',10004,111,114,'roundtrip',300),(1011,'gladstone branch',10005,120,111,'one way',60),(1012,'morristown line',10004,111,114,'one way',150);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `userid` varchar(45) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `passw` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('hh111','harry','h','hh111',NULL),('khang','khang','t','khang',NULL),('krb173','kanishka','b','krb173',NULL),('nnp344','neon','p','nnp344',NULL),('rks123','rome','s','rks123',NULL),('valia','valia','k','valia',NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerRep`
--

DROP TABLE IF EXISTS `customerRep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerRep` (
  `userid` varchar(45) NOT NULL,
  `passw` varchar(45) DEFAULT NULL,
  `ssn` int(9) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ssn`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerRep`
--

LOCK TABLES `customerRep` WRITE;
/*!40000 ALTER TABLE `customerRep` DISABLE KEYS */;
INSERT INTO `customerRep` VALUES ('cr1','cr1',111111110,'Marc','T'),('cr2','cr2',222222220,'Berlin','S'),('cr3','cr3',333333330,'Raj','B'),('cr4','cr4',444444440,'denver','D');
/*!40000 ALTER TABLE `customerRep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `resNum` int(11) NOT NULL,
  `user` varchar(45) NOT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`resNum`,`user`),
  KEY `user_idx` (`user`),
  CONSTRAINT `user` FOREIGN KEY (`user`) REFERENCES `customer` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1000,'khang','2020-03-01','past'),(1001,'krb173','2020-04-12','past'),(1003,'rks123','2020-03-01','present'),(1004,'hh111','2020-03-10','past'),(1005,'nnp344','2020-04-01','current'),(1006,'khang','2020-04-10','current'),(1007,'hh111','2020-04-10','current'),(1008,'nnp344','2020-05-11','current'),(1009,'rks123','2020-06-11','current'),(1010,'hh111','2020-05-15','current'),(1011,'valia','2020-05-30','current'),(1012,'krb173','2020-06-14','current');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `train_id` int(11) NOT NULL,
  `transit_name` varchar(45) NOT NULL,
  `arrival` datetime DEFAULT NULL,
  `departure` datetime DEFAULT NULL,
  `travel_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`train_id`,`transit_name`),
  KEY `name_idx` (`transit_name`),
  CONSTRAINT `id` FOREIGN KEY (`train_id`) REFERENCES `train` (`id`),
  CONSTRAINT `name` FOREIGN KEY (`transit_name`) REFERENCES `transitLine` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (10001,'northeastern corridor','2007-00-00 00:00:00','0000-00-00 00:00:00',100),(10002,'northeastern corridor','2008-00-00 00:00:00','0000-00-00 00:00:00',100);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (111,'new york penn','new york','NY'),(112,'newark airport','newark','NJ'),(113,'hoboken','hoboken','NJ'),(114,'linden','linden','NJ'),(115,'edison','edison','NJ'),(116,'trenton','trenton','NJ'),(117,'bay head','bay head','NJ'),(118,'asbury park','asbury park','NJ'),(119,'high bridge','high bridge','NJ'),(120,'newark penn','newark','NJ'),(121,'gladstone','gladstone','NJ'),(122,'secaucus','newark','NJ');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stop`
--

DROP TABLE IF EXISTS `stop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stop` (
  `transit_name` varchar(45) NOT NULL,
  `station_id` int(11) NOT NULL,
  `stop_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`transit_name`,`station_id`),
  KEY `id_idx` (`station_id`),
  CONSTRAINT `sid` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`),
  CONSTRAINT `tname` FOREIGN KEY (`transit_name`) REFERENCES `transitLine` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stop`
--

LOCK TABLES `stop` WRITE;
/*!40000 ALTER TABLE `stop` DISABLE KEYS */;
INSERT INTO `stop` VALUES ('northeastern corridor',111,1),('northeastern corridor',112,2),('northeastern corridor',113,4),('northeastern corridor',114,5),('northeastern corridor',115,6),('northeastern corridor',116,7),('northeastern corridor',120,3);
/*!40000 ALTER TABLE `stop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `id` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (10001),(10002),(10003),(10004),(10005);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transitLine`
--

DROP TABLE IF EXISTS `transitLine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transitLine` (
  `name` varchar(45) NOT NULL,
  `totalfare` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transitLine`
--

LOCK TABLES `transitLine` WRITE;
/*!40000 ALTER TABLE `transitLine` DISABLE KEYS */;
INSERT INTO `transitLine` VALUES ('gladstone branch',150),('main line',250),('morristown line',150),('north jersey coast line',200),('northeastern corridor',250),('raritan valley line',300);
/*!40000 ALTER TABLE `transitLine` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-09  4:14:54
