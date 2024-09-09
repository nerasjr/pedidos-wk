-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: wkteste
-- ------------------------------------------------------
-- Server version	11.4.2-MariaDB

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
-- Table structure for table `clientes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Cliente Teste1','Florianópolis','SC'),(2,'Cliente Teste2','Florianópolis','SC'),(3,'Cliente Teste3','Florianópolis','SC'),(4,'Cliente Teste4','Florianópolis','SC'),(5,'Cliente Teste5','Florianópolis','SC'),(6,'Cliente Teste6','Florianópolis','SC'),(7,'Cliente Teste7','Florianópolis','SC'),(8,'Cliente Teste8','Florianópolis','SC'),(9,'Cliente Teste9','Florianópolis','SC'),(10,'Cliente Teste10','Florianópolis','SC'),(11,'Cliente Teste11','Florianópolis','SC'),(12,'Cliente Teste12','Florianópolis','SC'),(13,'Cliente Teste13','Florianópolis','SC'),(14,'Cliente Teste14','Florianópolis','SC'),(15,'Cliente Teste15','Florianópolis','SC'),(16,'Cliente Teste16','Florianópolis','SC'),(17,'Cliente Teste17','Florianópolis','SC'),(18,'Cliente Teste18','Florianópolis','SC'),(19,'Cliente Teste19','Florianópolis','SC'),(20,'Cliente Teste20','Florianópolis','SC');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `numeropedido` int(11) NOT NULL AUTO_INCREMENT,
  `dataemissao` date DEFAULT NULL,
  `codigocliente` int(11) DEFAULT NULL,
  `valortotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`numeropedido`),
  KEY `idx_codigocliente` (`codigocliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`codigocliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidosprodutos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidosprodutos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numeropedido` int(11) DEFAULT NULL,
  `codigoproduto` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `valortotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `numeropedido` (`numeropedido`),
  KEY `codigoproduto` (`codigoproduto`),
  CONSTRAINT `pedidosprodutos_ibfk_1` FOREIGN KEY (`numeropedido`) REFERENCES `pedidos` (`numeropedido`),
  CONSTRAINT `pedidosprodutos_ibfk_2` FOREIGN KEY (`codigoproduto`) REFERENCES `produtos` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidosprodutos`
--

LOCK TABLES `pedidosprodutos` WRITE;
/*!40000 ALTER TABLE `pedidosprodutos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidosprodutos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `precovenda` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Produto Teste1',121.00),(2,'Produto Teste2',190.00),(3,'Produto Teste3',337.00),(4,'Produto Teste4',30.00),(5,'Produto Teste5',194.00),(6,'Produto Teste6',387.00),(7,'Produto Teste7',375.00),(8,'Produto Teste8',491.00),(9,'Produto Teste9',354.00),(10,'Produto Teste10',461.00),(11,'Produto Teste11',477.00),(12,'Produto Teste12',268.00),(13,'Produto Teste13',98.00),(14,'Produto Teste14',201.00),(15,'Produto Teste15',164.00),(16,'Produto Teste16',258.00),(17,'Produto Teste17',184.00),(18,'Produto Teste18',334.00),(19,'Produto Teste19',398.00),(20,'Produto Teste20',76.00);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wkteste'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-09 13:09:30
