-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 06 avr. 2020 à 12:15
-- Version du serveur :  5.7.24
-- Version de PHP :  7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gestionmatos`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `Eden`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Eden` (IN `sp_var1` VARCHAR(50), IN `sp_var2` VARCHAR(50))  NO SQL
BEGIN 
DECLARE query_full TEXT; 

SET @query_part = 'SELECT * FROM Table1 '; 

IF sp_var1 != null THEN 
SET @query_part = CONCAT(@query_part, 'WHERE Category = ', sp_var1, '''); 
END IF; 

if sp_var2 != null THEN 
SET @query_part = CONCAT(@query_part, ' AND State = ', sp_var2, '''); 
END IF; 

SET query_full = @query_part; 

SET @query_full = query_full; 

PREPARE STMT FROM @query_full; 
EXECUTE STMT; 
END$$

DROP PROCEDURE IF EXISTS `InterNulle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InterNulle` ()  NO SQL
SELECT * FROM `intervention` WHERE id < 5$$

DROP PROCEDURE IF EXISTS `MAJMatos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MAJMatos` (IN `MatId` INT)  NO SQL
UPDATE materiel SET Date_Installation = Now() where id = MatId$$

DROP PROCEDURE IF EXISTS `matosPerime`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `matosPerime` ()  NO SQL
select id from materiel where Date_Installation <= DATE_SUB(NOW(), INTERVAL MTBF YEAR)$$

