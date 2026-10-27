-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: adote_facil
-- ------------------------------------------------------
-- Server version	8.0.42

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

--
-- Table structure for table `animais`
--

DROP TABLE IF EXISTS `animais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animais` (
  `id_animal` int NOT NULL AUTO_INCREMENT,
  `id_ong` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `especie` varchar(50) NOT NULL,
  `raca` varchar(50) NOT NULL,
  `porte` varchar(50) NOT NULL,
  `sexo` char(1) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `situacao_animal` enum('Disponível para adoção','Em processo de adoção','Adotado','Em tratamento','Indisponível') NOT NULL DEFAULT 'Disponível para adoção',
  PRIMARY KEY (`id_animal`),
  KEY `FK_ANIMAIS_ONG` (`id_ong`),
  CONSTRAINT `FK_ANIMAIS_ONG` FOREIGN KEY (`id_ong`) REFERENCES `ong` (`id_ong`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animais`
--

LOCK TABLES `animais` WRITE;
/*!40000 ALTER TABLE `animais` DISABLE KEYS */;
INSERT INTO `animais` VALUES (1,1,'Luna','Cachorro','Vira-lata','Médio','F','2023-05-10','Carinhosa e brincalhona','Disponível para adoção'),(2,1,'Thor','Cachorro','Labrador','Grande','M','2022-03-15','Dócil e ativo','Disponível para adoção'),(3,2,'Mimi','Gato','Siamês','Pequeno','F','2024-01-20','Tranquila e carinhosa','Em processo de adoção'),(4,2,'Bob','Cachorro','Poodle','Pequeno','M','2021-08-12','Gosta de companhia','Disponível para adoção');
/*!40000 ALTER TABLE `animais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id_favorito` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_animal` int NOT NULL,
  PRIMARY KEY (`id_favorito`),
  KEY `FK_FAVORITOS_USUARIO` (`id_usuario`),
  KEY `FK_FAVORITOS_ANIMAIS` (`id_animal`),
  CONSTRAINT `FK_FAVORITOS_ANIMAIS` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  CONSTRAINT `FK_FAVORITOS_USUARIO` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (1,1,1),(2,2,3),(3,3,2),(4,4,4);
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensagens`
--

DROP TABLE IF EXISTS `mensagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensagens` (
  `id_mensagem` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_usuario` int NOT NULL,
  `conteudo` text NOT NULL,
  `data_envio` datetime DEFAULT CURRENT_TIMESTAMP,
  `lida` tinyint(1) NOT NULL DEFAULT '0',
  `data_leitura` datetime DEFAULT NULL,
  PRIMARY KEY (`id_mensagem`),
  KEY `FK_MENSAGENS_PEDIDO` (`id_pedido`),
  KEY `FK_MENSAGENS_USUARIO` (`id_usuario`),
  CONSTRAINT `FK_MENSAGENS_PEDIDO` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  CONSTRAINT `FK_MENSAGENS_USUARIO` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensagens`
--

LOCK TABLES `mensagens` WRITE;
/*!40000 ALTER TABLE `mensagens` DISABLE KEYS */;
INSERT INTO `mensagens` VALUES (1,1,1,'Gostaria de saber mais sobre a Luna.','2026-10-27 15:46:21',1,'2026-10-20 14:30:00'),(2,1,4,'Olá! Podemos conversar sobre a adoção.','2026-10-27 15:46:21',1,'2026-10-20 15:00:00'),(3,2,2,'Qual é o prazo para análise?','2026-10-27 15:46:21',0,NULL),(4,3,3,'A Mimi já está vacinada?','2026-10-27 15:46:21',1,'2026-10-21 10:00:00');
/*!40000 ALTER TABLE `mensagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ong`
--

DROP TABLE IF EXISTS `ong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ong` (
  `id_ong` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cnpj` varchar(14) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `endereco` varchar(150) NOT NULL,
  PRIMARY KEY (`id_ong`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ong`
--

LOCK TABLES `ong` WRITE;
/*!40000 ALTER TABLE `ong` DISABLE KEYS */;
INSERT INTO `ong` VALUES (1,'Amigos de Patas','12345678000190','1133334444','Rua das Flores, 100 - São Paulo'),(2,'Projeto Novo Lar','98765432000180','1144445555','Avenida Central, 250 - Guarulhos');
/*!40000 ALTER TABLE `ong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_animal` int NOT NULL,
  `situacao_pedido` enum('Pendente','Em análise','Aprovado','Recusado','Cancelado','Concluido') NOT NULL DEFAULT 'Pendente',
  `data_pedido` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pedido`),
  KEY `FK_PEDIDO_USUARIO` (`id_usuario`),
  KEY `FK_PEDIDO_ANIMAIS` (`id_animal`),
  CONSTRAINT `FK_PEDIDO_ANIMAIS` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  CONSTRAINT `FK_PEDIDO_USUARIO` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,'Pendente','2026-10-27 18:26:57'),(2,2,3,'Em análise','2026-10-27 18:26:57'),(3,3,2,'Pendente','2026-10-27 18:26:57'),(4,4,4,'Aprovado','2026-10-27 18:26:57');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id_tag` int NOT NULL AUTO_INCREMENT,
  `id_animal` int NOT NULL,
  `tag` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tag`),
  KEY `FK_TAG_ANIMAIS` (`id_animal`),
  CONSTRAINT `FK_TAG_ANIMAIS` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,1,'Carinhoso'),(2,2,'Brincalhão'),(3,3,'Dócil'),(4,4,'Amigável');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(15) NOT NULL,
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  `telefone` varchar(20) NOT NULL,
  `tipo_perfil` varchar(100) NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Ana Oliveira','12345678901','ana.oliveira@example.com','senha123','2026-10-27 15:07:34','11987654321','Adotante',NULL,'São Paulo'),(2,'Bruno Santos','23456789012','bruno.santos@example.com','senha456','2026-10-27 15:07:34','11976543210','Adotante',NULL,'Campinas'),(3,'Carla Mendes','34567890123','carla.mendes@example.com','senha789','2026-10-27 15:07:34','11965432109','Adotante',NULL,'Santos'),(4,'Mariana Alves','67890123456','mariana.alves@example.com','ariana1','2026-10-27 15:07:34','11932109876','Responsável ONG',NULL,'São Paulo'),(5,'Rafael Souza','78901234567','rafael.souza@example.com','rafael123','2026-10-27 15:07:34','11921098765','Responsável ONG',NULL,'Campinas');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-27 16:13:59
