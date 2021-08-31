-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: appweb
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Contato`
--

DROP TABLE IF EXISTS `Contato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contato` (
  `idContato` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `dataNasc` date DEFAULT NULL,
  PRIMARY KEY (`idContato`,`idUsuario`),
  KEY `fk_Contato_Usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_Contato_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contato`
--

LOCK TABLES `Contato` WRITE;
/*!40000 ALTER TABLE `Contato` DISABLE KEYS */;
INSERT INTO `Contato` VALUES (1,1,'Pedro Paulo','1990-03-07'),(2,1,'José Jaime','1991-03-13'),(3,2,'Ana Clara','1990-02-10'),(4,2,'Juliana Silva','1998-04-14');
/*!40000 ALTER TABLE `Contato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Grupo`
--

DROP TABLE IF EXISTS `Grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Grupo` (
  `idGrupo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idGrupo`),
  KEY `fk_Grupos_Usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_Grupos_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `Usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Grupo`
--

LOCK TABLES `Grupo` WRITE;
/*!40000 ALTER TABLE `Grupo` DISABLE KEYS */;
INSERT INTO `Grupo` VALUES (1,'Trabalho',1),(2,'Família',1),(3,'Empresa',2),(4,'Colegas',2),(5,'Futebol',1);
/*!40000 ALTER TABLE `Grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MembroGrupo`
--

DROP TABLE IF EXISTS `MembroGrupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MembroGrupo` (
  `Grupo_idGrupo` int NOT NULL,
  `Contato_idContato` int NOT NULL,
  `Contato_idUsuario` int NOT NULL,
  `ingresso` date DEFAULT NULL,
  PRIMARY KEY (`Grupo_idGrupo`,`Contato_idContato`,`Contato_idUsuario`),
  KEY `fk_Grupo_has_Contato_Contato1_idx` (`Contato_idContato`,`Contato_idUsuario`),
  KEY `fk_Grupo_has_Contato_Grupo1_idx` (`Grupo_idGrupo`),
  CONSTRAINT `fk_MembroGrupo_Contato1` FOREIGN KEY (`Contato_idContato`, `Contato_idUsuario`) REFERENCES `Contato` (`idContato`, `idUsuario`),
  CONSTRAINT `fk_MembroGrupo_Grupo1` FOREIGN KEY (`Grupo_idGrupo`) REFERENCES `Grupo` (`idGrupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MembroGrupo`
--

LOCK TABLES `MembroGrupo` WRITE;
/*!40000 ALTER TABLE `MembroGrupo` DISABLE KEYS */;
INSERT INTO `MembroGrupo` VALUES (1,1,1,'2010-01-01'),(2,2,1,'2011-01-01'),(3,3,2,'2020-02-02'),(3,4,2,'2020-02-03'),(5,1,1,'2012-03-01');
/*!40000 ALTER TABLE `MembroGrupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Telefone`
--

DROP TABLE IF EXISTS `Telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Telefone` (
  `idTelefone` int NOT NULL AUTO_INCREMENT,
  `idContato` int NOT NULL,
  `rotulo` varchar(45) NOT NULL,
  `numero` varchar(45) NOT NULL,
  PRIMARY KEY (`idTelefone`),
  KEY `fk_Telefone_Contato_idx` (`idContato`),
  CONSTRAINT `fk_Telefone_Contato` FOREIGN KEY (`idContato`) REFERENCES `Contato` (`idContato`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Telefone`
--

LOCK TABLES `Telefone` WRITE;
/*!40000 ALTER TABLE `Telefone` DISABLE KEYS */;
INSERT INTO `Telefone` VALUES (1,1,'casa','(48) 3381-2800'),(2,1,'celular','(48) 99111-0000'),(3,2,'celular','(48) 99222-0000'),(4,3,'celular','(48) 99333-0000'),(5,4,'casa','(48) 3381-0000');
/*!40000 ALTER TABLE `Telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(300) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'juca','pbkdf2:sha256:150000$RkZsRDyX$1d0393991b0d68657e2a53c40bd338703691d5d78edc3a039907702a9fd548c4','Juca Nobre'),(2,'maria','pbkdf2:sha256:150000$qFXiRA3w$605a361c7e9099ee94b4fc358755851c87e9d584081cb3f652df97e3d79994a9','Maria Alice');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-31 18:44:53