DROP PROCEDURE IF EXISTS `Rechercher`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rechercher` (IN `client` VARCHAR(50), IN `site` VARCHAR(50))  NO SQL
SELECT m.nom as matnom, m.NoSerie as matserie, m.Date_Installation as matdate, m.MTBF as matmtbf, c.nom clientnom, s.Nom as sitenom FROM materiel m inner join client c on m.ID_Client = c.ID inner join site s on m.ID_Site = s.ID where c.nom like client and s.nom like site$$

DROP PROCEDURE IF EXISTS `sp_basicSearch`$$
CREATE DEFINER=`my_site`@`%` PROCEDURE `sp_basicSearch` (IN `sp_var1` TINYINT(1), IN `sp_var2` CHAR(2))  BEGIN 
DECLARE query_full TEXT; 

SET @query_part = 'SELECT * FROM Table1 '; 

IF sp_var1 != null THEN 
SET @query_part = CONCAT(@query_part, 'WHERE Category = ', sp_var1, '''); 
END IF; 

if sp_var2 != null THEN 
SET @query_part = CONCAT(@query_part, ' AND State = ', sp_var2, '''); 
END IF; 

SET query_full = @query_part; 

SET @query_full = query_full; 

PREPARE STMT FROM @query_full; 
EXECUTE STMT; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(50) NOT NULL,
  `Adresse` varchar(50) NOT NULL,
  `Telephone` varchar(20) NOT NULL,
  `mail` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`ID`, `Nom`, `Adresse`, `Telephone`, `mail`) VALUES
(1, 'LVMH', '1365  avenue des champs élysées', '0656666666', 'moi@ok.com'),
(2, 'arnouclient', 'rue de guuccch', '7777777777', 'gucc@gucci.com'),
(3, 'Renauld', '11 rue de billancourt', '01552', 'r@r@c.om'),
(4, 'Peugeot', 'guillaicout', '0155027942', 'loindici@peugeot.fr'),
(5, 'Tiboland', '875 boulevard haussman', '0633003300', 'sla.hghgutmail.com'),
(7, 'lebeaunom', 'labelleadresse', '4567826', 'lesupermail');

-- --------------------------------------------------------

--
-- Structure de la table `intervention`
--

DROP TABLE IF EXISTS `intervention`;
CREATE TABLE IF NOT EXISTS `intervention` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Materiel` int(11) NOT NULL,
  `Date_planifiee` date NOT NULL,
  `Commentaire` text,
  PRIMARY KEY (`ID`),
  KEY `imat` (`Materiel`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `intervention`
--

INSERT INTO `intervention` (`ID`, `Materiel`, `Date_planifiee`, `Commentaire`) VALUES
(1, 3, '2020-01-05', 'tout s\'est bien passé'),
(2, 3, '2019-04-14', 'voila'),
(3, 2, '2019-08-05', NULL),
(4, 2, '2019-08-05', NULL),
(17, 1, '2020-03-24', 'MTBF atteint'),
(33, 13, '2020-04-26', 'voici le virus'),
(34, 1, '2020-04-23', '');

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(50) NOT NULL,
  `Description` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `marque`
--

INSERT INTO `marque` (`ID`, `Nom`, `Description`) VALUES
(1, 'Logitech', 'C\'est la souris qui a peur du chat'),
(2, 'HP', NULL),
(3, 'Dell', 'C\'est la marque Dell'),
(4, 'Benq', NULL),
(5, 'Epson', NULL),
(6, 'Western Digital', 'Les disques qui tournent en rond'),
(7, 'LCDI', NULL),
(8, 'CANON', 'A toujours fait bonne impression'),
(9, 'LDLC', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

DROP TABLE IF EXISTS `materiel`;
CREATE TABLE IF NOT EXISTS `materiel` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(50) NOT NULL,
  `NoSerie` varchar(20) DEFAULT NULL,
  `Date_Installation` date DEFAULT NULL,
  `MTBF` int(11) DEFAULT NULL,
  `ID_Site` int(11) NOT NULL,
  `ID_Client` int(11) NOT NULL,
  `ID_Marque` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `idsite` (`ID_Site`),
  KEY `idiclient` (`ID_Client`),
  KEY `idmarque` (`ID_Marque`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `materiel`
--

INSERT INTO `materiel` (`ID`, `Nom`, `NoSerie`, `Date_Installation`, `MTBF`, `ID_Site`, `ID_Client`, `ID_Marque`) VALUES
(1, 'Imprimante G8', '6625635h5465', '2020-03-24', 2, 2, 1, 4),
(2, 'Portable B6', '45654terfsdg', '2020-03-24', 5, 1, 2, 5),
(3, 'la souris verte', '544', '1954-12-08', NULL, 2, 4, 2),
(8, 'PC COOL', '6625635789665', '2020-03-24', 2, 2, 4, 1),
(9, 'PC SYMPA', NULL, '2020-03-24', 8, 1, 4, 3),
(10, 'iPhone 8', NULL, '2020-03-24', 2, 1, 1, 1),
(11, 'iPhone 11', '23235', '2002-09-10', NULL, 2, 2, 2),
(12, 'Imprimante G7', '121245454', '2020-03-29', 45, 5, 2, 7),
(13, 'Portable B6', '121524055452142', '2019-12-09', 1, 4, 5, 7),
(14, 'Imprimante Canon ok', NULL, '2020-03-29', 10, 1, 1, 8),
(15, 'Nitendo', '122', '2020-03-29', 2, 4, 4, 9);

-- --------------------------------------------------------

--
-- Structure de la table `site`
--

DROP TABLE IF EXISTS `site`;
CREATE TABLE IF NOT EXISTS `site` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(50) NOT NULL,
  `Adresse` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `site`
--

INSERT INTO `site` (`ID`, `Nom`, `Adresse`) VALUES
(1, 'site site de satre', '87 rue de sartre 875500 loin'),
(2, 'Arnouville', '1 rue carteau 76002 paris'),
(4, 'Paris', ' rue de rien'),
(5, 'Tiboland', 'loin de la classe');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Login` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`ID`, `Login`, `Password`) VALUES
(1, 'admin', 'admin'),
(2, 'root', ''),
(5, 'stephane', '334');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `intervention`
--
ALTER TABLE `intervention`
  ADD CONSTRAINT `intervention_ibfk_1` FOREIGN KEY (`Materiel`) REFERENCES `materiel` (`ID`);

--
-- Contraintes pour la table `materiel`
--
ALTER TABLE `materiel`
  ADD CONSTRAINT `materiel_ibfk_2` FOREIGN KEY (`ID_Client`) REFERENCES `client` (`ID`),
  ADD CONSTRAINT `materiel_ibfk_3` FOREIGN KEY (`ID_Site`) REFERENCES `site` (`ID`),
  ADD CONSTRAINT `materiel_ibfk_4` FOREIGN KEY (`ID_Marque`) REFERENCES `marque` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
