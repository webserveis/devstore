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

-- Volcando datos para la tabla devstore.categories: ~13 rows (aproximadamente)
DELETE FROM `categories`;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `description`, `picture`, `active`) VALUES
	(1, 'clothes', NULL, NULL, b'1'),
	(2, 'bags', NULL, NULL, b'1'),
	(3, 'hats', NULL, NULL, b'1'),
	(4, 'cups', NULL, NULL, b'1'),
	(5, 'stickers', NULL, NULL, b'1'),
	(6, 'pins', NULL, NULL, b'1'),
	(7, 'paintings', NULL, NULL, b'1'),
	(8, 'clocks', NULL, NULL, b'1'),
	(9, 'keychains', NULL, NULL, b'1'),
	(10, 'magnets', NULL, NULL, b'1'),
	(11, 'keycaps', NULL, NULL, b'1'),
	(12, 'board_games', NULL, NULL, b'1'),
	(13, 'miscellaneous', NULL, NULL, b'1');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando datos para la tabla devstore.collections: ~4 rows (aproximadamente)
DELETE FROM `collections`;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` (`id`, `name`, `picture`, `start_date`, `end_date`, `label`) VALUES
	(1, 'Christmas Dev Collection', NULL, '2022-12-01', '2022-12-31', 'christmas-dev'),
	(2, 'Freak dev collection', NULL, '2022-01-01', '2024-01-01', 'freak-dev'),
	(3, 'Legacy lovers', NULL, '2022-01-01', '2024-01-01', 'legacy-lover'),
	(4, 'Humor for developers', NULL, '2022-01-01', '2024-01-01', 'dev-humor');
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;

-- Volcando datos para la tabla devstore.link_products: ~13 rows (aproximadamente)
DELETE FROM `link_products`;
/*!40000 ALTER TABLE `link_products` DISABLE KEYS */;
INSERT INTO `link_products` (`product_id`, `store_id`, `link`, `price`, `discount`) VALUES
	(1, 4, NULL, '10', NULL),
	(2, 4, NULL, '11', NULL),
	(3, 4, NULL, '12', NULL),
	(4, 3, NULL, '13', '9'),
	(5, 2, NULL, '14', '9'),
	(6, 3, NULL, '15', NULL),
	(7, 2, NULL, '16', NULL),
	(8, 4, NULL, '5', NULL),
	(9, 5, 'https://www.latostadora.com/web/stack_overflow_with_you/5477931', '12,95', NULL),
	(10, 4, 'https://www.redbubble.com/es/i/taza/-de-zombieoummy/120292405.9Q0AD', '11,05', '14,74'),
	(11, 4, 'https://www.redbubble.com/es/i/pegatina/Dinosaurio-T-Rex-Pixel-Offline-con-Cactus-Edici%C3%B3n-gris-de-zombieoummy/81747624.EJUG5', '2,02 ', '2,69'),
	(30, 4, 'https://www.redbubble.com/es/i/camiseta/Funciona-en-mi-maquina-de-Michael-Beyer/60244057.FB110', '19,25', NULL),
	(30, 1, 'https://www.amazon.es/works-Machine-Camiseta-programaci%C3%B3n/dp/B094XHLD9C/', '16,49', NULL);
/*!40000 ALTER TABLE `link_products` ENABLE KEYS */;

-- Volcando datos para la tabla devstore.products: ~30 rows (aproximadamente)
DELETE FROM `products`;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `category_id`, `supplier_id`, `sku`, `name`, `description`, `notes`, `reorder_level`, `picture`, `labels`, `ctime`, `utime`, `available`) VALUES
	(1, 1, 1, NULL, 'Sudadera 1', '- Los equipos de TI que practican DevOps a menudo utilizan contenedores en su flujo de trabajo. En tal entorno "Funciona en mi contenedor" es una excusa de programador que puedes aquí más a menudo que su popular predecesor "Funciona en mi máquina".\r\n- Un diseño para desarrolladores de software e ingenieros con sentido del humor que trabajan en aplicaciones contenerizadas. Muestra el emoticono unicode "Shrug", un famoso meme de Internet y la posible excusa principal en los equipos de DevOps.\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Cremallera\r\n- Lavar a maquina con agua fria, con colores similares, secar a calor bajo\r\n- Manga corta\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 1, 'geeksta_itsworksinmymachine.jpg,geeksta_itsworksinmymachine_2.jpg', 'tshirt, men, women', '2022-12-02 17:05:39', '2022-12-11 17:19:36', b'1'),
	(2, 1, 7, NULL, 'Camiseta 10 ♥', 'Camiseta con Logo de python para hombre, playera clásica de algodón con gráfico, cuello redondo.', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños', 2, 'tshirt_logo_python.webp,tshirt_logo_python_women.webp', 'tshirt,men,women', '2022-12-02 17:29:37', '2022-12-06 11:33:50', b'1'),
	(3, 1, 1, NULL, 'camiseta 1', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:32:36', b'1'),
	(4, 1, 3, NULL, 'Camiseta 11', '- Cuello ancho, mangas ligeramente acampanadas y un corte un ceñido para hacer una camiseta informal\r\n- Corte ceñido, así que pide una talla más si eso no te va\r\n- El modelo mide 1,80 m (5\'11") y lleva una M\r\n- Colores lisos: 100 % algodón. Colores jaspeados: 90 % algodón, 10 % poliéster.\r\n- Para conservar el estampado, lávalas en frío y cuélgalas para que se sequen', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_legacy_code_fashion_1.jpg,tshirt_legacy_code_fashion_2.jpg', 'tshirt,legacy-code,men,women', '2022-12-02 17:55:12', '2022-12-06 11:36:09', b'1'),
	(5, 2, 4, NULL, 'Bolsa de tela 2', '- Diseño por ambos lados, resistente y con estilo. Un lujo.\r\n- Disponible en tres tamaños: mira la tabla de tallas para encontrar la tuya\r\n- Capa exterior de poliéster resistente\r\n- Las correas de algodón son muy resistentes y miden 2.5 cm (1") de ancho y 68 cm (21") de largo para las pequeñas, 71 cm (28") para las medianas y 74 cm (29") para las grandes\r\n- Diseño brillante, duradero y por ambos lados impreso por sublimación al pedirlo\r\n- Puedes meterlas en la lavadora con centrifugado suave\r\n- ¿Buscas algo más ligero? Prueba con las bolsas de algodón', '- diferentes tamaños', 1, 'bag_css_is_awesome.jpg', 'bag,css', '2022-12-04 12:52:47', '2022-12-06 11:37:04', b'1'),
	(6, 2, 5, NULL, 'Bolsa de tela 1', '- Diseño por ambos lados, resistente y con estilo. Un lujo.\r\n- Disponible en tres tamaños: mira la tabla de tallas para encontrar la tuya\r\n- Capa exterior de poliéster resistente\r\n- Las correas de algodón son muy resistentes y miden 2.5 cm (1") de ancho y 68 cm (21") de largo para las pequeñas, 71 cm (28") para las medianas y 74 cm (29") para las grandes\r\n- Diseño brillante, duradero y por ambos lados impreso por sublimación al pedirlo\r\n- Puedes meterlas en la lavadora con centrifugado suave\r\n- ¿Buscas algo más ligero? Prueba con las bolsas de algodón', '- diferentes tamaños', 2, 'bag_true_or_not_true_this_is_a_question.jpg', 'bag,shakespeare,to-be-or-not-to-be', '2022-12-04 13:06:05', '2022-12-06 11:37:07', b'1'),
	(7, 2, 6, NULL, 'Bolsa det tela 3', '- Diseño por ambos lados, resistente y con estilo. Un lujo.\r\n- Disponible en tres tamaños: mira la tabla de tallas para encontrar la tuya\r\n- Capa exterior de poliéster resistente\r\n- Las correas de algodón son muy resistentes y miden 2.5 cm (1") de ancho y 68 cm (21") de largo para las pequeñas, 71 cm (28") para las medianas y 74 cm (29") para las grandes\r\n- Diseño brillante, duradero y por ambos lados impreso por sublimación al pedirlo\r\n- Puedes meterlas en la lavadora con centrifugado suave\r\n- ¿Buscas algo más ligero? Prueba con las bolsas de algodón', '- diferentes tamaños', 3, 'bag_css_is_awesome.jpg', 'bag,love,unicode', '2022-12-04 13:12:31', '2022-12-06 11:37:00', b'1'),
	(8, 2, 5, NULL, 'Bolsa de tela 4', '- Diseño por ambos lados, resistente y con estilo. Un lujo.\r\n- Disponible en tres tamaños: mira la tabla de tallas para encontrar la tuya\r\n- Capa exterior de poliéster resistente\r\n- Las correas de algodón son muy resistentes y miden 2.5 cm (1") de ancho y 68 cm (21") de largo para las pequeñas, 71 cm (28") para las medianas y 74 cm (29") para las grandes\r\n- Diseño brillante, duradero y por ambos lados impreso por sublimación al pedirlo\r\n- Puedes meterlas en la lavadora con centrifugado suave\r\n- ¿Buscas algo más ligero? Prueba con las bolsas de algodón', '- diferentes tamaños', 4, 'bag_1_add_1_10.jpg', 'bag,binary-10', '2022-12-04 13:16:39', '2022-12-06 11:36:56', b'1'),
	(9, 4, 7, NULL, 'Taza 8', 'Taza de cerámica blanca de calidad extra\r\n\r\n- Resistente a ralladuras, estropajos y lavavajillas\r\n- Apto para microondas\r\n- Capacidad útil de 325 ml (11 oz)\r\n- Altura: 96mm. Diámetro exterior: 81 mm. Diámetro interior: 74 mm', NULL, 1, 'cup_stackoverflow.jpg', 'cup,stackoverflow,freak-dev', '2022-12-05 16:39:17', '2022-12-11 19:37:23', b'1'),
	(10, 4, 1, NULL, 'Taza 1♥', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow,freak-dev', '2022-12-05 16:52:44', '2022-12-11 19:37:27', b'1'),
	(11, 5, 8, NULL, 'Pegatina 1', '- Decora y personaliza portátiles, bicicletas y más\r\n- Pegatina despegable de medio corte (kiss-cut)\r\n- Muy duraderas y resistentes al agua\r\n- Borde blanco de 3,2 mm alrededor de cada diseño\r\n- Acabado mate\r\n- Las pegatinas pueden ser impresas y enviadas desde distintos sitios según el tipo', '- varios acabados\r\n- varios tamaños', 1, 'sticker_trex_nointernet.jpg', 'sticker,trex,no-internet', '2022-12-05 16:55:38', '2022-12-06 11:34:50', b'1'),
	(12, 1, 2, NULL, 'camiseta 2', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:32:44', b'1'),
	(13, 1, 2, NULL, 'camiseta 3', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:32:38', b'1'),
	(14, 1, 3, NULL, 'camiseta 4', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women,legacy-lover', '2022-12-02 17:55:12', '2022-12-12 15:46:28', b'1'),
	(15, 1, 4, NULL, 'camiseta 5', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:33:13', b'1'),
	(16, 1, 5, NULL, 'camiseta 6 ♥', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:33:52', b'1'),
	(17, 1, 6, NULL, 'camiseta 7', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:33:18', b'1'),
	(18, 1, 7, NULL, 'camiseta 8 - I □ Unicode ', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:34:16', b'1'),
	(19, 1, 7, NULL, 'camiseta 9', '- Etiquetas: desbordamiento apilado, devops, javascript, unix, desarrollador, sysadmin, ingeniero de software, PC, ciencia informática, código, sudo, git, hacker, tecnología, raíz, ingeniería, pitón, geeky, programador, programación, codificación, linux, nerd\r\n- Ligero, Encaje clasico, Manga de doble puntada y bastilla baja\r\n- Color solido: 100% Algodon; Gris: 90% Algodon, 10% Poliester; otros colores: 50% Algodon, 50% Poliester\r\n- Cierre: Pull on\r\n- Lavar a máquina\r\n- Manga corta', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, 'tshirt_may_stackoverflow_with_you_1.jpg,tshirt_may_stackoverflow_with_you_2.jpg', 'tshirt,stackoverflow,men,women', '2022-12-02 17:55:12', '2022-12-06 11:33:21', b'1'),
	(20, 5, 2, NULL, 'Pegatina 2', '- Decora y personaliza portátiles, bicicletas y más\r\n- Pegatina despegable de medio corte (kiss-cut)\r\n- Muy duraderas y resistentes al agua\r\n- Borde blanco de 3,2 mm alrededor de cada diseño\r\n- Acabado mate\r\n- Las pegatinas pueden ser impresas y enviadas desde distintos sitios según el tipo', '- varios acabados\r\n- varios tamaños', 1, 'sticker_trex_nointernet.jpg', 'sticker,trex,no-internet', '2022-12-05 16:55:38', '2022-12-06 11:35:22', b'1'),
	(21, 5, 1, NULL, 'Pegatina 3', '- Decora y personaliza portátiles, bicicletas y más\r\n- Pegatina despegable de medio corte (kiss-cut)\r\n- Muy duraderas y resistentes al agua\r\n- Borde blanco de 3,2 mm alrededor de cada diseño\r\n- Acabado mate\r\n- Las pegatinas pueden ser impresas y enviadas desde distintos sitios según el tipo', '- varios acabados\r\n- varios tamaños', 1, 'sticker_trex_nointernet.jpg', 'sticker,trex,no-internet', '2022-12-05 16:55:38', '2022-12-06 11:35:23', b'1'),
	(22, 5, 1, NULL, 'Pegatina 4', '- Decora y personaliza portátiles, bicicletas y más\r\n- Pegatina despegable de medio corte (kiss-cut)\r\n- Muy duraderas y resistentes al agua\r\n- Borde blanco de 3,2 mm alrededor de cada diseño\r\n- Acabado mate\r\n- Las pegatinas pueden ser impresas y enviadas desde distintos sitios según el tipo', '- varios acabados\r\n- varios tamaños', 1, 'sticker_trex_nointernet.jpg', 'sticker,trex,no-internet', '2022-12-05 16:55:38', '2022-12-06 11:35:24', b'1'),
	(23, 5, 3, NULL, 'Pegatina 5', '- Decora y personaliza portátiles, bicicletas y más\r\n- Pegatina despegable de medio corte (kiss-cut)\r\n- Muy duraderas y resistentes al agua\r\n- Borde blanco de 3,2 mm alrededor de cada diseño\r\n- Acabado mate\r\n- Las pegatinas pueden ser impresas y enviadas desde distintos sitios según el tipo', '- varios acabados\r\n- varios tamaños', 1, 'sticker_trex_nointernet.jpg', 'sticker,trex,no-internet', '2022-12-05 16:55:38', '2022-12-06 11:35:27', b'1'),
	(24, 4, 2, NULL, 'Taza 2', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow', '2022-12-05 16:52:44', '2022-12-06 19:02:48', b'1'),
	(25, 4, 8, NULL, 'Taza 7', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow', '2022-12-05 16:52:44', '2022-12-06 19:02:42', b'1'),
	(26, 4, 6, NULL, 'Taza 5', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow', '2022-12-05 16:52:44', '2022-12-06 19:02:45', b'1'),
	(27, 4, 4, NULL, 'Taza 6', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow', '2022-12-05 16:52:44', '2022-12-06 19:02:43', b'1'),
	(28, 4, 1, NULL, 'Taza 3♥', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow', '2022-12-05 16:52:44', '2022-12-06 19:02:50', b'1'),
	(29, 4, 7, NULL, 'Taza 4', '- ¿Café, té or arte? Todo en uno con esta taza de cerámica\r\n- Capacidad de 325 ml (11 oz)\r\n- El diámetro de la taza es de 8.2 cm (3.2 pulgadas), sin incluir el mango\r\n- Cerámica apta para lavavajillas\r\n- Diseño por toda la superficie impreso para ti cuando lo pides', 'dos formas a escojer, plana o cónica', 2, 'cup_stackoverflow_black.jpg', 'cup,stackoverflow', '2022-12-05 16:52:44', '2022-12-06 19:02:46', b'1'),
	(30, 1, 9, NULL, 'It Works in my machine camiseta', '- Camiseta cómoda y suave, un básico en tu armario\r\n- Corte ajustado. Pide una talla más si prefieres un corte más holgado o ve a por una camiseta clásica.\r\n- El modelo mide 1,83 m (60") y lleva la talla L\r\n- La modelo mide 1,73 m (5\'8") y lleva una S\r\n- Tela de gramaje medio: 145 g/m² (4.2 oz). Colores lisos: 100 % algodón; gris jaspeado: 90 % algodón, 10 % poliéster; antracita jaspeado: 52 % algodón, 48 % poliéster', '- varios colores\r\n- modelo hombre y mujer\r\n- diferentes tamaños\r\n- Emplazamiento del diseño delantero o trasero', 3, '', 'tshirt,legacy-code,men,women', '2022-12-02 17:55:12', '2022-12-06 11:36:09', b'1');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Volcando datos para la tabla devstore.stores: ~5 rows (aproximadamente)
DELETE FROM `stores`;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` (`id`, `name`, `website`) VALUES
	(1, 'Amazon', 'https://www.amazon.es/'),
	(2, 'Etsy', 'https://www.etsy.com/'),
	(3, 'AlịExpress', 'https://best.aliexpress.com/'),
	(4, 'Redbubble', 'https://www.redbubble.com/'),
	(5, 'latostadora', 'https://www.latostadora.com/');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;

