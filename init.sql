
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
DROP TABLE IF EXISTS `basic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basic` (
  `domain` varchar(255) NOT NULL,
  `address` varchar(60) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `basic` WRITE;
/*!40000 ALTER TABLE `basic` DISABLE KEYS */;
INSERT INTO `basic` VALUES ('localhost','voice.teamspeak-systems.de:9987',1);
/*!40000 ALTER TABLE `basic` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `serverDefault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serverDefault` (
  `address` varchar(60) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Contains a default server, if the requested domain was not found (set active=1 to activate)';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `serverDefault` WRITE;
/*!40000 ALTER TABLE `serverDefault` DISABLE KEYS */;
INSERT INTO `serverDefault` VALUES ('127.0.0.1:9987',0);
/*!40000 ALTER TABLE `serverDefault` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `serverTables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serverTables` (
  `tableName` varchar(255) NOT NULL,
  `additionalColumns` varchar(255) DEFAULT NULL,
  `orderId` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tableName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Contains all serverTables, that should be used for the lookup';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `serverTables` WRITE;
/*!40000 ALTER TABLE `serverTables` DISABLE KEYS */;
INSERT INTO `serverTables` VALUES ('basic','',1,1);
/*!40000 ALTER TABLE `serverTables` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

