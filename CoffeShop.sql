-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2024 at 12:09 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coffe`
--

-- --------------------------------------------------------

--
-- Table structure for table `coffe`
--

CREATE TABLE `coffe` (
  `id` varchar(20) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `amount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coffe`
--

INSERT INTO `coffe` (`id`, `title`, `image`, `description`, `amount`) VALUES
('c1', 'Coffe', 'http://localhost/coffees/c1.jpeg', 'with cream', 4.5),
('c2', 'Cappuccino', 'http://localhost/coffees/c2.jpeg', 'with chocolate flavor', 5.2),
('c3', 'Flat White', 'http://localhost/coffees/c3.webp', 'steamed milk foam', 4.3),
('c4', 'Mocha', 'http://localhost/coffees/c4.png', 'chocolate flavor', 6.4),
('c5', 'Latte', 'http://localhost/coffees/c5.jpg', 'vanilla flavor', 7.5),
('c6', 'Espresso', 'http://localhost/coffees/c6.jpg', 'thick black coffee', 4.6);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date_time` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `id_user`, `amount`, `date_time`) VALUES
(1, 1, 9.7, '2024-04-06 17:01:33');

-- --------------------------------------------------------

--
-- Table structure for table `ordersitem`
--

CREATE TABLE `ordersitem` (
  `id_order` int(11) NOT NULL,
  `id_coffe` varchar(20) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ordersitem`
--

INSERT INTO `ordersitem` (`id_order`, `id_coffe`, `quantity`, `price`) VALUES
(1, 'c1', 1, NULL),
(1, 'c2', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `imagePath` varchar(200) DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `balance` float DEFAULT 0,
  `favorite` varchar(200) NOT NULL DEFAULT '[]',
  `cart` varchar(1000) NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `imagePath`, `name`, `balance`, `favorite`, `cart`) VALUES
(1, 'admin', '1', 'http://localhost/avatar/nidalee.png', 'Nguyen Van Nam', 9990.29, '[]', '[]');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `coffe`
--
ALTER TABLE `coffe`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ordersitem`
--
ALTER TABLE `ordersitem`
  ADD PRIMARY KEY (`id_order`,`id_coffe`),
  ADD KEY `id_coffe` (`id_coffe`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ordersitem`
--
ALTER TABLE `ordersitem`
  ADD CONSTRAINT `OrdersItem_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `OrdersItem_ibfk_2` FOREIGN KEY (`id_coffe`) REFERENCES `coffe` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