-- Volcando datos para la tabla devstore.suppliers: ~9 rows (aproximadamente)
DELETE FROM `suppliers`;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` (`id`, `name`, `description`, `email`, `logo`, `website`, `twitter`) VALUES
	(1, 'geeksta', 'Merchandise for geeks and nerds with a focus on computers and programming.', NULL, 'https://ih0.redbubble.net/avatar.1257203.140x140.jpg', 'https://geeksta.net/', NULL),
	(2, 'Shop5564007 Store', 'Chinese fabricant', NULL, NULL, 'https://es.aliexpress.com/store/5564007?spm=a2g0o.detail.1000008.6.6b8136cf7aMt2F', NULL),
	(3, 'Caldofran', 'Dumbassman', NULL, 'https://ih0.redbubble.net/avatar.1717293.140x140.jpg', 'https://twitter.com/Dumbassman1', 'Dumbassman1'),
	(4, 'ISimple', 'Hi there!\r\n\r\nFor special orders (like your name on any ticket/design) just e-mail me div.mod.123@gmail.com.\r\n\r\nFeel free to message me about any query.\r\n\r\nThank you for visiting.', NULL, 'https://ih0.redbubble.net/avatar.7557056.140x140.jpg', NULL, NULL),
	(5, 'Programming Jokes', 'Funny Programming Merch carefully designed to the highest standards.', NULL, 'https://ih1.redbubble.net/avatar.4320589.140x140.jpg', 'https://www.facebook.com/ProgrammingMemeDaily', NULL),
	(6, 'thomasesmith', 'I basically make these things so that I can buy them. Maybe you like them too.', NULL, 'https://ih0.redbubble.net/avatar.1032591.140x140.jpg', NULL, NULL),
	(7, 'Null Pointer', 'Articulos para frikis de la informatica', NULL, NULL, 'https://www.latostadora.com/shop/nullpointer', NULL),
	(8, 'Geekitees ', 'Greetings, fellow geeks!\r\n\r\nAll my sticker are belong to you! Most designs come in large sizes all the way up to 14 inches (35cm). Is the design, size, colour, or placement you are wanting not listed? BubbleMail me and let’s work it out.\r\n\r\nHappy shopping and keep geeking out. Thank you ♥\r\n\r\nPlease keep in mind that I cannot reply if you message me anonymously. If you have any issues with shipping or item conditions, please contact Redbubble directly at https://www.redbubble.com/contact', NULL, 'https://ih1.redbubble.net/avatar.6357427.140x140.jpg', NULL, NULL),
	(9, 'Michael-Beyer', NULL, NULL, 'https://ih1.redbubble.net/avatar.3460580.140x140.jpg', 'https://www.redbubble.com/es/people/Michael-Beyer/shop#profile', NULL);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;

-- Volcando datos para la tabla devstore.xrequests: ~0 rows (aproximadamente)
DELETE FROM `xrequests`;
/*!40000 ALTER TABLE `xrequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `xrequests` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
