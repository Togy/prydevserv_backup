# HeidiSQL Dump 
#
# --------------------------------------------------------
# Host:                 127.0.0.1
# Database:             mangospvp
# Server version:       5.1.34-community
# Server OS:            Win64
# Target-Compatibility: MySQL 5.1
# max_allowed_packet:   1048576
# HeidiSQL version:     3.2 Revision: 1129
# --------------------------------------------------------

/*!40100 SET CHARACTER SET latin1*/;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0*/;


#
# Dumping data for table 'playercreateinfo_item'
#

TRUNCATE TABLE `playercreateinfo_item`;
LOCK TABLES `playercreateinfo_item` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_item` DISABLE KEYS*/;
INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`) VALUES
	(1,1,8,1),
	(2,1,8,1),
	(3,1,8,1),
	(4,1,8,1),
	(5,1,8,1),
	(6,1,8,1),
	(7,1,8,1),
	(8,1,8,1),
	(11,1,8,1),
	(1,2,8,1),
	(3,2,8,1),
	(10,2,8,1),
	(11,2,8,1),
	(2,3,8,1),
	(3,3,8,1),
	(4,3,8,1),
	(6,3,8,1),
	(8,3,8,1),
	(10,3,8,1),
	(11,3,8,1),
	(1,4,8,1),
	(2,4,8,1),
	(3,4,8,1),
	(4,4,8,1),
	(5,4,8,1),
	(7,4,8,1),
	(8,4,8,1),
	(10,4,8,1),
	(1,5,8,1),
	(3,5,8,1),
	(4,5,8,1),
	(5,5,8,1),
	(8,5,8,1),
	(10,5,8,1),
	(11,5,8,1),
	(1,6,8,1),
	(2,6,8,1),
	(3,6,8,1),
	(4,6,8,1),
	(5,6,8,1),
	(6,6,8,1),
	(7,6,8,1),
	(8,6,8,1),
	(10,6,8,1),
	(11,6,8,1),
	(2,7,8,1),
	(6,7,8,1),
	(8,7,8,1),
	(11,7,8,1),
	(1,8,8,1),
	(5,8,8,1),
	(7,8,8,1),
	(8,8,8,1),
	(10,8,8,1),
	(11,8,8,1),
	(1,9,8,1),
	(2,9,8,1),
	(5,9,8,1),
	(7,9,8,1),
	(10,9,8,1),
	(4,11,8,1),
	(6,11,8,1);
/*!40000 ALTER TABLE `playercreateinfo_item` ENABLE KEYS*/;
UNLOCK TABLES;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS*/;
