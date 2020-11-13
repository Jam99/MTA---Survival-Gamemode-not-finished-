-- phpMyAdmin SQL Dump
-- version 4.0.10deb1ubuntu0.1
-- http://www.phpmyadmin.net
--
-- Hoszt: localhost
-- Létrehozás ideje: 2020. Aug 03. 14:45
-- Szerver verzió: 5.6.33-0ubuntu0.14.04.1
-- PHP verzió: 5.5.9-1ubuntu4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Adatbázis: `321746_mysql56`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `ID` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `lastPlayerName` varchar(22) DEFAULT NULL,
  `lastIP` varchar(15) DEFAULT '',
  `lastSerial` varchar(32) NOT NULL,
  `spawnTime` timestamp NULL DEFAULT NULL,
  `savedPosX` float DEFAULT '0',
  `savedPosY` float DEFAULT '0',
  `savedPosZ` float DEFAULT '0',
  `savedRotZ` float DEFAULT '0',
  `forceSpawnNew` tinyint(1) NOT NULL DEFAULT '1',
  `defaultGender` enum('male','female') NOT NULL DEFAULT 'male',
  `savedHealth` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `savedMoney` int(11) NOT NULL DEFAULT '0',
  `inventory` mediumtext COMMENT 'inventory JSON',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
