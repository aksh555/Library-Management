CREATE DATABASE  IF NOT EXISTS `LMS` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `LMS`;
-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: LMS
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AUTHORS`
--

DROP TABLE IF EXISTS `AUTHORS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHORS` (
  `Author_id` int(10) unsigned NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Country_id` varchar(100), 	
  PRIMARY KEY (`Author_id`)
  CONSTRAINT `AUTHORS_ibfk_1` FOREIGN KEY (`Country_id`) REFERENCES `COUNTRY` (`Id`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BOOK`
--

DROP TABLE IF EXISTS `BOOK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BOOK` (
  `Isbn` varchar(10) NOT NULL,
  `Title` varchar(1000) NOT NULL,
  `isCheckedOut` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Isbn`),
  UNIQUE KEY `idx_isbn` (`Isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BOOK_AUTHORS`
--

DROP TABLE IF EXISTS `BOOK_AUTHORS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BOOK_AUTHORS` (
  `Isbn` varchar(10) NOT NULL,
  `Author_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Author_id`,`Isbn`),
  KEY `Isbn` (`Isbn`),
  CONSTRAINT `BOOK_AUTHORS_ibfk_1` FOREIGN KEY (`Author_id`) REFERENCES `AUTHORS` (`Author_id`),
  CONSTRAINT `BOOK_AUTHORS_ibfk_2` FOREIGN KEY (`Isbn`) REFERENCES `BOOK` (`Isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BOOK_LOANS`
--

DROP TABLE IF EXISTS `BOOK_LOANS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BOOK_LOANS` (
  `Loan_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Isbn` varchar(10) DEFAULT NULL,
  `Card_id` varchar(10) DEFAULT NULL,
  `Date_out` datetime DEFAULT NULL,
  `Due_date` datetime DEFAULT NULL,
  `Date_in` datetime DEFAULT NULL,
  PRIMARY KEY (`Loan_id`),
  KEY `Isbn` (`Isbn`),
  KEY `Card_id` (`Card_id`),
  CONSTRAINT `BOOK_LOANS_ibfk_1` FOREIGN KEY (`Isbn`) REFERENCES `BOOK` (`Isbn`),
  CONSTRAINT `BOOK_LOANS_ibfk_2` FOREIGN KEY (`Card_id`) REFERENCES `BORROWER` (`Card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BORROWER`
--

DROP TABLE IF EXISTS `BORROWER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BORROWER` (
  `Card_id` varchar(10) NOT NULL,
  `Ssn` varchar(9) NOT NULL,
  `Bname` varchar(100) NOT NULL,
  `Address` varchar(1000) NOT NULL,
  `Phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Card_id`),
  UNIQUE KEY `Ssn` (`Ssn`),
  UNIQUE KEY `idx_cardid` (`Card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `COUNTRY`
--

DROP TABLE IF EXISTS `COUNTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COUNTRY` (
  `Id` int(11) NOT NULL,
  `Name` varchar(1000) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FINES`
--

DROP TABLE IF EXISTS `FINES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FINES` (
  `Loan_id` int(10) unsigned NOT NULL,
  `Fine_amt` double DEFAULT NULL,
  `Paid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Loan_id`),
  CONSTRAINT `FINES_ibfk_1` FOREIGN KEY (`Loan_id`) REFERENCES `BOOK_LOANS` (`Loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `fine_view`
--

DROP TABLE IF EXISTS `fine_view`;
/*!50001 DROP VIEW IF EXISTS `fine_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `fine_view` AS SELECT 
 1 AS `bname`,
 1 AS `fines`,
 1 AS `paid`,
 1 AS `card_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'LMS'
--

--
-- Dumping routines for database 'LMS'
--
/*!50003 DROP PROCEDURE IF EXISTS `calculate_fine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`akshara`@`localhost` PROCEDURE `calculate_fine`(IN loan_id int(10))
BEGIN
  declare today datetime;
  declare fine double;
  SELECT NOW() into today;
  select Due_date from BOOK_LOANS where Loan_id=loan_id;
  SELECT TIMESTAMPDIFF(DAY,today,Due_date)*5 into fine;
  insert into FINES values(loan_id,fine,0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `fine_view`
--

/*!50001 DROP VIEW IF EXISTS `fine_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`akshara`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fine_view` AS select `b`.`Bname` AS `bname`,sum(`f`.`Fine_amt`) AS `fines`,`f`.`Paid` AS `paid`,`bl`.`Card_id` AS `card_id` from ((`FINES` `f` join `BOOK_LOANS` `bl` on((`f`.`Loan_id` = `bl`.`Loan_id`))) join `BORROWER` `b` on((`bl`.`Card_id` = `b`.`Card_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-01  0:58:35
