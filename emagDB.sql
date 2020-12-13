-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 12, 2020 at 07:09 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `emagDB`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GETALLCLIENTS` ()  BEGIN 
SELECT NAME,EMAIL, TITLE 
FROM CLIENT CL 
INNER JOIN ORDERS ORD
ON CL.CLIENT_ID = ORD.ORDER_ID;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GETProducts` (`NAME` VARCHAR(50), `PRICE` DECIMAL(6,2)) RETURNS DECIMAL(6,2) BEGIN
DECLARE PR DECIMAL(6,2);
SET PR=SUM(PRICE);
RETURN PR;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TOTAL` (`QUANTITY` INT, `PRICE` DECIMAL) RETURNS DECIMAL(10,0) BEGIN
DECLARE TOTAL DECIMAL;
SET TOTAL=QUANTITY * PRICE;
RETURN TOTAL;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `CLIENT_ID` int(11) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `ADDRESS` varchar(20) NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `PHONE` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CLIENT`
--

INSERT INTO `CLIENT` (`CLIENT_ID`, `NAME`, `ADDRESS`, `EMAIL`, `PHONE`) VALUES
(1, 'Peter', 'Petko Karavelov 5', 'pvasilev@mail.bg', '0896765545'),
(2, 'Ivan Dimitrov', 'ul.Paisii 56', 'idmt@email.com', '0897655434'),
(3, 'Todor Ivanov', 'Saedinenie 6', 'ivtododr@mail.com', '0989898989'),
(4, 'Ioan Petrov', 'Slivnica 10', 'ioanp@mail.bg', '0987878787'),
(5, 'Ali Baba', 'Bagdat jin 1', 'alibaba@alibaba.com', '0876545765');

--
-- Triggers `CLIENT`
--
DELIMITER $$
CREATE TRIGGER `AFTER_CLIENT_DELETE` AFTER DELETE ON `CLIENT` FOR EACH ROW BEGIN
INSERT INTO LOG(INFORMATION)
VALUE('CLIENT IS DELETED');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AFTER_CLIENT_INSERT` AFTER INSERT ON `CLIENT` FOR EACH ROW BEGIN
INSERT INTO LOG(INFORMATION)
VALUE('CLIENT IS INSERTED');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT_ORDER`
--

