-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2021 at 01:59 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tecozk_agritech2`
--

-- --------------------------------------------------------

--
-- Table structure for table `activitylog`
--

CREATE TABLE `activitylog` (
  `activity_id` int(10) NOT NULL,
  `activity_time` varchar(255) NOT NULL DEFAULT current_timestamp(),
  `activity_desc` varchar(1000) NOT NULL,
  `activity_type` varchar(255) NOT NULL,
  `chamber_name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `activitylog`
--

INSERT INTO `activitylog` (`activity_id`, `activity_time`, `activity_desc`, `activity_type`, `chamber_name`, `user_name`) VALUES
(1, 'current_timestamp(6)', 'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Animi dolor dolorum rerum distinctio eaque, sed nam? Nostrum, assumenda? Minus corporis repellat aperiam veniam asperiores voluptatum consequatur veritatis quos ipsam porro.', '01', '01', 'admin'),
(2, '2021-05-14 17:32:42', '01', '01', '01', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `admin_login`
--

CREATE TABLE `admin_login` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `chamber`
--

CREATE TABLE `chamber` (
  `chamber_id` int(10) NOT NULL,
  `chamber_name` varchar(255) NOT NULL,
  `chamber_disp_name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `farm_name` varchar(255) NOT NULL,
  `chamber_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chamber`
--

INSERT INTO `chamber` (`chamber_id`, `chamber_name`, `chamber_disp_name`, `user_name`, `farm_name`, `chamber_type`) VALUES
(13, 'Abd_micro_chamber', 'Micro Nursery Chamber', 'admin', 'Abdullah_Farm', '');

-- --------------------------------------------------------

--
-- Table structure for table `chamber2`
--

CREATE TABLE `chamber2` (
  `chamber_id` int(10) NOT NULL,
  `type` varchar(50) NOT NULL,
  `Crop` varchar(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Phone` varchar(30) NOT NULL,
  `harvestdate` date NOT NULL,
  `Login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chamber2`
--

INSERT INTO `chamber2` (`chamber_id`, `type`, `Crop`, `Amount`, `Phone`, `harvestdate`, `Login_id`) VALUES
(1, 'Glass Chamber', 'tomato', 5000, '', '2021-09-09', 1);

-- --------------------------------------------------------

--
-- Table structure for table `component`
--

CREATE TABLE `component` (
  `component_id` int(10) NOT NULL,
  `component_name` varchar(255) NOT NULL,
  `component_disp_name` varchar(255) NOT NULL,
  `component_master_type` varchar(255) NOT NULL,
  `component_type` varchar(255) NOT NULL,
  `zone_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `component`
--

INSERT INTO `component` (`component_id`, `component_name`, `component_disp_name`, `component_master_type`, `component_type`, `zone_name`) VALUES
(9, 'light_Intensity1', 'LDR module', 'Sensor', 'Light Intensity', ''),
(10, 'temperature_1', 'DHT 22', 'Sensor', 'Temperature', ''),
(11, 'Humidity_1', 'DHT 22', 'Sensor', 'Humidity', ''),
(12, 'soil_moisture1', 'HW-080', 'Sensor', 'Soil Moisture', ''),
(13, 'pump_1', 'Submersible Pump', 'Actuator', 'Pump', ''),
(14, 'bulb_1', 'bulb', 'Actuator', 'Leds', ''),
(15, 'fan_1', 'DC Fans / Cooling Systems', 'Actuator', 'Fan', '');

-- --------------------------------------------------------

--
-- Table structure for table `component_log`
--

CREATE TABLE `component_log` (
  `component_id` int(10) NOT NULL,
  `farm_id` int(10) NOT NULL,
  `zone_id` int(10) NOT NULL,
  `chamber_id` int(10) NOT NULL,
  `start_time` varchar(255) NOT NULL,
  `end_time` varchar(255) NOT NULL,
  `start_executed` varchar(255) NOT NULL,
  `end_executed` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `component_stream`
--

CREATE TABLE `component_stream` (
  `component_stream_id` int(10) NOT NULL,
  `component_name` varchar(255) NOT NULL,
  `component_value` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `zone_name` varchar(255) NOT NULL,
  `chamber_name` varchar(255) NOT NULL,
  `farm_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `component_stream`
--

INSERT INTO `component_stream` (`component_stream_id`, `component_name`, `component_value`, `timestamp`, `zone_name`, `chamber_name`, `farm_name`) VALUES
(1, 'Humidity_1', '84', '2021-05-15 00:42:23', 'zone1', 'Abd_micro_chamber', 'Abdullah_Farm');

-- --------------------------------------------------------

--
-- Table structure for table `com_triggers`
--

CREATE TABLE `com_triggers` (
  `trigger_id` int(10) NOT NULL,
  `trigger_name` varchar(255) NOT NULL,
  `trigger_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `farm`
--

CREATE TABLE `farm` (
  `farm_id` int(10) NOT NULL,
  `farm_name` varchar(255) NOT NULL,
  `farm_size_len` varchar(255) NOT NULL,
  `farm_size_wid` varchar(255) NOT NULL,
  `farm_location` varchar(255) NOT NULL,
  `farm_create_date` varchar(255) NOT NULL DEFAULT current_timestamp(),
  `farm_status` varchar(255) NOT NULL DEFAULT 'Inactive',
  `user_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farm`
--

INSERT INTO `farm` (`farm_id`, `farm_name`, `farm_size_len`, `farm_size_wid`, `farm_location`, `farm_create_date`, `farm_status`, `user_name`) VALUES
(43, 'Abdullah_Farm', '48', '36', 'Malir,Karachi', '2021-05-09 21:45:01', 'Active', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `farm_config`
--

CREATE TABLE `farm_config` (
  `farm_config_id` int(10) NOT NULL,
  `farm_id` int(10) NOT NULL,
  `chamber_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `schedule_id` int(10) NOT NULL,
  `component_id` int(10) NOT NULL,
  `farm_id` int(10) NOT NULL,
  `zone_id` int(10) NOT NULL,
  `chamber_id` int(10) NOT NULL,
  `start_time` varchar(255) NOT NULL,
  `end_time` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stream_chamber`
--

CREATE TABLE `stream_chamber` (
  `stream_id` int(11) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `temperature` int(11) NOT NULL,
  `humidity` int(11) NOT NULL,
  `moisture` int(11) NOT NULL,
  `ldr` int(11) NOT NULL,
  `chamber_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stream_chamber`
--

INSERT INTO `stream_chamber` (`stream_id`, `time`, `date`, `temperature`, `humidity`, `moisture`, `ldr`, `chamber_id`) VALUES
(1, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(2, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(3, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(4, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(5, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(6, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(7, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(8, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(9, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(10, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(11, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1),
(12, '18:11:48', '2021-03-29', 27, 59, 700, 450, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(10) NOT NULL,
  `ticket_title` varchar(255) NOT NULL,
  `ticket_desc` varchar(2000) NOT NULL,
  `created on` varchar(255) NOT NULL DEFAULT current_timestamp(),
  `ticket_status` varchar(255) NOT NULL DEFAULT 'Open',
  `user_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_login`
--

CREATE TABLE `user_login` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'customer',
  `lastlogin` varchar(255) NOT NULL DEFAULT 'never'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_login`
--

INSERT INTO `user_login` (`id`, `username`, `password`, `email`, `phone`, `status`, `role`, `lastlogin`) VALUES
(1, 'admin', 'admin', 'admin', 'admin', 'active', 'super_admin', '5/15/2021, 5:08:18 AM');

-- --------------------------------------------------------

--
-- Table structure for table `value_type`
--

CREATE TABLE `value_type` (
  `value_type_id` int(10) NOT NULL,
  `value_type_name` varchar(255) NOT NULL,
  `value_type_desc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weather`
--

CREATE TABLE `weather` (
  `id` int(255) NOT NULL,
  `temp` varchar(10) NOT NULL,
  `hum` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weather`
--

INSERT INTO `weather` (`id`, `temp`, `hum`) VALUES
(1, '27.02', '57'),
(2, '27.9', '52.63'),
(3, '30.20', '75'),
(91, '33.60', '57.20'),
(92, '33.10', '58.40'),
(93, '33.00', '58.50'),
(94, '32.80', '58.70'),
(95, '32.70', '58.90'),
(96, '32.60', '59.20'),
(97, '32.40', '59.40'),
(98, '32.30', '59.80'),
(99, '32.20', '60.40'),
(100, '32.10', '60.10'),
(101, '32.00', '60.40'),
(102, '31.90', '60.90'),
(103, '31.80', '61.10'),
(104, '31.80', '61.40'),
(105, '31.70', '61.50'),
(106, '31.50', '61.80'),
(107, '31.60', '63.30'),
(108, '31.50', '62.80'),
(109, '31.50', '62.50'),
(110, '31.30', '62.40'),
(111, '31.30', '62.50'),
(112, '31.30', '62.80'),
(113, '31.20', '63.10'),
(114, '31.20', '63.10'),
(115, '31.10', '62.90'),
(116, '31.10', '63.00'),
(117, '31.00', '63.80'),
(118, '31.00', '63.70'),
(119, '30.90', '63.40'),
(120, '30.90', '63.50'),
(121, '30.90', '63.70'),
(122, '30.90', '63.80'),
(123, '30.80', '62.80'),
(124, '30.80', '64.80'),
(125, '30.90', '64.40'),
(126, '30.80', '64.30'),
(127, '30.70', '64.40'),
(128, '30.70', '64.50'),
(129, '30.70', '64.60'),
(130, '30.70', '64.60'),
(131, '30.70', '64.70'),
(132, '30.70', '64.70'),
(133, '30.60', '64.60'),
(134, '30.60', '64.80'),
(135, '30.60', '64.80'),
(136, '30.60', '64.90'),
(137, '30.60', '65.00'),
(138, '30.60', '65.00'),
(139, '30.60', '65.10'),
(140, '30.60', '65.30'),
(141, '30.60', '65.30'),
(142, '30.60', '65.30'),
(143, '30.60', '65.30'),
(144, '30.60', '65.30'),
(145, '30.60', '65.30'),
(146, '30.60', '65.30'),
(147, '30.60', '65.30'),
(148, '30.60', '65.00'),
(149, '30.70', '65.00'),
(150, '30.70', '65.00'),
(151, '30.70', '65.00'),
(152, '30.70', '64.90'),
(153, '30.70', '64.90'),
(154, '30.70', '64.90'),
(155, '30.70', '64.80'),
(156, '30.70', '64.80'),
(157, '30.70', '64.80'),
(158, '30.70', '64.80'),
(159, '30.70', '64.80'),
(160, '30.70', '64.60'),
(161, '30.70', '64.60'),
(162, '30.70', '64.60'),
(163, '30.70', '64.70'),
(164, '30.70', '64.70'),
(165, '30.70', '64.80'),
(166, '30.70', '64.70'),
(167, '30.70', '64.80'),
(168, '30.70', '64.80'),
(169, '30.70', '64.80'),
(170, '30.70', '64.70'),
(171, '30.70', '64.80'),
(172, '30.70', '64.80'),
(173, '30.70', '64.70'),
(174, '30.70', '64.80'),
(175, '30.70', '64.70'),
(176, '30.70', '64.70'),
(177, '30.70', '64.70'),
(178, '30.70', '64.60'),
(179, '30.80', '64.70'),
(180, '30.80', '64.70'),
(181, '30.70', '64.60'),
(182, '30.80', '64.70'),
(183, '30.80', '64.60'),
(184, '30.80', '64.70'),
(185, '30.70', '64.60'),
(186, '30.80', '64.70'),
(187, '30.70', '64.60'),
(188, '30.80', '64.70'),
(189, '30.80', '64.80'),
(190, '30.80', '64.80'),
(191, '30.70', '64.70'),
(192, '30.80', '64.90'),
(193, '30.70', '64.90'),
(194, '30.80', '65.10'),
(195, '30.70', '65.20'),
(196, '30.80', '65.20'),
(197, '30.80', '65.20'),
(198, '30.80', '65.10'),
(199, '30.80', '65.10'),
(200, '30.80', '65.20'),
(201, '30.80', '65.20'),
(202, '30.80', '65.20'),
(203, '30.80', '65.10'),
(204, '30.80', '65.10'),
(205, '30.80', '65.20'),
(206, '30.70', '65.20'),
(207, '30.70', '65.30'),
(208, '30.70', '65.30'),
(209, '30.70', '65.30'),
(210, '30.70', '65.40'),
(211, '30.80', '65.70'),
(212, '30.70', '65.40'),
(213, '30.80', '65.40'),
(214, '30.80', '65.40'),
(215, '30.80', '65.40'),
(216, '30.80', '65.40'),
(217, '30.80', '65.40'),
(218, '30.80', '65.50'),
(219, '30.80', '65.40'),
(220, '30.80', '65.40'),
(221, '30.70', '65.30'),
(222, '30.80', '65.50'),
(223, '30.80', '65.50'),
(224, '30.80', '65.60'),
(225, '30.80', '65.60'),
(226, '30.80', '65.70'),
(227, '30.80', '65.70'),
(228, '30.80', '65.60'),
(229, '30.80', '65.80'),
(230, '30.80', '65.90'),
(231, '30.80', '65.80'),
(232, '30.80', '65.70'),
(233, '30.80', '65.80'),
(234, '30.80', '65.90'),
(235, '30.80', '65.90'),
(236, '30.80', '65.90'),
(237, '30.80', '65.90'),
(238, '30.80', '66.00'),
(239, '30.80', '66.10'),
(240, '30.80', '66.10'),
(241, '30.70', '66.00'),
(242, '30.70', '66.10'),
(243, '30.70', '66.10'),
(244, '30.70', '66.20'),
(245, '30.70', '66.20'),
(246, '30.70', '66.30'),
(247, '30.70', '66.30'),
(248, '30.70', '66.40'),
(249, '30.70', '66.40'),
(250, '30.60', '66.20'),
(251, '30.70', '66.30'),
(252, '30.70', '66.40'),
(253, '30.60', '66.30'),
(254, '30.70', '66.40'),
(255, '30.60', '66.40'),
(256, '30.60', '66.40'),
(257, '30.60', '66.40'),
(258, '30.60', '66.40'),
(259, '30.60', '66.30'),
(260, '30.60', '66.20'),
(261, '30.70', '66.20'),
(262, '30.70', '66.10'),
(263, '30.70', '66.10'),
(264, '30.70', '66.20'),
(265, '30.70', '66.20'),
(266, '30.70', '66.10'),
(267, '30.70', '66.10'),
(268, '30.70', '66.00'),
(269, '30.70', '66.00'),
(270, '30.70', '66.00'),
(271, '30.70', '66.00'),
(272, '30.70', '66.10'),
(273, '30.70', '66.10'),
(274, '30.70', '66.10'),
(275, '30.80', '66.10'),
(276, '30.80', '66.00'),
(277, '30.80', '66.10'),
(278, '30.80', '66.00'),
(279, '30.80', '66.00'),
(280, '30.80', '65.90'),
(281, '30.80', '65.80'),
(282, '30.80', '65.80'),
(283, '30.80', '65.70'),
(284, '30.80', '65.60'),
(285, '30.80', '65.40'),
(286, '30.80', '65.40'),
(287, '30.80', '65.40'),
(288, '30.80', '65.40'),
(289, '30.80', '65.40'),
(290, '30.70', '65.20'),
(291, '30.80', '65.30'),
(292, '30.70', '65.00'),
(293, '30.70', '64.90'),
(294, '30.70', '65.00'),
(295, '30.80', '65.20'),
(296, '30.70', '65.10'),
(297, '30.80', '65.40'),
(298, '30.80', '65.30'),
(299, '30.80', '65.30'),
(300, '30.80', '65.30'),
(301, '30.70', '65.10'),
(302, '30.70', '65.00'),
(303, '30.70', '65.10'),
(304, '30.70', '65.10'),
(305, '30.70', '65.10'),
(306, '30.70', '65.20'),
(307, '30.70', '65.30'),
(308, '30.70', '65.20'),
(309, '30.70', '65.30'),
(310, '30.70', '65.30'),
(311, '30.70', '65.20'),
(312, '30.70', '65.30'),
(313, '30.70', '65.10'),
(314, '30.70', '65.10'),
(315, '30.70', '65.10'),
(316, '30.70', '65.00'),
(317, '30.70', '65.00'),
(318, '30.70', '65.10'),
(319, '30.70', '65.10'),
(320, '30.70', '65.00'),
(321, '30.70', '64.90'),
(322, '30.70', '64.90'),
(323, '30.80', '65.00'),
(324, '30.70', '64.80'),
(325, '30.70', '64.90'),
(326, '30.80', '64.90'),
(327, '30.80', '65.00'),
(328, '30.80', '65.00'),
(329, '30.80', '65.00'),
(330, '30.80', '64.80'),
(331, '30.80', '64.50'),
(332, '30.80', '64.40'),
(333, '30.70', '64.20'),
(334, '30.70', '64.20'),
(335, '30.70', '64.20'),
(336, '30.70', '64.40'),
(337, '30.70', '64.50'),
(338, '30.70', '64.60'),
(339, '30.70', '64.50'),
(340, '30.60', '64.40'),
(341, '30.70', '64.40'),
(342, '30.70', '64.50'),
(343, '30.60', '64.60'),
(344, '30.60', '64.80'),
(345, '30.60', '64.80'),
(346, '30.60', '64.80'),
(347, '30.70', '64.90'),
(348, '30.60', '64.80'),
(349, '30.60', '64.80'),
(350, '30.60', '64.80'),
(351, '30.70', '64.70'),
(352, '30.60', '64.70'),
(353, '30.60', '64.50'),
(354, '30.70', '64.50'),
(355, '30.60', '64.40'),
(356, '30.70', '64.40'),
(357, '30.60', '64.40'),
(358, '30.60', '64.40'),
(359, '30.70', '64.50'),
(360, '30.60', '64.50'),
(361, '30.60', '64.30'),
(362, '30.70', '64.50'),
(363, '30.70', '64.60'),
(364, '30.60', '64.50'),
(365, '30.60', '64.40'),
(366, '30.60', '64.50'),
(367, '30.60', '64.60'),
(368, '30.60', '64.50'),
(369, '30.70', '64.60'),
(370, '30.60', '64.50'),
(371, '30.60', '64.60'),
(372, '30.70', '64.70'),
(373, '30.70', '64.70'),
(374, '30.70', '64.60'),
(375, '30.70', '64.60'),
(376, '30.70', '64.50'),
(377, '30.70', '64.50'),
(378, '30.70', '64.60'),
(379, '30.70', '64.50'),
(380, '30.70', '64.50'),
(381, '30.70', '64.60'),
(382, '30.70', '64.10'),
(383, '30.80', '64.30'),
(384, '30.80', '64.40'),
(385, '30.80', '64.40'),
(386, '30.80', '64.20'),
(387, '30.80', '64.20'),
(388, '30.80', '64.20'),
(389, '30.80', '64.00'),
(390, '30.80', '64.00'),
(391, '30.80', '64.00'),
(392, '30.80', '63.90'),
(393, '30.80', '63.90'),
(394, '30.80', '63.90'),
(395, '30.80', '63.70'),
(396, '30.80', '63.60'),
(397, '30.80', '63.70'),
(398, '30.80', '63.70'),
(399, '30.80', '63.80'),
(400, '30.80', '63.90'),
(401, '30.70', '63.90'),
(402, '30.70', '63.90'),
(403, '30.70', '64.00'),
(404, '30.70', '64.00'),
(405, '30.70', '64.00'),
(406, '30.70', '64.10'),
(407, '30.70', '64.00'),
(408, '30.70', '63.90'),
(409, '30.70', '63.90'),
(410, '30.70', '63.90'),
(411, '30.70', '63.80'),
(412, '30.70', '63.70'),
(413, '30.70', '63.70'),
(414, '30.70', '63.70'),
(415, '30.70', '63.60'),
(416, '30.70', '63.60'),
(417, '30.70', '63.70'),
(418, '30.70', '63.80'),
(419, '30.60', '63.70'),
(420, '30.60', '63.70'),
(421, '30.70', '63.80'),
(422, '30.60', '63.70'),
(423, '30.60', '63.70'),
(424, '30.70', '63.90'),
(425, '30.60', '63.90'),
(426, '30.60', '63.80'),
(427, '30.60', '63.90'),
(428, '30.70', '63.90'),
(429, '30.60', '64.00'),
(430, '30.70', '64.10'),
(431, '30.70', '64.00'),
(432, '30.70', '64.10'),
(433, '30.60', '64.00'),
(434, '30.60', '64.00'),
(435, '30.70', '63.90'),
(436, '30.70', '64.00'),
(437, '30.60', '64.10'),
(438, '30.60', '64.00'),
(439, '30.60', '64.10'),
(440, '30.60', '63.90'),
(441, '30.60', '64.00'),
(442, '30.60', '63.90'),
(443, '30.60', '63.90'),
(444, '30.60', '63.90'),
(445, '30.60', '64.00'),
(446, '30.60', '63.80'),
(447, '30.60', '63.90'),
(448, '30.60', '63.80'),
(449, '30.60', '63.90'),
(450, '30.60', '63.80'),
(451, '30.60', '63.80'),
(452, '30.60', '64.00'),
(453, '30.60', '64.00'),
(454, '30.60', '64.00'),
(455, '30.70', '64.00'),
(456, '30.70', '63.90'),
(457, '30.70', '64.00'),
(458, '30.60', '63.90'),
(459, '30.60', '64.00'),
(460, '30.60', '64.00'),
(461, '30.60', '64.10'),
(462, '30.60', '64.00'),
(463, '30.70', '64.20'),
(464, '30.60', '64.10'),
(465, '30.60', '64.10'),
(466, '30.70', '64.20'),
(467, '30.70', '64.20'),
(468, '30.70', '64.10'),
(469, '30.70', '64.20'),
(470, '30.70', '64.20'),
(471, '30.70', '64.20'),
(472, '30.70', '64.30'),
(473, '30.70', '64.30'),
(474, '30.70', '64.30'),
(475, '30.70', '64.30'),
(476, '30.70', '64.30'),
(477, '30.70', '64.30'),
(478, '30.70', '64.30'),
(479, '30.70', '64.30'),
(480, '30.70', '64.20'),
(481, '30.80', '64.30'),
(482, '30.70', '64.20'),
(483, '30.70', '64.10'),
(484, '30.80', '64.20'),
(485, '30.70', '64.20'),
(486, '30.80', '64.20'),
(487, '30.70', '64.00'),
(488, '30.80', '64.00'),
(489, '30.80', '64.00'),
(490, '30.70', '64.00'),
(491, '30.80', '64.00'),
(492, '30.80', '63.90'),
(493, '30.80', '63.90'),
(494, '30.70', '63.90'),
(495, '30.80', '64.10'),
(496, '30.80', '64.10'),
(497, '30.70', '63.80'),
(498, '30.70', '63.70'),
(499, '30.70', '63.80'),
(500, '30.70', '64.00'),
(501, '30.70', '63.80'),
(502, '30.70', '63.80'),
(503, '30.70', '63.80'),
(504, '30.70', '63.90'),
(505, '30.70', '64.00'),
(506, '30.70', '63.90'),
(507, '30.70', '64.00'),
(508, '30.70', '64.10'),
(509, '30.70', '64.10'),
(510, '30.70', '64.10'),
(511, '30.70', '64.10'),
(512, '30.70', '64.30'),
(513, '30.70', '64.20'),
(514, '30.70', '64.30'),
(515, '30.70', '64.50'),
(516, '30.70', '64.60'),
(517, '30.70', '64.60'),
(518, '30.70', '64.80'),
(519, '30.70', '64.80'),
(520, '30.70', '64.80'),
(521, '30.70', '64.80'),
(522, '30.70', '64.70'),
(523, '30.70', '64.70'),
(524, '30.70', '64.70'),
(525, '30.70', '64.90'),
(526, '30.80', '65.00'),
(527, '30.80', '65.00'),
(528, '30.80', '65.00'),
(529, '30.80', '65.00'),
(530, '30.80', '65.00'),
(531, '30.80', '65.00'),
(532, '30.80', '64.90'),
(533, '30.80', '64.80'),
(534, '30.80', '64.80'),
(535, '30.80', '64.80'),
(536, '30.80', '64.70'),
(537, '30.80', '64.70'),
(538, '30.80', '64.70'),
(539, '30.80', '64.70'),
(540, '30.80', '64.70'),
(541, '30.80', '64.60'),
(542, '30.80', '64.60'),
(543, '30.80', '64.60'),
(544, '30.80', '64.60'),
(545, '30.80', '64.60'),
(546, '30.80', '64.60'),
(547, '30.80', '64.60'),
(548, '30.80', '64.60'),
(549, '30.80', '64.60'),
(550, '30.80', '64.60'),
(551, '30.80', '64.60'),
(552, '30.80', '64.60'),
(553, '30.80', '64.50'),
(554, '30.80', '64.50'),
(555, '30.80', '64.50'),
(556, '30.80', '64.40'),
(557, '30.80', '64.30'),
(558, '30.80', '64.30'),
(559, '30.80', '64.30'),
(560, '30.80', '64.20'),
(561, '30.80', '64.10'),
(562, '30.80', '64.20'),
(563, '30.80', '64.30'),
(564, '30.90', '64.30'),
(565, '30.80', '64.10'),
(566, '30.80', '64.20'),
(567, '30.80', '64.10'),
(568, '30.80', '64.10'),
(569, '30.80', '64.10'),
(570, '30.80', '63.80'),
(571, '30.90', '63.90'),
(572, '30.80', '63.90'),
(573, '30.80', '63.90'),
(574, '30.80', '63.70'),
(575, '30.80', '63.90'),
(576, '30.80', '63.90'),
(577, '30.80', '63.80'),
(578, '30.80', '63.80'),
(579, '30.80', '63.90'),
(580, '30.80', '64.00'),
(581, '30.80', '63.90'),
(582, '30.80', '63.90'),
(583, '30.80', '64.10'),
(584, '30.80', '64.00'),
(585, '30.80', '63.90'),
(586, '30.80', '63.90'),
(587, '30.80', '63.90'),
(588, '30.80', '63.90'),
(589, '30.80', '63.90'),
(590, '30.70', '63.90'),
(591, '30.70', '64.00'),
(592, '30.70', '64.10'),
(593, '30.70', '64.00'),
(594, '30.70', '63.90'),
(595, '30.70', '64.00'),
(596, '30.70', '64.00'),
(597, '30.70', '63.90'),
(598, '30.70', '63.90'),
(599, '30.70', '64.00'),
(600, '30.70', '64.10'),
(601, '30.70', '64.30'),
(602, '30.60', '64.30'),
(603, '30.70', '64.30'),
(604, '30.60', '64.20'),
(605, '30.70', '64.40'),
(606, '30.60', '64.40'),
(607, '30.70', '64.50'),
(608, '30.60', '64.50'),
(609, '30.60', '64.50'),
(610, '30.60', '64.60'),
(611, '30.60', '64.60'),
(612, '30.60', '64.60'),
(613, '30.70', '64.70'),
(614, '30.70', '64.70'),
(615, '30.70', '64.70'),
(616, '30.70', '64.70'),
(617, '30.70', '64.80'),
(618, '30.70', '64.70'),
(619, '30.70', '64.80'),
(620, '30.70', '64.80'),
(621, '30.70', '64.80'),
(622, '30.70', '65.10'),
(623, '30.80', '65.30'),
(624, '30.90', '65.30'),
(625, '30.80', '65.00'),
(626, '30.80', '64.90'),
(627, '30.80', '65.00'),
(628, '28.70', '70.50'),
(629, '28.60', '70.90'),
(630, '28.60', '72.40'),
(631, '28.60', '72.20'),
(632, '28.60', '72.20'),
(633, '28.60', '72.10'),
(634, '28.50', '72.10'),
(635, '28.50', '72.50'),
(636, '28.50', '72.40'),
(637, '28.50', '72.40'),
(638, '28.50', '72.50'),
(639, '28.50', '72.70'),
(640, '28.50', '72.60'),
(641, '28.50', '72.70'),
(642, '28.40', '72.70'),
(643, '28.40', '72.70'),
(644, '28.40', '72.70'),
(645, '28.50', '72.50'),
(646, '28.50', '73.40'),
(647, '28.50', '72.80'),
(648, '28.50', '72.50'),
(649, '28.40', '72.80'),
(650, '28.50', '73.10'),
(651, '28.50', '72.90'),
(652, '29.60', '68.90'),
(653, '29.60', '70.10'),
(654, '29.60', '70.20'),
(655, '29.60', '70.20'),
(656, '29.60', '70.10'),
(657, '29.50', '70.20'),
(658, '29.50', '70.10'),
(659, '29.50', '70.20'),
(660, '29.50', '70.30'),
(661, '29.40', '70.20'),
(662, '29.40', '70.30'),
(663, '29.40', '71.30'),
(664, '29.60', '70.50'),
(665, '29.60', '70.10'),
(666, '29.50', '70.20'),
(667, '29.50', '70.30'),
(668, '29.50', '70.40'),
(669, '29.50', '70.40'),
(670, '29.40', '70.40'),
(671, '29.40', '70.50'),
(672, '29.40', '70.50'),
(673, '29.40', '70.70'),
(674, '29.50', '70.50'),
(675, '29.50', '70.40'),
(676, '29.50', '70.30'),
(677, '29.50', '70.30'),
(678, '29.50', '70.30'),
(679, '29.50', '70.30'),
(680, '29.50', '70.20'),
(681, '29.50', '70.30'),
(682, '29.50', '70.20'),
(683, '29.50', '70.10'),
(684, '29.50', '70.30'),
(685, '29.50', '70.30'),
(686, '29.50', '70.10'),
(687, '29.50', '70.10');

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

CREATE TABLE `zone` (
  `zone_id` int(10) NOT NULL,
  `zone_name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `farm_name` varchar(255) NOT NULL,
  `chamber_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`zone_id`, `zone_name`, `user_name`, `farm_name`, `chamber_name`) VALUES
(24, 'zone 1', 'admin', 'Abdullah_Farm', 'Abd_micro_chamber');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activitylog`
--
ALTER TABLE `activitylog`
  ADD PRIMARY KEY (`activity_id`);

--
-- Indexes for table `admin_login`
--
ALTER TABLE `admin_login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chamber`
--
ALTER TABLE `chamber`
  ADD PRIMARY KEY (`chamber_id`);

--
-- Indexes for table `chamber2`
--
ALTER TABLE `chamber2`
  ADD PRIMARY KEY (`chamber_id`),
  ADD KEY `fkey_user` (`Login_id`);

--
-- Indexes for table `component`
--
ALTER TABLE `component`
  ADD PRIMARY KEY (`component_id`);

--
-- Indexes for table `component_stream`
--
ALTER TABLE `component_stream`
  ADD PRIMARY KEY (`component_stream_id`);

--
-- Indexes for table `farm`
--
ALTER TABLE `farm`
  ADD PRIMARY KEY (`farm_id`);

--
-- Indexes for table `farm_config`
--
ALTER TABLE `farm_config`
  ADD PRIMARY KEY (`farm_config_id`),
  ADD KEY `FK_farmchamber` (`farm_id`),
  ADD KEY `FK_chamberfarm` (`chamber_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`schedule_id`);

--
-- Indexes for table `stream_chamber`
--
ALTER TABLE `stream_chamber`
  ADD PRIMARY KEY (`stream_id`),
  ADD KEY `fkey_chamber` (`chamber_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`);

--
-- Indexes for table `user_login`
--
ALTER TABLE `user_login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `weather`
--
ALTER TABLE `weather`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zone`
--
ALTER TABLE `zone`
  ADD PRIMARY KEY (`zone_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activitylog`
--
ALTER TABLE `activitylog`
  MODIFY `activity_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_login`
--
ALTER TABLE `admin_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chamber`
--
ALTER TABLE `chamber`
  MODIFY `chamber_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `chamber2`
--
ALTER TABLE `chamber2`
  MODIFY `chamber_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `component`
--
ALTER TABLE `component`
  MODIFY `component_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `component_stream`
--
ALTER TABLE `component_stream`
  MODIFY `component_stream_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `farm`
--
ALTER TABLE `farm`
  MODIFY `farm_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `farm_config`
--
ALTER TABLE `farm_config`
  MODIFY `farm_config_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `schedule_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stream_chamber`
--
ALTER TABLE `stream_chamber`
  MODIFY `stream_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_login`
--
ALTER TABLE `user_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `weather`
--
ALTER TABLE `weather`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=700;

--
-- AUTO_INCREMENT for table `zone`
--
ALTER TABLE `zone`
  MODIFY `zone_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chamber2`
--
ALTER TABLE `chamber2`
  ADD CONSTRAINT `fkey_user` FOREIGN KEY (`Login_id`) REFERENCES `user_login` (`id`);

--
-- Constraints for table `farm_config`
--
ALTER TABLE `farm_config`
  ADD CONSTRAINT `FK_chamberfarm` FOREIGN KEY (`chamber_id`) REFERENCES `chamber2` (`chamber_id`),
  ADD CONSTRAINT `FK_farmchamber` FOREIGN KEY (`farm_id`) REFERENCES `farm` (`farm_id`);

--
-- Constraints for table `stream_chamber`
--
ALTER TABLE `stream_chamber`
  ADD CONSTRAINT `fkey_chamber` FOREIGN KEY (`chamber_id`) REFERENCES `chamber2` (`chamber_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
