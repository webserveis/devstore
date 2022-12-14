-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.24-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla devstore.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `picture` tinytext DEFAULT NULL,
  `active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla devstore.collections
DROP TABLE IF EXISTS `collections`;
CREATE TABLE IF NOT EXISTS `collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `picture` tinytext DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `label` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla devstore.link_products
DROP TABLE IF EXISTS `link_products`;
CREATE TABLE IF NOT EXISTS `link_products` (
  `product_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `link` tinytext DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  `discount` varchar(20) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla devstore.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `name` tinytext DEFAULT NULL,
  `description` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `reorder_level` smallint(6) DEFAULT NULL,
  `picture` tinytext DEFAULT NULL,
  `labels` tinytext DEFAULT NULL,
  `ctime` timestamp NULL DEFAULT current_timestamp(),
  `utime` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `available` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para vista devstore.products_available
DROP VIEW IF EXISTS `products_available`;
CREATE VIEW products_available AS
SELECT products.id, products.category_id, products.name,
  SUBSTRING_INDEX(SUBSTRING_INDEX(products.picture, ',', 1), ',', -1) AS picture
, products.labels, products.reorder_level, link_products.price, link_products.discount, products.utime FROM products
  LEFT JOIN link_products ON link_products.product_id = products.id
  INNER JOIN categories ON categories.id = products.category_id 
WHERE products.available = 1 AND products.category_id IN
  (SELECT id FROM categories WHERE active = 1) GROUP BY products.id
ORDER BY products.reorder_level;

-- Volcando estructura para tabla devstore.stores
DROP TABLE IF EXISTS `stores`;
CREATE TABLE IF NOT EXISTS `stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `website` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla devstore.suppliers
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `email` tinytext DEFAULT NULL,
  `logo` tinytext DEFAULT NULL,
  `website` tinytext DEFAULT NULL,
  `twitter` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla devstore.xrequests
DROP TABLE IF EXISTS `xrequests`;
CREATE TABLE IF NOT EXISTS `xrequests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `originip` varchar(45) NOT NULL DEFAULT '',
  `ts` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ts` (`ts`),
  KEY `originip` (`originip`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='Requests from remote IPs';

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para vista devstore.products_available
DROP VIEW IF EXISTS `products_available`;
-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `products_available`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `products_available` AS SELECT products.id, products.category_id, products.name,
	SUBSTRING_INDEX(SUBSTRING_INDEX(products.picture, ',', 1), ',', -1) AS picture
, products.labels, products.reorder_level, link_products.price, link_products.discount, products.utime FROM products
	LEFT JOIN link_products ON link_products.product_id = products.id
	INNER JOIN categories ON categories.id = products.category_id 
WHERE products.available = 1 AND products.category_id IN
	(SELECT id FROM categories WHERE active = 1) GROUP BY products.id
ORDER BY products.reorder_level 

#Obtener productos de una categoria
#SELECT * FROM productdevstoredevstore INNER JOIN link_product ON link_product.product_id = product.id WHERE product.available = 1 AND product.category_id = 1 GROUP BY product.id ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