CREATE TABLE `CLIENT_ORDER` (
  `PRICE` decimal(6,2) NOT NULL,
  `CLIENT_ID` int(11) DEFAULT NULL,
  `ORDER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `CLIENT_ORDER_VIEW`
-- (See below for the actual view)
--
CREATE TABLE `CLIENT_ORDER_VIEW` (
`NAME` varchar(30)
,`ADDRESS` varchar(20)
,`PHONE` varchar(10)
,`ORDER_ITEMS` varchar(30)
);

-- --------------------------------------------------------

--
-- Table structure for table `DELIVERY`
--

CREATE TABLE `DELIVERY` (
  `DELIVERY_ID` int(11) NOT NULL,
  `TIME_RECIEVE` datetime NOT NULL,
  `TIME_SEND` datetime NOT NULL,
  `ORDER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `FAVORITES`
--

CREATE TABLE `FAVORITES` (
  `FAVORITE_ID` int(11) NOT NULL,
  `PRODUCT_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `FAVORITES`
--

INSERT INTO `FAVORITES` (`FAVORITE_ID`, `PRODUCT_ID`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `LOG`
--

CREATE TABLE `LOG` (
  `LOG_ID` int(11) NOT NULL,
  `INFORMATION` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ORDERS`
--

CREATE TABLE `ORDERS` (
  `ORDER_ID` int(11) NOT NULL,
  `TITLE` varchar(30) NOT NULL,
  `ORDER_ITEMS` varchar(30) NOT NULL,
  `ORDER_RECIEVE_TIME` datetime NOT NULL,
  `ORDER_SEND_TIME` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ORDERS`
--

INSERT INTO `ORDERS` (`ORDER_ID`, `TITLE`, `ORDER_ITEMS`, `ORDER_RECIEVE_TIME`, `ORDER_SEND_TIME`) VALUES
(1, 'ORDER001', 'CANDY WASHMACHINE,IPHONE 5C', '2010-05-17 22:52:21', '2010-05-18 22:52:21'),
(2, 'ORDER002', 'CANDY Coffee Mashine,IPHONE 6s', '2015-05-17 22:52:21', '2015-05-18 22:52:21'),
(3, 'ORDER003', 'SONY BRAVIA 55\",IPHONE X', '2019-05-17 22:52:21', '2019-05-18 22:52:21'),
(4, 'ORDER004', 'IPHONE 11', '2020-05-17 22:52:21', '2020-05-18 22:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `ORDER_PRODUCT`
--

CREATE TABLE `ORDER_PRODUCT` (
  `ORDER_ID` int(11) DEFAULT NULL,
  `PRODUCT_ID` int(11) DEFAULT NULL,
  `QUANTITY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `PRODUCT`
--

CREATE TABLE `PRODUCT` (
  `PRODUCT_ID` int(11) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `DESCRIPTION` varchar(40) NOT NULL,
  `QUANTITY` int(11) DEFAULT NULL,
  `PRICE` decimal(6,2) NOT NULL,
  `ORDER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `PRODUCT`
--

INSERT INTO `PRODUCT` (`PRODUCT_ID`, `NAME`, `DESCRIPTION`, `QUANTITY`, `PRICE`, `ORDER_ID`) VALUES
(1, 'IPHONE 11', 'APPLE IPHONE 11', 10, '1900.00', 4),
(2, 'IPHONE 12', 'APPLE IPHONE 12', 15, '2500.00', NULL),
(3, 'IPHONE 8', 'APPLE IPHONE 8', 5, '600.00', NULL),
(4, 'CANDY WASHAMCHINE', 'CANDY WASHAMCHINE', 20, '200.00', 1),
(5, 'SONY BRAVIA 55\"', 'SONY BRAVIA 55 Smart TV', 15, '800.00', 3);

-- --------------------------------------------------------

--
-- Structure for view `CLIENT_ORDER_VIEW`
--
DROP TABLE IF EXISTS `CLIENT_ORDER_VIEW`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `CLIENT_ORDER_VIEW`  AS  select `CL`.`NAME` AS `NAME`,`CL`.`ADDRESS` AS `ADDRESS`,`CL`.`PHONE` AS `PHONE`,`ORD`.`ORDER_ITEMS` AS `ORDER_ITEMS` from (`CLIENT` `CL` join `ORDERS` `ORD`) where `CL`.`CLIENT_ID` = `ORD`.`ORDER_ID` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD PRIMARY KEY (`CLIENT_ID`);

--
-- Indexes for table `CLIENT_ORDER`
--
ALTER TABLE `CLIENT_ORDER`
  ADD KEY `FK_CLIENT` (`CLIENT_ID`),
  ADD KEY `FK_ORDER` (`ORDER_ID`);

--
-- Indexes for table `DELIVERY`
--
ALTER TABLE `DELIVERY`
  ADD PRIMARY KEY (`DELIVERY_ID`),
  ADD KEY `FK3_ORDER` (`ORDER_ID`);

--
-- Indexes for table `FAVORITES`
--
ALTER TABLE `FAVORITES`
  ADD PRIMARY KEY (`FAVORITE_ID`),
  ADD KEY `PRODUCT_IDFK6` (`PRODUCT_ID`);

--
-- Indexes for table `LOG`
--
ALTER TABLE `LOG`
  ADD PRIMARY KEY (`LOG_ID`);

--
-- Indexes for table `ORDERS`
--
ALTER TABLE `ORDERS`
  ADD PRIMARY KEY (`ORDER_ID`);

--
-- Indexes for table `ORDER_PRODUCT`
--
ALTER TABLE `ORDER_PRODUCT`
  ADD KEY `ORDER_IDFK7` (`ORDER_ID`),
  ADD KEY `PRODUCT_IDFK7` (`PRODUCT_ID`);

--
-- Indexes for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  ADD PRIMARY KEY (`PRODUCT_ID`),
  ADD KEY `FK2_ORDER` (`ORDER_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CLIENT`
--
ALTER TABLE `CLIENT`
  MODIFY `CLIENT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `DELIVERY`
--
ALTER TABLE `DELIVERY`
  MODIFY `DELIVERY_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `FAVORITES`
--
ALTER TABLE `FAVORITES`
  MODIFY `FAVORITE_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `LOG`
--
ALTER TABLE `LOG`
  MODIFY `LOG_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ORDERS`
--
ALTER TABLE `ORDERS`
  MODIFY `ORDER_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  MODIFY `PRODUCT_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CLIENT_ORDER`
--
ALTER TABLE `CLIENT_ORDER`
  ADD CONSTRAINT `FK_CLIENT` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`CLIENT_ID`),
  ADD CONSTRAINT `FK_ORDER` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`);

--
-- Constraints for table `DELIVERY`
--
ALTER TABLE `DELIVERY`
  ADD CONSTRAINT `FK3_ORDER` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`);

--
-- Constraints for table `FAVORITES`
--
ALTER TABLE `FAVORITES`
  ADD CONSTRAINT `PRODUCT_IDFK6` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`);

--
-- Constraints for table `ORDER_PRODUCT`
--
ALTER TABLE `ORDER_PRODUCT`
  ADD CONSTRAINT `ORDER_IDFK7` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`),
  ADD CONSTRAINT `PRODUCT_IDFK7` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `PRODUCT` (`PRODUCT_ID`);

--
-- Constraints for table `PRODUCT`
--
ALTER TABLE `PRODUCT`
  ADD CONSTRAINT `FK2_ORDER` FOREIGN KEY (`ORDER_ID`) REFERENCES `ORDERS` (`ORDER_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
