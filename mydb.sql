-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2018 at 03:33 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail`
--

CREATE TABLE `detail` (
  `id` varchar(10) NOT NULL,
  `dt_id` varchar(10) NOT NULL,
  `transaction_id` varchar(10) NOT NULL,
  `item_id` varchar(10) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `note` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail`
--

INSERT INTO `detail` (`id`, `dt_id`, `transaction_id`, `item_id`, `quantity`, `note`) VALUES
('D001', 'DT001', 'TR001', 'I001', '1', 'SUDAH DIKEMBALIKAN'),
('D001', 'DT002', 'TR001', 'I002', '1', 'SUDAH DIKEMBALIKAN'),
('D002', 'DT001', 'TR002', 'I001', '1', 'SUDAH DIKEMBALIKAN'),
('D002', 'DT002', 'TR002', 'I002', '1', 'SUDAH DIKEMBALIKAN'),
('D003', 'DT001', 'TR003', 'I001', '1', 'SUDAH DIKEMBALIKAN'),
('D004', 'DT001', 'TR004', 'I001', '2', 'DIPINJAM');

--
-- Triggers `detail`
--
DELIMITER $$
CREATE TRIGGER `batal_pinjam` AFTER DELETE ON `detail` FOR EACH ROW BEGIN
UPDATE item
SET quantity = quantity + OLD.quantity
WHERE
id = OLD.item_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pinjam_barang` AFTER INSERT ON `detail` FOR EACH ROW BEGIN
UPDATE item
SET quantity = quantity - NEW.quantity
WHERE
id = NEW.item_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_temp`
--

CREATE TABLE `detail_temp` (
  `id` varchar(10) NOT NULL,
  `transaction_id` varchar(10) NOT NULL,
  `item_id` varchar(10) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `note` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `detail_temp`
--
DELIMITER $$
CREATE TRIGGER `batal_pinjam2` AFTER DELETE ON `detail_temp` FOR EACH ROW BEGIN
UPDATE item
SET quantity = quantity + OLD.quantity
WHERE
id = OLD.item_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pinjam_barang2` AFTER INSERT ON `detail_temp` FOR EACH ROW BEGIN
UPDATE item
SET quantity = quantity - NEW.quantity
WHERE
id = NEW.item_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` varchar(10) NOT NULL,
  `name` varchar(45) NOT NULL,
  `merk` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `image` text NOT NULL,
  `quantity` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `name`, `merk`, `description`, `image`, `quantity`) VALUES
('I001', '15-inch MacBook Pro', 'Apple Inc', 'The 15-inch MacBook Pro features a powerful R', '16042018163924bg.png', '19'),
('I002', 'Canon EOS 600D', 'Canon', '18-megapixel CMOS sensor, Scene Intelligent A', '17042018030042Canon EOS 600D.png', '4'),
('I003', 'Nikon D7200', 'Nikon', '24.2MP DX-Format CMOS Sensor, EXPEED 4 Image ', '17042018030126Next.png', '2'),
('I004', 'cobaya', 'apa', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	', '020620181227274.PNG', '1'),
('I005', 'cobaya', 'apa', 'ffffffffffffffff', '02072018043045exit.png', '3'),
('I006', 'pica', 'apa', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	', '02072018042829bookmark.png', '3');

-- --------------------------------------------------------

--
-- Stand-in structure for view `lpengembalian`
-- (See below for the actual view)
--
CREATE TABLE `lpengembalian` (
`id` varchar(10)
,`transaction_id` varchar(10)
,`nis` int(11)
,`nama` varchar(50)
,`name` varchar(45)
,`quantity` varchar(10)
,`date_return` date
,`day_late` varchar(45)
,`note` varchar(45)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `peminjaman`
-- (See below for the actual view)
--
CREATE TABLE `peminjaman` (
`id` varchar(10)
,`transaction_id` varchar(10)
,`nis` int(11)
,`nama` varchar(50)
,`item_id` varchar(10)
,`name` varchar(45)
,`quantity` varchar(10)
,`date` date
,`note` varchar(45)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pengembalian2`
-- (See below for the actual view)
--
CREATE TABLE `pengembalian2` (
`id` varchar(10)
,`transaction_id` varchar(10)
,`nis` int(11)
,`nama` varchar(50)
,`item_id` varchar(10)
,`name` varchar(45)
,`quantity` varchar(10)
,`note` varchar(45)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pengembalianpertr`
-- (See below for the actual view)
--
CREATE TABLE `pengembalianpertr` (
`id` varchar(10)
,`nis` int(11)
,`nama` varchar(50)
,`date` date
,`date_return` date
,`note` varchar(45)
);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `nis` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `jk` enum('L','P') NOT NULL,
  `rayon` varchar(10) NOT NULL,
  `rombel` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`nis`, `nama`, `jk`, `rayon`, `rombel`) VALUES
(11504919, 'Hilman Mubaroq', 'L', 'Wik 3', 'MMD XI-3'),
(11504987, 'Mekky Gideon Kikhau', 'L', 'Cis 4', 'TKJ XI-2'),
(11505010, 'Muhamad Deri Pratama Suhendi', 'L', 'Cia 1', 'RPL XI-1'),
(11505148, 'Raymond Aura Liel Sugianto', 'L', 'Cis 6', 'TKJ XI-1'),
(11605303, 'Abdulwafi Nurinsani', 'L', 'Cia 1', 'PMN XI-1'),
(11605304, 'Abdurohman', 'L', 'Cia 3', 'TKJ XI-2'),
(11605305, 'Abdussalam Husein', 'L', 'Cic 4', 'PMN XI-2'),
(11605306, 'Abil Muhamad Imani', 'L', 'Cis 4', 'RPL XI-3'),
(11605307, 'Achmad Rifaldy', 'L', 'Cic 3', 'PMN XI-1'),
(11605308, 'Adam Bahtiar Firdaus', 'L', 'Cic 6', 'RPL XI-3'),
(11605309, 'Adam Rahmat', 'L', 'Wik 1', 'TKJ XI-2'),
(11605310, 'Ade Ardiansyah Maulana', 'L', 'Cib 3', 'PMN XI-2'),
(11605312, 'Adi Wijaya', 'L', 'Taj 2', 'MMD XI-2'),
(11605313, 'Aditya Dwi Septiyanto', 'L', 'Cic 4', 'PMN XI-1'),
(11605314, 'Aditya Rama Putra', 'L', 'Taj 3', 'PMN XI-2'),
(11605315, 'Aditya Ridwan Nugraha', 'L', 'Cic 3', 'RPL XI-1'),
(11605316, 'Aditya Sukma Nur Alam', 'L', 'Wik 2', 'RPL XI-1'),
(11605317, 'Aditya Vio Gigantara', 'L', 'Cis 2', 'TKJ XI-1'),
(11605319, 'Adriansyah Ramadhan', 'L', 'Cic 7', 'RPL XI-3'),
(11605320, 'Aghniya Zahra Ainiy', 'P', 'Cia 2', 'MMD XI-3'),
(11605321, 'Agnesya Azzahra Anis', 'P', 'Cis 2', 'RPL XI-3'),
(11605322, 'Agung Fadilah', 'P', 'Cia 5', 'PMN XI-2'),
(11605323, 'Agung Mahariyad', 'L', 'Cia 5', 'RPL XI-4'),
(11605324, 'Agung Pratama', 'L', 'Cic 3', 'RPL XI-1'),
(11605325, 'Agung Ramadan', 'L', 'Cia 3', 'TKJ XI-2'),
(11605326, 'Ahmad Rahbar Rausanfikri Alwavy', 'L', 'Cis 2', 'RPL XI-3'),
(11605327, 'Ahmad Rifky Fauzi', 'L', 'Cic 5', 'RPL XI-3'),
(11605328, 'Ahmad Yoga Lutvi', 'L', 'Cia 5', 'MMD XI-3'),
(11605329, 'Ahmad Yunus Sulaeman', 'L', 'Cis 5', 'TKJ XI-1'),
(11605330, 'Ahmad Zulfikar', 'L', 'Cis 4', 'RPL XI-3'),
(11605331, 'Aimatul Khoeriyah', 'P', 'Cib 3', 'APK XI-1'),
(11605332, 'Aisha Febrianti', 'P', 'Cia 1', 'APK XI-4'),
(11605333, 'Ajeng Mutiara Ningtyas', 'P', 'Taj 4', 'PMN XI-2'),
(11605334, 'Aji Maulana Malik', 'L', 'Cia 1', 'PMN XI-2'),
(11605335, 'Al - Crasta Reixena Syam', 'P', 'Cis 5', 'RPL XI-2'),
(11605336, 'Aldi Sugandi', 'L', 'Cia 5', 'PMN XI-1'),
(11605338, 'Aldiza Putri Mulphyani', 'P', 'Cib 3', 'APK XI-2'),
(11605339, 'Aldo Alamsyah', 'L', 'Taj 5', 'PMN XI-1'),
(11605340, 'Alexandra Kiranti Lauwe', 'P', 'Cis 6', 'MMD XI-1'),
(11605341, 'Alfani', 'P', 'Cib 2', 'MMD XI-3'),
(11605342, 'Alfian Muzaki', 'L', 'Cic 6', 'TKJ XI-1'),
(11605343, 'Alfid Nurhakim', 'L', 'Cic 6', 'PMN XI-2'),
(11605344, 'Alfiyah Abdullah', 'P', 'Wik 4', 'APK XI-1'),
(11605346, 'Alif Arya Satria', 'L', 'Cia 5', 'TKJ XI-2'),
(11605347, 'Alif Rizky Nursyahputra', 'L', 'Cis 2', 'MMD XI-1'),
(11605348, 'Alifah Ayudia Rachman', 'P', 'Cic 6', 'MMD XI-3'),
(11605349, 'Alma Suci Rahmadani', 'P', 'Cic 7', 'APK XI-3'),
(11605350, 'Almeyda Dwinugroho Dewanto', 'L', 'Cic 6', 'TKJ XI-2'),
(11605351, 'Alvian Adi Wibowo', 'L', 'Wik 4', 'PMN XI-2'),
(11605352, 'Alvin Reyvaldo', 'L', 'Suk 1', 'RPL XI-4'),
(11605353, 'Alvira Erliana Putri', 'P', 'Cia 1', 'TKJ XI-2'),
(11605354, 'Alwan Nauval', 'L', 'Cib 3', 'MMD XI-2'),
(11605355, 'Alya Nasywa Martafianni', 'P', 'Cib 2', 'APK XI-4'),
(11605356, 'Amalia Nur Fitri Yani', 'P', 'Cis 5', 'APK XI-2'),
(11605357, 'Amalia Tiara Galuh', 'P', 'Cic 5', 'MMD XI-1'),
(11605358, 'Amrina', 'P', 'Cis 5', 'RPL XI-2'),
(11605359, 'Ananda Restyane', 'P', 'Cia 4', 'APK XI-1'),
(11605360, 'Ananda Rezaldy', 'L', 'Cia 5', 'RPL XI-2'),
(11605361, 'Andhika Navira Dillah Putra', 'L', 'Cis 4', 'MMD XI-3'),
(11605362, 'Andika Darmansyah', 'L', 'Taj 3', 'TKJ XI-2'),
(11605363, 'Andika Rizky Nugraha', 'L', 'Wik 4', 'APK XI-1'),
(11605364, 'Anelia Tri Oktaviani', 'P', 'Taj 4', 'APK XI-4'),
(11605365, 'Angelia Nurjanah', 'P', 'Taj 5', 'APK XI-1'),
(11605366, 'Angga Aditiya Nugraha', 'L', 'Cic 6', 'TKJ XI-1'),
(11605367, 'Angga Ardiansyah', 'L', 'Cib 3', 'TKJ XI-1'),
(11605368, 'Angga Khoerudin', 'L', 'Cic 3', 'MMD XI-2'),
(11605369, 'Angga Yudistira Ramadan', 'L', 'Taj 2', 'RPL XI-1'),
(11605370, 'Anggi Febryanti', 'P', 'Wik 3', 'MMD XI-2'),
(11605371, 'Ani Apriliani', 'P', 'Cib 2', 'APK XI-1'),
(11605372, 'Anis Fitria Nandani', 'P', 'Taj 2', 'RPL XI-4'),
(11605373, 'Anis Humanisa', 'P', 'Cic 3', 'RPL XI-1'),
(11605374, 'Anisa', 'P', 'Taj 4', 'PMN XI-1'),
(11605375, 'Anisa Novianti Sulbi', 'P', 'Cis 2', 'APK XI-1'),
(11605376, 'Anisa Rahman', 'P', 'Taj 3', 'APK XI-2'),
(11605377, 'Annisa Triani', 'P', 'Suk 1', 'RPL XI-3'),
(11605378, 'Anita Natasya', 'P', 'Taj 5', 'APK XI-3'),
(11605379, 'Annisa Fitria Nur Yavana', 'P', 'Wik 4', 'RPL XI-2'),
(11605380, 'Annisa Halimatussadiah', 'P', 'Cis 4', 'APK XI-2'),
(11605381, 'Apriliani Sugiarti', 'P', 'Cib 1', 'APK XI-3'),
(11605382, 'Aqiella Triana Furri Suryono', 'P', 'Cis 1', 'APK XI-4'),
(11605383, 'Aqsyal Nauval Gusman', 'L', 'Taj 5', 'RPL XI-1'),
(11605384, 'Ardy Wira Priyatna', 'L', 'Cic 3', 'TKJ XI-1'),
(11605385, 'Ari Amin Hawari', 'L', 'Wik 4', 'PMN XI-1'),
(11605386, 'Arief Rahman Hakim', 'L', 'Cis 3', 'RPL XI-4'),
(11605387, 'Arif Febriyanto', 'L', 'Wik 1', 'MMD XI-2'),
(11605388, 'Arief Raja Bestari', 'L', 'Wik 4', 'TKJ XI-2'),
(11605389, 'Ariyana Abdurahman', 'L', 'Cis 3', 'TKJ XI-1'),
(11605390, 'Arsyil Yazmar', 'L', 'Taj 5', 'MMD XI-1'),
(11605391, 'Asep Suryadin', 'L', 'Cic 1', 'PMN XI-2'),
(11605392, 'Astiawati Widyasari', 'P', 'Cia 1', 'APK XI-3'),
(11605393, 'Athara Hegar Sukma Perdana', 'L', 'Wik 4', 'MMD XI-1'),
(11605394, 'Audia Asyifatul Khumaeroh', 'P', 'Cis 5', 'APK XI-2'),
(11605395, 'Aulia Azzahra Ramadhani', 'P', 'Cic 7', 'APK XI-4'),
(11605396, 'Aulia Syatifa', 'P', 'Cis 5', 'APK XI-4'),
(11605397, 'Aurelya Amatul Zahwa', 'P', 'Cis 6', 'APK XI-3'),
(11605398, 'Ayu Rahma Indra Saputri', 'P', 'Cia 1', 'RPL XI-4'),
(11605399, 'Ayu Yulia', 'P', 'Taj 1', 'TKJ XI-1'),
(11605400, 'Azhar At Zauhar Dripana', 'L', 'Cia 2', 'RPL XI-3'),
(11605401, 'Azzahra Annisa Listanto', 'P', 'Cia 4', 'MMD XI-2'),
(11605402, 'Bagus Aji Ikranegara', 'L', 'Cib 1', 'PMN XI-1'),
(11605403, 'Bambang Aryo Yudha Jaya Wijaya K', 'L', 'Cib 2', 'TKJ XI-1'),
(11605404, 'Bambang Setiawan', 'L', 'Cib 3', 'PMN XI-1'),
(11605405, 'Bayu Febrian Isnin', 'L', 'Cis 4', 'MMD XI-3'),
(11605406, 'Bunga Resta Wijaya', 'P', 'Cic 7', 'RPL XI-3'),
(11605407, 'Candra Nispuana', 'L', 'Taj 3', 'TKJ XI-2'),
(11605408, 'Chika Cantika Dachlan', 'P', 'Cis 2', 'MMD XI-3'),
(11605409, 'Cindy Arsita Syaharani', 'P', 'Cic 1', 'PMN XI-1'),
(11605410, 'Citra Livia Hutasoit', 'P', 'Suk 1', 'APK XI-4'),
(11605411, 'Cucu Patonah', 'P', 'Cis 4', 'APK XI-4'),
(11605412, 'Cut Sandra Faradilla Febrianti', 'P', 'Cis 5', 'MMD XI-3'),
(11605413, 'Dafa Lutfian', 'L', 'Taj 4', 'RPL XI-4'),
(11605414, 'Dahlia Pertiwi Kalsum', 'P', 'Cic 1', 'APK XI-1'),
(11605415, 'Daniel A Syariff', 'L', 'Cib 2', 'RPL XI-4'),
(11605417, 'Danu Setyo Nugroho', 'L', 'Cib 1', 'TKJ XI-2'),
(11605418, 'Daura Laurensa Ratna Sari', 'P', 'Cis 5', 'RPL XI-3'),
(11605419, 'Davi Jordani Setiawan', 'L', 'Cis 3', 'RPL XI-4'),
(11605420, 'Dea Dwi Purwanti', 'P', 'Cia 3', 'APK XI-1'),
(11605421, 'Deansa', 'P', 'Taj 4', 'APK XI-4'),
(11605422, 'Debby Aliya Putri', 'P', 'Cia 1', 'TKJ XI-2'),
(11605423, 'Dellaneira Siska Widyawati', 'P', 'Cic 6', 'APK XI-1'),
(11605424, 'Deni Firmansyah', 'L', 'Cib 3', 'PMN XI-1'),
(11605425, 'Deni Pratama', 'L', 'Cib 1', 'MMD XI-1'),
(11605426, 'Denny Dolok Partala', 'L', 'Suk 1', 'RPL XI-2'),
(11605427, 'Deri Sukandar', 'L', 'Cib 2', 'TKJ XI-2'),
(11605428, 'Destia Audianti', 'P', 'Taj 5', 'MMD XI-1'),
(11605429, 'Destianis Ocktavia S', 'P', 'Suk 1', 'RPL XI-4'),
(11605430, 'Dewi Astuti', 'P', 'Cic 3', 'APK XI-3'),
(11605431, 'Dewi Herawati', 'P', 'Taj 3', 'MMD XI-1'),
(11605432, 'Dewi Puspitasari', 'P', 'Cia 2', 'MMD XI-3'),
(11605433, 'Dewi Sarifah Ambami', 'P', 'Cis 6', 'RPL XI-2'),
(11605434, 'Dewo Ananda Prasetyo', 'L', 'Cic 6', 'MMD XI-1'),
(11605436, 'Dhika Pramudia', 'L', 'Wik 4', 'APK XI-2'),
(11605437, 'Dian Indria Wati', 'P', 'Cis 6', 'APK XI-3'),
(11605438, 'Dika Alfarell Haidir Ramdani', 'L', 'Taj 4', 'RPL XI-2'),
(11605439, 'Dila Aprilia Ramdini', 'P', 'Taj 1', 'APK XI-3'),
(11605440, 'Dimas Darmawangsa Putra Perdana', 'L', 'Cia 3', 'PMN XI-1'),
(11605441, 'Dimas Hadiwibowo', 'L', 'Wik 2', 'RPL XI-3'),
(11605442, 'Dimas Sidiq Permana', 'L', 'Cis 5', 'RPL XI-3'),
(11605443, 'Dina Yulianti', 'P', 'Cis 2', 'APK XI-2'),
(11605444, 'Dinar Arisandi', 'L', 'Suk 1', 'RPL XI-3'),
(11605445, 'Dinda Amartya Riansyah', 'P', 'Cis 2', 'MMD XI-3'),
(11605446, 'Dita Dwi Cahyani', 'P', 'Cic 6', 'RPL XI-1'),
(11605447, 'Dita Lestari', 'P', 'Wik 3', 'MMD XI-3'),
(11605448, 'Dita Oktavia', 'P', 'Taj 5', 'PMN XI-1'),
(11605449, 'Dwi Ayu Widiyanti', 'P', 'Cic 1', 'APK XI-2'),
(11605450, 'Dwi Tantri', 'P', 'Cis 4', 'APK XI-3'),
(11605451, 'Dyah Ayu Gitaswari Paramitha', 'P', 'Cia 3', 'APK XI-3'),
(11605452, 'Dzikry Darmawan Pratama', 'L', 'Taj 5', 'TKJ XI-2'),
(11605453, 'Elih', 'P', 'Cia 5', 'APK XI-4'),
(11605454, 'Elizabeth Sharon Jily Onggara', 'P', 'Cis 5', 'MMD XI-2'),
(11605455, 'Elsa Aprilia Azzahra', 'P', 'Cib 3', 'RPL XI-3'),
(11605456, 'Elsa Febriana', 'P', 'Cia 5', 'APK XI-3'),
(11605457, 'Elsa Sri Wahyuni', 'P', 'Taj 3', 'APK XI-4'),
(11605459, 'Eneng Nova Permatasari', 'P', 'Cia 4', 'APK XI-1'),
(11605460, 'Eneng Winda Sari', 'P', 'Cia 4', 'MMD XI-2'),
(11605461, 'Eriansyah Erangga', 'L', 'Cia 2', 'TKJ XI-1'),
(11605462, 'Erisa Sri Aulia Dewi', 'P', 'Wik 4', 'APK XI-1'),
(11605464, 'Erza Putri Suryamulyawan', 'P', 'Cic 1', 'APK XI-2'),
(11605465, 'Eva Fauziah Indriani', 'P', 'Cib 2', 'MMD XI-2'),
(11605466, 'Evita Febriyanty', 'P', 'Cis 1', 'RPL XI-1'),
(11605467, 'Fachrunisa Ardiani', 'P', 'Cic 6', 'RPL XI-1'),
(11605469, 'Fadilla Azzahra', 'P', 'Cis 3', 'TKJ XI-2'),
(11605470, 'Fadlan Naufal', 'L', 'Cib 3', 'RPL XI-3'),
(11605471, 'Fadli Abdan Syakur', 'L', 'Wik 4', 'RPL XI-1'),
(11605472, 'Fadliansyah Rusly', 'L', 'Cic 1', 'RPL XI-2'),
(11605473, 'Fadly Laudza Anggadipraja', 'L', 'Cia 4', 'MMD XI-2'),
(11605474, 'Fajar Subeki', 'L', 'Cis 5', 'RPL XI-3'),
(11605475, 'Fakih Septiana Nasrulloh', 'L', 'Cis 1', 'APK XI-3'),
(11605476, 'Faradila Intan Osykawati', 'P', 'Cic 1', 'RPL XI-4'),
(11605477, 'Farhan Banyu Febryan', 'L', 'Cis 2', 'RPL XI-1'),
(11605478, 'Farhan Muhammad', 'L', 'Cic 1', 'RPL XI-4'),
(11605479, 'Farika Amanda Setiawan', 'P', 'Cis 2', 'RPL XI-4'),
(11605480, 'Farrel Arviana Saulani', 'L', 'Suk 1', 'TKJ XI-2'),
(11605481, 'Fatma Agustina', 'P', 'Cic 1', 'APK XI-1'),
(11605482, 'Fauzi Fadillah', 'L', 'Wik 1', 'RPL XI-3'),
(11605483, 'Fauziah Fazriani', 'P', 'Cib 1', 'APK XI-2'),
(11605484, 'Fauzie Hasbi Assidiqi', 'L', 'Taj 3', 'TKJ XI-1'),
(11605485, 'Febriani Putri Afgani', 'P', 'Cic 4', 'APK XI-3'),
(11605487, 'Ferdilliano Wazis', 'L', 'Cis 6', 'PMN XI-1'),
(11605488, 'Ferdiyan Syaputra', 'L', 'Cic 7', 'RPL XI-2'),
(11605489, 'Fetty Fatimah', 'P', 'Cib 3', 'APK XI-1'),
(11605490, 'Fiky Taufik', 'L', 'Cia 4', 'RPL XI-3'),
(11605491, 'Firda Nurhidayanti', 'P', 'Taj 4', 'APK XI-1'),
(11605492, 'Fitri Aldeniya', 'P', 'Suk 1', 'MMD XI-2'),
(11605493, 'Fitri Handayani', 'P', 'Cis 3', 'APK XI-4'),
(11605494, 'Friska Meyliana', 'P', 'Taj 3', 'APK XI-3'),
(11605495, 'Frista Maulia Putri', 'P', 'Suk 1', 'APK XI-2'),
(11605496, 'Futri Aliepiah Yulianti', 'P', 'Wik 4', 'APK XI-2'),
(11605497, 'Galih Rakasiwi', 'L', 'Cis 2', 'RPL XI-4'),
(11605499, 'GENA NOVIA PRILALITA', 'P', 'Cic 6', 'MMD XI-3'),
(11605500, 'Ginanjar Hadie Permana', 'L', 'Cia 5', 'MMD XI-2'),
(11605501, 'Gunadi Yudawiria', 'L', 'Wik 4', 'MMD XI-2'),
(11605502, 'Hafizdul Insan', 'L', 'Taj 4', 'RPL XI-4'),
(11605503, 'Haikal Fikri Luzain', 'L', 'Wik 4', 'RPL XI-3'),
(11605504, 'Hanida Khairunnisa', 'P', 'Cib 2', 'MMD XI-2'),
(11605505, 'Hari Herdiawan', 'L', 'Cia 4', 'RPL XI-2'),
(11605506, 'Haris Yowangga', 'L', 'Taj 5', 'TKJ XI-2'),
(11605507, 'Haryati', 'P', 'Cib 1', 'APK XI-4'),
(11605508, 'Hashfi Ihkamuddin', 'L', 'Suk 1', 'RPL XI-2'),
(11605509, 'Herdi Rismansyah', 'L', 'Cia 3', 'TKJ XI-1'),
(11605510, 'Hira Maulana', 'L', 'Suk 2', 'RPL XI-1'),
(11605511, 'Husein Putra Widya Pratama', 'L', 'Cis 4', 'RPL XI-2'),
(11605512, 'Ia Siti Robiah', 'P', 'Cis 4', 'PMN XI-2'),
(11605513, 'Igo Ferdiawan Syahputra', 'L', 'Wik 4', 'RPL XI-4'),
(11605515, 'Ilka Tishia Dalilah', 'P', 'Wik 4', 'MMD XI-3'),
(11605516, 'Imam Bahy Putra Susetyo', 'L', 'Wik 4', 'RPL XI-4'),
(11605517, 'Imanuel Crucifixio Denta Wirabuana', 'L', 'Cic 4', 'RPL XI-3'),
(11605518, 'Indri Meidiani', 'P', 'Cis 5', 'APK XI-2'),
(11605519, 'Indrianingsih', 'P', 'Taj 5', 'APK XI-3'),
(11605520, 'Indriyanti', 'P', 'Cib 1', 'APK XI-1'),
(11605521, 'Inggih Surya Ningsih', 'P', 'Cia 5', 'APK XI-2'),
(11605522, 'Injanurelia Hayat', 'P', 'Cis 2', 'APK XI-1'),
(11605523, 'Intan Gita Pradini', 'P', 'Cic 6', 'MMD XI-1'),
(11605524, 'Iputu Aldy Cahya Kusuma', 'L', 'Cic 6', 'RPL XI-3'),
(11605525, 'Ires Herlinawati Gunawan', 'P', 'Cib 1', 'PMN XI-1'),
(11605526, 'Irfan Priyadi Nurfauzi', 'L', 'Taj 4', 'RPL XI-1'),
(11605527, 'Irva Nur Fitriyani', 'P', 'Cis 4', 'APK XI-4'),
(11605528, 'Isra Abdillah Maulana', 'L', 'Cic 6', 'RPL XI-4'),
(11605529, 'Janwar Adi Jatmiko', 'L', 'Cic 7', 'MMD XI-1'),
(11605530, 'Jessa Ardithya Chriswantoro', 'L', 'Cic 4', 'RPL XI-1'),
(11605531, 'Jidan Jaelani', 'L', 'Cis 2', 'RPL XI-4'),
(11605532, 'Jihan Miranti', 'P', 'Cic 6', 'RPL XI-1'),
(11605533, 'Jonatan Sianipar', 'L', 'Cic 7', 'PMN XI-2'),
(11605534, 'Josephine Aprilia Sugianto', 'P', 'Cis 4', 'PMN XI-1'),
(11605535, 'Joya Almira Balqist Abigail', 'P', 'Cia 4', 'MMD XI-2'),
(11605536, 'Juan Karel Moenty', 'L', 'Taj 2', 'MMD XI-2'),
(11605537, 'Karina Nurul Fadilah', 'P', 'Cic 3', 'APK XI-2'),
(11605538, 'Kautsar Albana', 'L', 'Taj 3', 'RPL XI-4'),
(11605539, 'Kelvin Dwi Nugraha', 'L', 'Suk 1', 'MMD XI-3'),
(11605540, 'Kevin AXL Yohanes Wagey', 'L', 'Cia 4', 'MMD XI-2'),
(11605541, 'Khansa Tsabitah Ariyani', 'P', 'Wik 4', 'MMD XI-1'),
(11605542, 'Khonsa Khoulah', 'P', 'Cic 6', 'MMD XI-2'),
(11605543, 'Laila Holidah Fatmawati', 'P', 'Cic 3', 'APK XI-3'),
(11605544, 'Laili Nurdina', 'P', 'Cis 2', 'APK XI-3'),
(11605545, 'Lalita Darin Kalya', 'P', 'Wik 2', 'MMD XI-3'),
(11605546, 'Lia Aditia Putri', 'P', 'Cic 1', 'APK XI-4'),
(11605547, 'Liana Nur Rizqi', 'P', 'Suk 2', 'APK XI-1'),
(11605548, 'Lidia Puspitasari', 'P', 'Suk 1', 'APK XI-4'),
(11605549, 'Lintang Oktavia', 'P', 'Cia 5', 'APK XI-3'),
(11605550, 'Lio Lukman', 'L', 'Cic 7', 'PMN XI-2'),
(11605551, 'Lisma Retnawati', 'P', 'Cic 4', 'APK XI-1'),
(11605552, 'Listia Wati', 'P', 'Cia 4', 'APK XI-1'),
(11605553, 'Listiana Putri Utami', 'P', 'Taj 3', 'APK XI-4'),
(11605554, 'Lurin Andriani', 'P', 'Cis 3', 'RPL XI-1'),
(11605555, 'Luthfie Zikri Ramdhani', 'L', 'Cic 6', 'RPL XI-4'),
(11605556, 'Muhammad Adib Syarif', 'L', 'Wik 4', 'RPL XI-2'),
(11605557, 'Muhammad Arif Rahmatullah', 'L', 'Cic 1', 'RPL XI-3'),
(11605558, 'M. Baithul Athiq', 'L', 'Wik 4', 'RPL XI-4'),
(11605559, 'M. Chairul Anwar', 'L', 'Cis 6', 'RPL XI-4'),
(11605560, 'M. Daffa Van Raalten', 'L', 'Cis 4', 'MMD XI-1'),
(11605561, 'M. Fajar Putra Sopian', 'L', 'Cis 2', 'RPL XI-1'),
(11605562, 'M. Figo Haffidz Akbar', 'L', 'Cis 2', 'RPL XI-1'),
(11605563, 'Muhamad Fiqri Rizki Alamsyah', 'L', 'Cis 3', 'PMN XI-2'),
(11605564, 'M. Ghifari Fadhlurrahman', 'L', 'Cic 3', 'TKJ XI-2'),
(11605565, 'M. Rifky Setiadji', 'L', 'Cib 3', 'RPL XI-4'),
(11605566, 'M. Rival Rizmawan', 'L', 'Cic 7', 'TKJ XI-1'),
(11605567, 'M. Rully Fathurahman', 'L', 'Taj 3', 'MMD XI-2'),
(11605568, 'Maedina Nur Hikmah', 'P', 'Cis 2', 'TKJ XI-2'),
(11605569, 'Malwa Saharani', 'P', 'Cis 3', 'MMD XI-1'),
(11605570, 'Marwah Oktaviani', 'P', 'Wik 2', 'APK XI-2'),
(11605571, 'Maulana Amsori', 'L', 'Cic 7', 'MMD XI-1'),
(11605572, 'Maulana Ramadhan', 'L', 'Taj 4', 'TKJ XI-2'),
(11605573, 'Mega Lestari', 'P', 'Cia 4', 'APK XI-2'),
(11605575, 'Mega Sulistiawati', 'P', 'Cia 3', 'MMD XI-3'),
(11605577, 'Mentari Adelia', 'P', 'Taj 4', 'MMD XI-3'),
(11605578, 'Metyo Angga Putra', 'L', 'Cic 7', 'RPL XI-2'),
(11605579, 'Mikhail Raihan Ar-rayyan', 'L', 'Cic 1', 'MMD XI-1'),
(11605580, 'Mila Rosa', 'P', 'Cic 4', 'RPL XI-2'),
(11605581, 'Mila Safitri', 'P', 'Cic 1', 'RPL XI-4'),
(11605582, 'Mira Amelia', 'P', 'Cib 2', 'APK XI-4'),
(11605583, 'Moch Fa`ad Fadilah Syarif', 'L', 'Wik 4', 'RPL XI-4'),
(11605584, 'Moch. Ilham Alhadi', 'L', 'Cic 3', 'RPL XI-1'),
(11605585, 'Moch. Rian Suhada', 'L', 'Cis 4', 'RPL XI-1'),
(11605586, 'Mochamad Agil Setiawan', 'L', 'Cia 5', 'MMD XI-2'),
(11605587, 'Mochamad Marcel', 'L', 'Taj 4', 'RPL XI-1'),
(11605588, 'Mochamad Rifki Ramadhan', 'L', 'Cib 1', 'RPL XI-1'),
(11605589, 'Mochamad Syahrul Aripin', 'L', 'Cic 5', 'MMD XI-3'),
(11605590, 'Mochammad Ravi Suhendra', 'L', 'Cis 6', 'RPL XI-1'),
(11605591, 'Mohamad Dicky Andrian', 'L', 'Taj 4', 'MMD XI-1'),
(11605593, 'Mohamad Robby Herlambang', 'L', 'Cic 7', 'TKJ XI-1'),
(11605594, 'Mohammad Arshy Ramdhani', 'L', 'Cic 5', 'MMD XI-1'),
(11605595, 'Muftagi Arman Maulana', 'L', 'Cis 4', 'MMD XI-2'),
(11605596, 'Muhamad Adam Zildan', 'L', 'Cis 3', 'PMN XI-1'),
(11605597, 'Muhamad Aditya Widicaksono', 'L', 'Taj 2', 'MMD XI-1'),
(11605598, 'Muhamad Agus Fikri', 'L', 'Cib 2', 'MMD XI-2'),
(11605599, 'Muhamad Ahrul Syamil Ulum', 'L', 'Cis 5', 'RPL XI-3'),
(11605600, 'Muhamad Ajwanudin', 'L', 'Cib 3', 'RPL XI-1'),
(11605601, 'Muhamad Aldifa Maulana', 'L', 'Cia 5', 'APK XI-4'),
(11605602, 'Muhamad Alfi Ardiansyah', 'L', 'Cis 3', 'TKJ XI-1'),
(11605603, 'Muhamad Alfin', 'L', 'Cib 2', 'RPL XI-1'),
(11605604, 'Muhamad Alif Viandi Zulfikor', 'L', 'Cia 3', 'TKJ XI-2'),
(11605605, 'Muhamad Aqil Atthoriq', 'L', 'Wik 4', 'PMN XI-1'),
(11605606, 'Muhamad Awaludin Nugraha', 'L', 'Cia 4', 'MMD XI-3'),
(11605607, 'Muhamad Azril', 'L', 'Taj 4', 'MMD XI-1'),
(11605608, 'Muhamad Didi Wahyudi', 'L', 'Cis 4', 'RPL XI-1'),
(11605609, 'Muhamad Fikri Haikal', 'L', 'Taj 5', 'PMN XI-2'),
(11605610, 'Muhamad Habil Fathurahman', 'L', 'Cia 1', 'MMD XI-2'),
(11605611, 'Muhamad Ikhsan Maulana', 'L', 'Cis 5', 'RPL XI-2'),
(11605612, 'Muhamad Ilham', 'L', 'Cia 2', 'RPL XI-4'),
(11605613, 'Muhamad Ilham Ramadhan', 'L', 'Cis 1', 'MMD XI-2'),
(11605614, 'Muhamad Ilham Sihabudin', 'L', 'Wik 1', 'RPL XI-2'),
(11605615, 'Muhamad Iqbal Faturrahman', 'L', 'Suk 2', 'RPL XI-2'),
(11605616, 'Muhamad Iqbal Nurhadi', 'L', 'Wik 3', 'PMN XI-2'),
(11605617, 'Muhamad Jalaludin', 'L', 'Wik 1', 'RPL XI-4'),
(11605618, 'Muhamad Meidy Mahardika', 'L', 'Cis 4', 'RPL XI-2'),
(11605619, 'Muhamad Miftah', 'L', 'Cib 3', 'RPL XI-3'),
(11605620, 'Muhamad Naufal Azmi', 'L', 'Cis 5', 'RPL XI-1'),
(11605621, 'Muhamad Naufal Meidiyawan', 'L', 'Cia 1', 'PMN XI-1'),
(11605623, 'Muhamad Rafli Irfansyah', 'L', 'Cis 5', 'RPL XI-2'),
(11605624, 'Muhammad Raudhon Maulana', 'L', 'Cic 5', 'TKJ XI-2'),
(11605625, 'Muhamad Rehan', 'L', 'Cis 5', 'TKJ XI-1'),
(11605626, 'Muhamad Rian Maulana', 'L', 'Suk 2', 'RPL XI-4'),
(11605627, 'Muhamad Rifa`i', 'L', 'Cic 4', 'TKJ XI-2'),
(11605628, 'Muhamad Risky Figo', 'L', 'Cic 7', 'MMD XI-3'),
(11605629, 'Muhamad Rivaldi', 'L', 'Cib 3', 'RPL XI-3'),
(11605630, 'Muhamad Rizal Erwiansyah', 'L', 'Cib 3', 'RPL XI-4'),
(11605631, 'Muhamad Rizki', 'L', 'Taj 5', 'RPL XI-1'),
(11605632, 'Muhamad Rizki Maulana', 'L', 'Cis 4', 'TKJ XI-1'),
(11605633, 'Muhamad Rizky Novriadi', 'L', 'Cia 2', 'MMD XI-1'),
(11605634, 'Muhamad Rizqi Permadi', 'L', 'Taj 5', 'MMD XI-3'),
(11605635, 'Muhamad Sadam Husen', 'L', 'Cib 3', 'APK XI-2'),
(11605636, 'Muhamad Saprudin', 'L', 'Cib 2', 'PMN XI-2'),
(11605637, 'Muhamad Sechan Syadat', 'L', 'Cia 5', 'RPL XI-2'),
(11605638, 'Muhamad Sofian Hidayat', 'L', 'Cic 5', 'PMN XI-1'),
(11605639, 'Muhamad Sopian Sauri', 'L', 'Cis 3', 'MMD XI-1'),
(11605640, 'Muhamad Tubagus Rangga', 'L', 'Cic 3', 'RPL XI-2'),
(11605641, 'Muhamad Wildan', 'L', 'Cis 6', 'RPL XI-2'),
(11605642, 'Muhamad Yerdilah Riziq', 'L', 'Cic 5', 'TKJ XI-1'),
(11605643, 'Muhamad Yusdi Fajri', 'L', 'Cis 2', 'TKJ XI-1'),
(11605645, 'Muhammad Adilla', 'L', 'Taj 4', 'APK XI-4'),
(11605646, 'Muhammad Akbar Maureksa', 'L', 'Wik 4', 'RPL XI-2'),
(11605647, 'Muhammad Anjas Ambia', 'L', 'Cic 3', 'TKJ XI-2'),
(11605648, 'Muhammad Arda Bily', 'L', 'Cia 1', 'MMD XI-1'),
(11605649, 'Muhammad Ardiansyah', 'L', 'Cic 4', 'TKJ XI-2'),
(11605650, 'Muhammad Arif Syauqi Beik', 'L', 'Taj 3', 'MMD XI-1'),
(11605651, 'Muhammad Ashadi', 'L', 'Cic 1', 'PMN XI-1'),
(11605652, 'Muhammad Azril Akbar', 'L', 'Cic 4', 'RPL XI-3'),
(11605653, 'Muhammad Basman Jamal', 'L', 'Suk 2', 'PMN XI-1'),
(11605654, 'Muhammad Daud Satibi', 'L', 'Suk 2', 'APK XI-2'),
(11605655, 'Muhammad Dervan Armanda', 'L', 'Cia 1', 'MMD XI-2'),
(11605656, 'Muhammad Eggy Abdal Saputra', 'L', 'Cis 3', 'RPL XI-4'),
(11605657, 'Muhammad Fahran Januar', 'L', 'Cia 2', 'PMN XI-1'),
(11605658, 'Muhammad Fajar Darmawan', 'L', 'Cia 3', 'RPL XI-4'),
(11605660, 'Muhammad Farhan Fahrurrozi', 'L', 'Cic 5', 'TKJ XI-1'),
(11605662, 'Muhammad Febriansyah', 'L', 'Taj 4', 'TKJ XI-2'),
(11605663, 'Muhammad Fikri Bima Nugraha', 'L', 'Wik 1', 'RPL XI-3'),
(11605664, 'Muhammad Fikri Sanjaya', 'L', 'Cic 3', 'MMD XI-1'),
(11605665, 'Muhammad Firman Prayoga', 'L', 'Cia 5', 'RPL XI-4'),
(11605666, 'Muhammad Hamidi', 'L', 'Cic 3', 'MMD XI-1'),
(11605667, 'Muhammad Ikbal Suhada', 'L', 'Cic 3', 'TKJ XI-1'),
(11605668, 'Muhammad Ilyas', 'L', 'Cis 5', 'RPL XI-1'),
(11605669, 'Muhammad Iqbal Febrian', 'L', 'Cia 2', 'MMD XI-1'),
(11605670, 'Muhammad Irsan Aditia', 'L', 'Cia 2', 'TKJ XI-2'),
(11605671, 'Muhammad Lukmanulhakim', 'L', 'Cis 4', 'RPL XI-2'),
(11605672, 'Muhammad Lutfi', 'L', 'Cia 5', 'TKJ XI-1'),
(11605673, 'Muhammad Najib Firdaus', 'L', 'Cis 5', 'RPL XI-4'),
(11605674, 'Muhammad Naufal Shabir', 'L', 'Suk 1', 'RPL XI-1'),
(11605675, 'Muhammad Nazif', 'L', 'Wik 4', 'TKJ XI-1'),
(11605678, 'Muhammad Rafizki', 'L', 'Cis 4', 'TKJ XI-1'),
(11605679, 'Muhammad Ramadhani', 'L', 'Cib 3', 'RPL XI-2'),
(11605680, 'Muhammad Ramdhan', 'L', 'Cic 5', 'TKJ XI-2'),
(11605681, 'Muhammad Randy Maulana', 'L', 'Cia 3', 'MMD XI-3'),
(11605683, 'Muhammad Reza Fahlevi Hamzah', 'L', 'Cis 3', 'TKJ XI-2'),
(11605684, 'Muhammad Rivan Khatami', 'L', 'Suk 1', 'MMD XI-1'),
(11605685, 'Muhammad Saepu Baldan', 'L', 'Cic 1', 'PMN XI-1'),
(11605686, 'Muhammad Salman Riski Saputra', 'L', 'Cib 3', 'RPL XI-1'),
(11605687, 'Muhammad Sopian', 'L', 'Cib 3', 'RPL XI-1'),
(11605688, 'Muhammad Suwardi Firdaus', 'L', 'Taj 3', 'TKJ XI-1'),
(11605689, 'Muhammad Wildan Fauzi', 'L', 'Cib 2', 'TKJ XI-2'),
(11605690, 'Mukti Prasatya Rahardja', 'L', 'Taj 5', 'MMD XI-2'),
(11605691, 'Mupida Safitri', 'P', 'Taj 4', 'APK XI-2'),
(11605692, 'Murni Zulia Hadstuti', 'P', 'Cib 1', 'APK XI-3'),
(11605693, 'Mutiara Rizkyna Arlinda', 'P', 'Cis 4', 'RPL XI-1'),
(11605694, 'Mutiara Widianti Sukma', 'P', 'Wik 3', 'RPL XI-1'),
(11605695, 'Nabila Fitriani', 'P', 'Cis 2', 'MMD XI-2'),
(11605696, 'Nabila Hermawati', 'P', 'Cic 7', 'RPL XI-2'),
(11605697, 'Nadia Septiani', 'P', 'Cib 1', 'APK XI-3'),
(11605698, 'Nana Rudiana', 'L', 'Cib 1', 'PMN XI-1'),
(11605699, 'Nasir Ahmad', 'L', 'Taj 5', 'PMN XI-2'),
(11605700, 'Natasha', 'P', 'Suk 2', 'RPL XI-3'),
(11605701, 'Naufal Tiftazani', 'L', 'Cib 1', 'PMN XI-2'),
(11605702, 'Naufal Widad Irawan', 'L', 'Cia 1', 'PMN XI-2'),
(11605703, 'Navy Putri Marini', 'P', 'Wik 1', 'APK XI-1'),
(11605704, 'Nia Indriani', 'P', 'Cic 3', 'APK XI-4'),
(11605705, 'Niken Rahmadani', 'P', 'Cib 3', 'MMD XI-2'),
(11605706, 'Nina Rahma Aulia', 'P', 'Cic 1', 'APK XI-4'),
(11605707, 'Nina Rosdiana', 'P', 'Taj 4', 'MMD XI-3'),
(11605708, 'Nisa Maulida', 'P', 'Cib 2', 'APK XI-2'),
(11605709, 'Nita Anggraeni', 'P', 'Taj 4', 'RPL XI-2'),
(11605710, 'Nita Elinda', 'P', 'Wik 2', 'TKJ XI-1'),
(11605711, 'Noer Muhamad Reksy Agus Saputra', 'L', 'Wik 3', 'PMN XI-1'),
(11605712, 'Noer Samantha Chaerunnisa', 'P', 'Taj 2', 'APK XI-2'),
(11605713, 'Noor Aghni Aulia Pratiwi', 'P', 'Suk 2', 'MMD XI-2'),
(11605714, 'Noviana Eni Marlufi', 'P', 'Cic 1', 'APK XI-3'),
(11605715, 'Noviansyah Caturnanda Saputra', 'L', 'Cis 3', 'TKJ XI-2'),
(11605716, 'Novica Ardina', 'P', 'Cic 7', 'RPL XI-1'),
(11605717, 'Nugi Nugroho', 'L', 'Cic 4', 'TKJ XI-1'),
(11605718, 'Nur Aini Lubis', 'P', 'Taj 3', 'APK XI-4'),
(11605719, 'Nur Arini Erdiani Soleha', 'P', 'Cic 7', 'APK XI-3'),
(11605720, 'Nur Fitri Apriani Harahap', 'P', 'Cic 3', 'APK XI-1'),
(11605721, 'Nur Khopipah', 'P', 'Taj 4', 'RPL XI-2'),
(11605722, 'Nur Muhammad Muddatsir', 'L', 'Cic 6', 'MMD XI-3'),
(11605723, 'Nurdian Fitri Ningsih', 'P', 'Wik 2', 'APK XI-1'),
(11605724, 'Nurhadi Yusup', 'L', 'Suk 1', 'TKJ XI-2'),
(11605725, 'Nurrizki Pratama', 'L', 'Suk 1', 'APK XI-3'),
(11605726, 'Nurul Awaliyaturohmah', 'P', 'Cic 1', 'MMD XI-1'),
(11605727, 'Nurul Fauziah', 'P', 'Cic 7', 'APK XI-1'),
(11605728, 'Nurul Qurrotu Aeni', 'P', 'Cia 3', 'MMD XI-2'),
(11605729, 'Nurul Salma Musafa', 'P', 'Cic 5', 'APK XI-4'),
(11605730, 'Nyai Misih', 'P', 'Taj 5', 'MMD XI-3'),
(11605731, 'Osi Rias Wasubhi', 'L', 'Taj 5', 'TKJ XI-1'),
(11605732, 'Pipit Nur Apipah', 'P', 'Cic 3', 'APK XI-4'),
(11605733, 'Prama Prakasa', 'L', 'Taj 3', 'RPL XI-4'),
(11605734, 'Pramudya Saputra', 'L', 'Cic 4', 'RPL XI-3'),
(11605735, 'Pranajaya Sulaiman Basyir', 'L', 'Cib 2', 'RPL XI-1'),
(11605736, 'Pratama Miswa Nugraha', 'L', 'Cis 4', 'MMD XI-3'),
(11605737, 'Putra Alief Hermawan', 'L', 'Cib 2', 'MMD XI-3'),
(11605738, 'Putra Haekal Ghifari', 'L', 'Cib 3', 'TKJ XI-2'),
(11605739, 'Putri Apryanti', 'P', 'Cib 1', 'APK XI-1'),
(11605740, 'Putri Fadella Ari Aluna', 'P', 'Cic 1', 'APK XI-2'),
(11605741, 'Putri Pratiwi', 'P', 'Cis 3', 'APK XI-2'),
(11605742, 'Putri Salma Wulandari', 'P', 'Cic 3', 'RPL XI-2'),
(11605743, 'Putri Siti Nurulita Idris', 'P', 'Cis 6', 'MMD XI-3'),
(11605744, 'Putri Yasinta', 'P', 'Taj 3', 'APK XI-2'),
(11605745, 'Putriana Rizka Pamungkas', 'P', 'Cis 2', 'MMD XI-1'),
(11605746, 'Putriyani', 'P', 'Cia 3', 'APK XI-3'),
(11605747, 'Qonitat Sholihah', 'P', 'Cis 5', 'APK XI-1'),
(11605748, 'R. Siti Hanipah', 'P', 'Cis 2', 'APK XI-2'),
(11605749, 'Raafi Husain Kamil', 'L', 'Taj 1', 'TKJ XI-2'),
(11605750, 'Rachel Nanulaitta', 'P', 'Cis 1', 'MMD XI-2'),
(11605752, 'Raden Desti Safitri', 'P', 'Cis 4', 'APK XI-1'),
(11605754, 'Raditka Adha', 'L', 'Suk 2', 'RPL XI-4'),
(11605755, 'Radja Raiyan Trixy Salafy', 'L', 'Cis 3', 'MMD XI-3'),
(11605756, 'Rafa Nur Adilah', 'P', 'Cic 5', 'RPL XI-3'),
(11605757, 'Rafi Pratama Merta', 'L', 'Cib 2', 'RPL XI-3'),
(11605758, 'Rafli Maulana Rizki', 'L', 'Cia 1', 'RPL XI-3'),
(11605759, 'Ragis Nuriansyah Putra', 'L', 'Cis 5', 'PMN XI-2'),
(11605760, 'Raihan Fajari', 'L', 'Wik 4', 'RPL XI-3'),
(11605763, 'Raka Agus Chandra', 'L', 'Cis 2', 'RPL XI-2'),
(11605764, 'Rama Yudha Agustira', 'L', 'Cic 3', 'MMD XI-2'),
(11605766, 'Rangga Mahendra Yusup', 'L', 'Taj 3', 'RPL XI-1'),
(11605767, 'Rayna Russena', 'P', 'Suk 2', 'MMD XI-1'),
(11605768, 'Raysa Afni', 'P', 'Wik 2', 'APK XI-3'),
(11605769, 'Razi Mawlana Yusuf', 'L', 'Wik 4', 'TKJ XI-1'),
(11605770, 'Refasya Ika Pramesti', 'P', 'Cib 2', 'APK XI-3'),
(11605771, 'Reinandy Fediyanto', 'L', 'Cic 4', 'RPL XI-1'),
(11605772, 'Rena Wahyuni', 'P', 'Cia 5', 'APK XI-1'),
(11605773, 'Renata Indah Ningrum Siahaan', 'P', 'Cib 2', 'MMD XI-1'),
(11605774, 'Rendy Saputra Jamin', 'L', 'Cia 3', 'MMD XI-2'),
(11605775, 'Renisa Qori Adinda', 'P', 'Cib 2', 'APK XI-2'),
(11605776, 'Resya Putri Kemala', 'P', 'Cis 1', 'MMD XI-3'),
(11605777, 'Reva Putri Amalia', 'P', 'Taj 5', 'MMD XI-3'),
(11605778, 'Revanza Wicak Pangestu', 'L', 'Cic 4', 'PMN XI-2'),
(11605779, 'Reynaldi Saputra', 'L', 'Cic 6', 'PMN XI-2'),
(11605780, 'Reza Fitria Tarwiyah', 'P', 'Cic 3', 'APK XI-4'),
(11605781, 'Reza Kharisma Muhammad', 'L', 'Cic 6', 'TKJ XI-2'),
(11605782, 'Rhavy Julian Pradana', 'L', 'Cib 1', 'PMN XI-2'),
(11605783, 'Rian Subagya', 'L', 'Taj 3', 'TKJ XI-2'),
(11605784, 'Ricken Fillany', 'P', 'Cic 7', 'APK XI-4'),
(11605785, 'Rifki Ananda', 'L', 'Cia 3', 'APK XI-1'),
(11605786, 'Rifki Rustandi', 'L', 'Cia 4', 'RPL XI-2'),
(11605788, 'Rifqi Faadillah Azhar', 'L', 'Cia 3', 'PMN XI-1'),
(11605789, 'Rihan Alrieva Prihadi', 'L', 'Cis 5', 'MMD XI-3'),
(11605790, 'Rika Rahmawati', 'P', 'Cia 2', 'APK XI-3'),
(11605791, 'Riky Wijaya', 'L', 'Cis 3', 'RPL XI-1'),
(11605792, 'Rima Regiani', 'P', 'Cib 1', 'RPL XI-2'),
(11605793, 'Rina Alawiyah', 'P', 'Cic 4', 'APK XI-4'),
(11605794, 'Rini Indriyani', 'P', 'Cia 3', 'APK XI-1'),
(11605795, 'Rio Maulana', 'L', 'Taj 4', 'PMN XI-2'),
(11605796, 'Riri Nurma Herwini', 'P', 'Cis 6', 'APK XI-2'),
(11605797, 'Riska Ekayana Putri', 'P', 'Cic 3', 'APK XI-4'),
(11605798, 'Riska Sulistiawati', 'P', 'Wik 3', 'MMD XI-3'),
(11605799, 'Risma Yunianti', 'P', 'Cis 3', 'APK XI-1'),
(11605800, 'Riyan Maulana Putra', 'L', 'Taj 3', 'RPL XI-2'),
(11605801, 'Rizal Bimantoro', 'L', 'Cic 1', 'MMD XI-3'),
(11605802, 'Rizal Ikhsan Pratama', 'L', 'Taj 1', 'MMD XI-1'),
(11605803, 'Rizki Indra Bayu', 'L', 'Cib 1', 'TKJ XI-2'),
(11605804, 'Rizky Nasrullah', 'L', 'Cia 1', 'MMD XI-1'),
(11605805, 'Rizky Widiyanto', 'L', 'Suk 2', 'RPL XI-3'),
(11605806, 'Robbi Hably Minassholihyn', 'L', 'Taj 4', 'TKJ XI-1'),
(11605807, 'Runi Khaerunisa', 'P', 'Cis 6', 'APK XI-2'),
(11605808, 'Ruslan Fadilah', 'L', 'Cis 4', 'MMD XI-2'),
(11605809, 'Ryan Prasastian', 'L', 'Cis 2', 'PMN XI-2'),
(11605811, 'Saeful Reiza Nourmansah', 'L', 'Cic 5', 'TKJ XI-1'),
(11605812, 'Saefullah Wafa', 'L', 'Cic 7', 'TKJ XI-1'),
(11605813, 'Safinah Apriliyani', 'P', 'Cic 3', 'APK XI-2'),
(11605814, 'Safitri Suci Rahayu', 'P', 'Cic 3', 'MMD XI-3'),
(11605815, 'Saiful Maulana', 'L', 'Taj 4', 'PMN XI-2'),
(11605816, 'Salma Nazhifah', 'P', 'Cib 2', 'MMD XI-3'),
(11605817, 'Salman Hardi Priatna', 'L', 'Cic 7', 'PMN XI-1'),
(11605818, 'Salsa Aulia Anjari', 'P', 'Cic 7', 'MMD XI-1'),
(11605819, 'Salsabila Qurotuain', 'P', 'Cic 6', 'RPL XI-1'),
(11605820, 'Salsadilah', 'P', 'Cib 1', 'MMD XI-2'),
(11605821, 'Salsha Desviani', 'P', 'Cia 3', 'APK XI-2'),
(11605822, 'Salwa Rizky Aulia', 'P', 'Cic 5', 'APK XI-1'),
(11605823, 'Salzhadina Anggita', 'P', 'Taj 4', 'MMD XI-2'),
(11605824, 'Sandhika Ferly Sidiq', 'L', 'Cic 5', 'PMN XI-2'),
(11605826, 'Sandra Zettira', 'P', 'Cic 1', 'APK XI-3'),
(11605827, 'Saprila Wijaya', 'P', 'Cia 5', 'TKJ XI-2'),
(11605828, 'Sari Nurfika', 'P', 'Cia 5', 'APK XI-4'),
(11605829, 'Saripah Nabila', 'P', 'Taj 3', 'RPL XI-2'),
(11605830, 'Saskia Intan Ramadhanti', 'P', 'Cib 1', 'APK XI-3'),
(11605831, 'Satrio Nuur Adi Prawiro', 'L', 'Cic 4', 'RPL XI-2'),
(11605833, 'Sehira Agya Salsabillah', 'P', 'Cib 3', 'APK XI-4'),
(11605834, 'Selvi Noviliana', 'P', 'Cic 5', 'APK XI-1'),
(11605835, 'Sendy Hartanto', 'L', 'Taj 5', 'RPL XI-2'),
(11605836, 'Sephia Tri Handayani', 'P', 'Wik 4', 'PMN XI-2'),
(11605837, 'Septi Hatami Selvia Muntila', 'P', 'Cic 1', 'PMN XI-2'),
(11605838, 'Septia Arieska', 'P', 'Cis 3', 'MMD XI-1'),
(11605839, 'Septiani Zulkarnain', 'P', 'Taj 5', 'APK XI-2'),
(11605840, 'Septio Surya Mustaqim', 'L', 'Wik 2', 'TKJ XI-1'),
(11605841, 'Shantika Dwi', 'P', 'Wik 3', 'MMD XI-2'),
(11605842, 'Shevtya Rahmawaty', 'P', 'Wik 1', 'PMN XI-1'),
(11605843, 'Shofi Luthfiah', 'P', 'Taj 4', 'PMN XI-2'),
(11605844, 'Silvi Anggiastuti', 'P', 'Cis 6', 'APK XI-3'),
(11605845, 'Silvi Nurfadhilah', 'P', 'Cia 1', 'APK XI-2'),
(11605846, 'Silvia Anggraeni', 'P', 'Cia 5', 'APK XI-4'),
(11605847, 'Silvia Irma Wahyudi', 'P', 'Taj 5', 'MMD XI-2'),
(11605848, 'Sindi Iklimah Nurul Apriani', 'P', 'Cia 4', 'APK XI-1'),
(11605849, 'Siti Alfi Wahidah', 'P', 'Cis 5', 'PMN XI-1'),
(11605850, 'Siti Amalia Ihsan', 'P', 'Cia 5', 'APK XI-1'),
(11605851, 'Siti Assyifah', 'P', 'Cis 4', 'MMD XI-3'),
(11605852, 'Siti Halimah', 'P', 'Wik 1', 'APK XI-3'),
(11605853, 'Siti Inayatul Wahidah', 'P', 'Cic 7', 'APK XI-2'),
(11605854, 'Siti Jahra', 'P', 'Cic 6', 'RPL XI-2'),
(11605855, 'Siti Khodijah', 'P', 'Cis 4', 'APK XI-3'),
(11605856, 'Siti Mariam', 'P', 'Suk 1', 'APK XI-1'),
(11605857, 'Siti Maryamah', 'P', 'Cia 2', 'APK XI-2'),
(11605858, 'Siti Maulidia Sa`adah', 'P', 'Suk 1', 'APK XI-3'),
(11605859, 'Siti Meika Anggita', 'P', 'Cis 5', 'APK XI-4'),
(11605860, 'Siti Meliawati', 'P', 'Cia 4', 'APK XI-3'),
(11605861, 'Siti Nabila Huda', 'P', 'Cib 3', 'RPL XI-3'),
(11605862, 'Siti Nadea', 'P', 'Cic 5', 'APK XI-3'),
(11605863, 'Siti Novi Nurkomala', 'P', 'Cia 2', 'APK XI-2'),
(11605864, 'Siti Nur Aulia', 'P', 'Cic 5', 'APK XI-4'),
(11605865, 'Siti Nur Ubed Ubaedillah', 'P', 'Cis 4', 'RPL XI-4'),
(11605866, 'Siti Nuraeni', 'P', 'Cic 7', 'APK XI-1'),
(11605867, 'Siti Nurheriah', 'P', 'Cia 3', 'APK XI-4'),
(11605868, 'Siti Nurul Fadilah', 'P', 'Cib 3', 'APK XI-1'),
(11605869, 'Siti Robiatul Adawiah', 'P', 'Cis 1', 'APK XI-2'),
(11605870, 'Siti Salbia Sundava', 'P', 'Cis 3', 'APK XI-1'),
(11605871, 'Siti Salwawati', 'P', 'Cia 1', 'PMN XI-1'),
(11605872, 'Siti Sarah', 'P', 'Cia 2', 'MMD XI-3'),
(11605873, 'Siti Silvani Nahrulita', 'P', 'Cis 6', 'APK XI-2'),
(11605874, 'Siti Syahda Rana Areta', 'P', 'Cib 2', 'RPL XI-4'),
(11605875, 'Siti Syarah Namira Nur Azizah', 'P', 'Taj 4', 'APK XI-2'),
(11605876, 'Siti Yulia Nengsih', 'P', 'Cic 4', 'APK XI-3'),
(11605877, 'Siti Yulianti', 'P', 'Cic 7', 'APK XI-3'),
(11605878, 'Sopiatunisa', 'P', 'Taj 2', 'RPL XI-3'),
(11605879, 'Sri Indriyani', 'P', 'Taj 5', 'APK XI-4'),
(11605880, 'Sri Putri Mentari', 'P', 'Cis 5', 'RPL XI-3'),
(11605881, 'Sri Ratih', 'P', 'Cib 2', 'APK XI-3'),
(11605882, 'Sri Siti Wahyuni', 'P', 'Cis 3', 'APK XI-4'),
(11605883, 'Suci Ardila Citra', 'P', 'Cib 2', 'RPL XI-4'),
(11605884, 'Suci Putri Agnesia', 'P', 'Cic 6', 'RPL XI-4'),
(11605885, 'Sulhan Susanto', 'L', 'Taj 3', 'TKJ XI-1'),
(11605886, 'Sultan Putra Ramadan', 'L', 'Cia 3', 'MMD XI-2'),
(11605887, 'Susanto', 'L', 'Cis 5', 'RPL XI-4'),
(11605888, 'Syabrina Salsabilla', 'P', 'Taj 2', 'PMN XI-2'),
(11605889, 'Syahril Sidik', 'L', 'Cib 3', 'TKJ XI-1'),
(11605890, 'Syahrul Kamal', 'L', 'Cis 6', 'TKJ XI-2'),
(11605891, 'Syifa Dwi Anindita Putri', 'P', 'Wik 3', 'MMD XI-3'),
(11605892, 'Syifa Fitriawati', 'P', 'Cia 5', 'APK XI-1'),
(11605893, 'Syifa Gita Meilani', 'P', 'Wik 2', 'PMN XI-2'),
(11605895, 'Syifa Putri Apriliani', 'P', 'Cic 3', 'PMN XI-1'),
(11605896, 'Sylvia Julianti', 'P', 'Cic 3', 'APK XI-1'),
(11605897, 'Tania Pratiwi', 'P', 'Cib 1', 'PMN XI-1'),
(11605898, 'Tarisa Fajarina Satiri', 'P', 'Cia 5', 'APK XI-4'),
(11605899, 'Tasha Andini Afiany', 'P', 'Cib 1', 'APK XI-2'),
(11605900, 'Teddy Haryadi', 'L', 'Cic 6', 'PMN XI-1'),
(11605901, 'Tedi Alamsyah', 'L', 'Cic 4', 'RPL XI-2'),
(11605902, 'Teresa Angelina', 'P', 'Suk 2', 'MMD XI-1'),
(11605903, 'Tesa Nurdiani', 'P', 'Taj 4', 'APK XI-1'),
(11605904, 'Thoriq Abdul Basit', 'L', 'Wik 1', 'MMD XI-1'),
(11605905, 'Tian Ardiansyah Erlangga', 'L', 'Cis 2', 'TKJ XI-2'),
(11605906, 'Tobias Vinsensius Pradana', 'L', 'Wik 1', 'RPL XI-2'),
(11605907, 'Tri Wulan Dari', 'P', 'Cis 4', 'APK XI-2'),
(11605908, 'Tubagus Alif Syahrul Ramdoni', 'L', 'Taj 4', 'RPL XI-3'),
(11605909, 'Vina Nuralviani', 'P', 'Cia 5', 'PMN XI-1'),
(11605910, 'Virna Ameliana Putri', 'P', 'Taj 5', 'MMD XI-1'),
(11605911, 'Virnanda Asmy Luckyta', 'P', 'Cic 5', 'APK XI-3'),
(11605912, 'Wahyudis Hapitaliani', 'P', 'Cia 3', 'APK XI-3'),
(11605913, 'Wahyuni', 'P', 'Taj 5', 'APK XI-4'),
(11605914, 'Wanda Hamidah', 'P', 'Cib 3', 'APK XI-4'),
(11605915, 'Wida Widiyanti Aprilia', 'P', 'Cic 1', 'TKJ XI-1'),
(11605916, 'Willy Halim', 'L', 'Cis 4', 'PMN XI-2'),
(11605917, 'Windi Nuratmalia', 'P', 'Taj 5', 'MMD XI-2'),
(11605918, 'Yovan Arya Nugraha', 'L', 'Taj 3', 'PMN XI-2'),
(11605919, 'Yurisa Iryolusiadivi', 'P', 'Taj 2', 'APK XI-4'),
(11605920, 'Yushi Nur Afifah', 'P', 'Cia 4', 'APK XI-3'),
(11605921, 'Zainal Arifin Famungkas', 'L', 'Wik 1', 'TKJ XI-1'),
(11605922, 'Zeta Caradiva Bulansari', 'P', 'Cis 3', 'APK XI-2'),
(11605923, 'Zhafari Irsyad', 'L', 'Cia 5', 'RPL XI-3'),
(11605924, 'Zhofran Dhiqo Wibisono Wijayanto', 'L', 'Wik 2', 'RPL XI-4'),
(11605926, 'Indra Aulia Gustaldi', 'L', 'Taj 1', 'TKJ XI-1'),
(11605927, 'Shazira Rizky Wahyudi', 'P', 'SUK 1', 'APK XI-3'),
(11705928, 'Abednego Wicaksono Prasetyo', 'L', 'Suk 1', 'RPL X-3'),
(11705929, 'Abimanyu Pamungkas', 'L', 'Wik 2', 'MMD X-2'),
(11705930, 'Addafi Siraz Muzani', 'L', 'Cis 1', 'RPL X-3'),
(11705931, 'Ade Liana Ankuspa Putri', 'P', 'Wik 1', 'RPL X-2'),
(11705932, 'Adelia Adisthyani', 'P', 'Cic 6', 'OTKP X-1'),
(11705933, 'Adelia Sandra Dwi Endang Putri', 'P', 'Cic 2', 'OTKP X-1'),
(11705934, 'Adella Aprilia', 'P', 'Taj 5', 'HTL X-1'),
(11705935, 'Adiska Aulia Erwin ', 'P', 'Cib 1', 'RPL X-2'),
(11705936, 'Aditya Putra', 'L', 'Wik 2', 'TKJ X-2'),
(11705937, 'Agistie Nanda Pratiwie', 'P', 'Cis 1', 'TKJ X-4'),
(11705938, 'Agnes Agustin', 'P', 'Taj 3', 'RPL X-4'),
(11705939, 'Agnes Angela Surya Febriani', 'P', 'Cis 6', 'RPL X-1'),
(11705940, 'Agung Hendrawan', 'L', 'Cic 7', 'TKJ X-4'),
(11705941, 'Agung Mardiansyah', 'L', 'Cia 5', 'TKJ X-2'),
(11705942, 'Ahmad Arfan Permadi', 'L', 'Cia 1', 'TKJ X-1'),
(11705943, 'Ahmad Barizie Sirojul Ilmi', 'L', 'Cis 1', 'TKJ X-2'),
(11705944, 'Ahmad Daffa Dhaifullah', 'L', 'Cib 2', 'RPL X-4'),
(11705945, 'Ahmad Maulana Yusuf', 'L', 'Taj 3', 'TKJ X-3'),
(11705946, 'Ahmad Taufik Rahman', 'L', 'Cib 2', 'RPL X-2'),
(11705947, 'Ajeng Gaida Kartika Dewi', 'P', 'Taj 2', 'BDP X-2'),
(11705948, 'Akbar Kartiko', 'L', 'Taj 2', 'MMD X-2'),
(11705949, 'Akbar Yusuf Saputra', 'L', 'Cis 2', 'RPL X-4'),
(11705950, 'Aldi Susanto', 'L', 'Cis 5', 'TKJ X-1'),
(11705951, 'Alfina Azzahra', 'P', 'Cia 2', 'MMD X-2'),
(11705952, 'Alfiya Damayanti', 'P', 'Cic 2', 'HTL X-1'),
(11705953, 'Alif Adnan Ali', 'L', 'Taj 5', 'HTL X-1'),
(11705954, 'Alif Firmansyah', 'L', 'Taj 4', 'RPL X-1'),
(11705955, 'Aliya Rahmawati', 'P', 'Suk 1', 'OTKP X-1'),
(11705956, 'Aliyah Rachma Yunita', 'P', 'Cib 1', 'OTKP X-1'),
(11705957, 'Alvaro Fadillah Bachri', 'L', 'Cic 4', 'TKJ X-2'),
(11705958, 'Alya Shafira', 'P', 'Cib 3', 'BDP X-1'),
(11705959, 'Ananda Citra Hasyaputri', 'P', 'Cic 5', 'BDP X-2'),
(11705960, 'Ananda Desita Putri', 'P', 'Cis 2', 'BDP X-1'),
(11705961, 'Ananda Tri Agustin', 'P', 'Cib 3', 'BDP X-1'),
(11705962, 'Andhina Yorisa', 'P', 'Suk 2', 'TBG X-1'),
(11705963, 'Andi Raihan Maulana', 'L', 'Cic 5', 'HTL X-1'),
(11705964, 'Andini Amalia Suwardi', 'P', 'Cia 3', 'OTKP X-2'),
(11705965, 'Andre Setiawan', 'L', 'Taj 5', 'TBG X-1'),
(11705966, 'Andri Oktavian', 'L', 'Cia 2', 'MMD X-2'),
(11705967, 'Anesty Melva Suwandi', 'P', 'Cib 3', 'BDP X-1'),
(11705968, 'Angelive Hilsunny', 'P', 'Suk 1', 'MMD X-2'),
(11705969, 'Anggun Febri Hetisa Putri', 'P', 'Wik 3', 'TKJ X-3'),
(11705970, 'Anindia Febriyanti', 'P', 'Cia 1', 'OTKP X-2'),
(11705971, 'Anisa Cahyani', 'P', 'Cis 3', 'HTL X-1'),
(11705972, 'Anisa Yahayati', 'P', 'Wik 1', 'TKJ X-1'),
(11705973, 'Annisa Haryoko', 'P', 'Cis 4', 'TKJ X-3'),
(11705974, 'Anzeli Ratu Zahra Zalianti', 'P', 'Cib 3', 'OTKP X-1'),
(11705975, 'Ardiyanti Nada Aqilah', 'P', 'Taj 1', 'TBG X-1'),
(11705976, 'Ardyansyah Bayu Candra Sopyan', 'L', 'Cic 7', 'TKJ X-4'),
(11705977, 'Arif Fadhlurrohman', 'L', 'Taj 1', 'TKJ X-1'),
(11705978, 'Ariq Heritsa Maalik', 'L', 'Wik 1', 'RPL X-2'),
(11705979, 'Arjuna Efenus De Silalahi', 'L', 'Cib 1', 'RPL X-2'),
(11705980, 'Arnita Dwi Yuliyanti', 'P', 'Cic 6', 'OTKP X-1'),
(11705981, 'Artias Fahsya Annisa', 'P', 'Cic 7', 'BDP X-1'),
(11705982, 'Arya Rizal Mulqi', 'L', 'Cib 2', 'BDP X-1'),
(11705983, 'Asri Kumala', 'P', 'Cia 4', 'TBG X-1'),
(11705984, 'Astri Utami Febriani', 'P', 'Cia 1', 'MMD X-2'),
(11705985, 'Astrid Novika Damayanti', 'P', 'Cic 7', 'RPL X-2'),
(11705986, 'Aulia Mutiara', 'P', 'Suk 2', 'TKJ X-2'),
(11705987, 'Aurelia Agustin', 'P', 'Cis 4', 'MMD X-1'),
(11705988, 'Awal Nurizki', 'L', 'Cis 2', 'TKJ X-4'),
(11705989, 'Awaliah Zulhaida', 'P', 'Cic 5', 'HTL X-1'),
(11705990, 'Aysha Ryanti Putri', 'P', 'Cib 3', 'BDP X-1'),
(11705991, 'Ayu Tri Febriyanti', 'P', 'Suk 1', 'OTKP X-2'),
(11705992, 'Azhare Rasyid Kaliki', 'L', 'Cia 4', 'MMD X-2'),
(11705993, 'Azromi Ammar', 'L', 'Cia 5', 'RPL X-3'),
(11705994, 'Badarul Muharram', 'L', 'Cic 3', 'TKJ X-1'),
(11705995, 'Bagus Prasetyo', 'L', 'Cic 5', 'MMD X-2'),
(11705996, 'Bayu Apriyadi', 'L', 'Wik 2', 'RPL X-4'),
(11705997, 'Benikno Satria', 'L', 'Cic 2', 'BDP X-1'),
(11705998, 'Bilal Almarizal', 'L', 'Cic 6', 'TKJ X-4'),
(11705999, 'Chicco Eka Putra', 'L', 'Cic 5', 'TKJ X-3'),
(11706000, 'Cindi Pratama Dewi', 'P', 'Cic 3', 'HTL X-1'),
(11706001, 'Cindy Diva Amelia', 'P', 'Cic 2', 'OTKP X-1'),
(11706002, 'Dafa Rizki Fadillah', 'L', 'Cic 5', 'RPL X-2'),
(11706003, 'Daffa Ardian Fachrezy', 'L', 'Wik 1', 'TKJ X-4'),
(11706004, 'Dandung Janitra Nugroho', 'L', 'Suk 1', 'RPL X-1'),
(11706005, 'Daniel Sebastian Ramdan Gumulya', 'L', 'Suk 1', 'TKJ X-3'),
(11706006, 'Daris Dzakwan Kamiil', 'L', 'Cib 1', 'RPL X-4'),
(11706007, 'Daris Mustafid Hidayat', 'L', 'Wik 4', 'TKJ X-3'),
(11706008, 'Dea Fitri Rahmawati', 'P', 'Cis 5', 'HTL X-1'),
(11706009, 'Dea Lestari', 'P', 'Cia 2', 'TKJ X-4'),
(11706010, 'Deawy Azzahra', 'P', 'Cis 1', 'BDP X-2'),
(11706011, 'Dede Fitria', 'P', 'Cic 2', 'BDP X-1'),
(11706012, 'Dendha Fery Fernanda Pardede', 'L', 'Cib 1', 'TBG X-1'),
(11706013, 'Deni Hakim', 'L', 'Cis 1', 'TKJ X-4'),
(11706014, 'Denzel Gymnastiar Setiawan', 'L', 'Suk 1', 'MMD X-2'),
(11706015, 'Destyana Rahmah', 'P', 'Cib 3', 'BDP X-2'),
(11706016, 'Desy Lailasari', 'P', 'Cia 5', 'OTKP X-1'),
(11706017, 'Dewi Septianingsih', 'P', 'Suk 1', 'TKJ X-2'),
(11706018, 'Dhia Dzulfikar', 'L', 'Wik 1', 'HTL X-1'),
(11706019, 'Dhiya Galih Luthfenia', 'P', 'Taj 3', 'RPL X-3'),
(11706020, 'Dian Rahmawati', 'P', 'Cia 4', 'HTL X-1'),
(11706021, 'Dimas Aji Febriansyah', 'L', 'Taj 5', 'HTL X-1'),
(11706022, 'Dimas Ardi Basyari', 'L', 'Cic 2', 'TKJ X-2'),
(11706023, 'Dimas Roger Widianto', 'L', 'Cic 5', 'RPL X-1'),
(11706024, 'Dimas Septiansyah', 'L', 'Taj 1', 'TKJ X-2'),
(11706025, 'Dimas Triyono', 'L', 'Cic 2', 'TKJ X-3'),
(11706026, 'Dina Julia Ningsih', 'P', 'Taj 3', 'TBG X-1'),
(11706027, 'Dinda Ajeng Cahyani', 'P', 'Cic 4', 'BDP X-1'),
(11706028, 'Dinda Utami', 'P', 'Taj 2', 'MMD X-2'),
(11706030, 'Dwi Febryansyah', 'L', 'Cic 5', 'RPL X-3'),
(11706031, 'Dwi Wahyu Saputra', 'L', 'Wik 1', 'TKJ X-2'),
(11706032, 'Dwisesha Bagas Putrama Suminar', 'L', 'Cic 2', 'RPL X-3'),
(11706033, 'Eka Rizki Andika', 'L', 'Taj 2', 'TBG X-1'),
(11706034, 'Elsa Ayudia Sembiring', 'P', 'Cia 5', 'OTKP X-2'),
(11706035, 'Elsa Destriani Putri', 'P', 'Cic 6', 'MMD X-2'),
(11706036, 'Emilia Muspita Oktaviani', 'P', 'Cia 2', 'HTL X-1'),
(11706037, 'Eneng Rita Agustina', 'P', 'Cic 7', 'RPL X-2'),
(11706038, 'Eno Altriana Putri', 'P', 'Cic 7', 'RPL X-4'),
(11706039, 'Erian Refliansyah Sofyan Salilama', 'L', 'Cia 5', 'TKJ X-4'),
(11706040, 'Erik Restu Lesmana', 'L', 'Taj 4', 'TKJ X-4'),
(11706041, 'Erika Wisda Tiara', 'P', 'Taj 4', 'RPL X-2'),
(11706042, 'Eriza Destiandini Syaidi', 'P', 'Wik 2', 'TBG X-1'),
(11706043, 'Erlita Agustina', 'P', 'Cic 2', 'OTKP X-1'),
(11706044, 'Ernest Widjaja', 'L', 'Wik 2', 'RPL X-1'),
(11706045, 'Eva Aditia', 'P', 'Taj 2', 'OTKP X-1'),
(11706046, 'Eva Apriyana', 'P', 'Taj 5', 'BDP X-1'),
(11706047, 'Fadhila Handayani', 'P', 'Taj 2', 'MMD X-2'),
(11706048, 'Fadlika Inasya Putri', 'P', 'Suk 1', 'MMD X-2'),
(11706049, 'Faisal Listian Haris', 'L', 'Cia 3', 'TKJ X-3'),
(11706050, 'Faisal Rassya Aldani', 'L', 'Cic 2', 'TKJ X-4'),
(11706051, 'Faishal Raihan Kurnianto', 'L', 'Wik 4', 'MMD X-2'),
(11706052, 'Faisol Nurrahmat', 'L', 'Cib 3', 'RPL X-3'),
(11706053, 'Farah Diba Rezi Fauziah', 'P', 'Cia 5', 'HTL X-1'),
(11706054, 'Farraz Sabrina', 'P', 'Cic 2', 'TKJ X-3'),
(11706055, 'Fathiya Anindyta Salsabila', 'P', 'Cib 1', 'OTKP X-2'),
(11706056, 'Fatima Azzahra', 'P', 'Cib 1', 'MMD X-2'),
(11706057, 'Fatimah Zahra Alfazriany', 'P', 'Cis 5', 'BDP X-2'),
(11706058, 'Fatma Laila Salsabilla', 'P', 'Cia 1', 'BDP X-1'),
(11706059, 'Fauzan Hanif', 'L', 'Taj 5', 'TBG X-1'),
(11706060, 'Febian Afwa Khoerunnisa', 'P', 'Suk 1', 'OTKP X-1'),
(11706061, 'Felita Salsabila', 'P', 'Suk 2', 'MMD X-1'),
(11706062, 'Fifi Lutfiah', 'P', 'Suk 1', 'RPL X-4'),
(11706064, 'Firdaus Werdayansah', 'L', 'Cis 5', 'TKJ X-3'),
(11706065, 'Fitri Ruhimah', 'P', 'Cic 2', 'RPL X-3'),
(11706066, 'Fitrianingsih', 'P', 'Taj 3', 'OTKP X-2'),
(11706067, 'Fitriyani', 'P', 'Cis 4', 'OTKP X-2'),
(11706069, 'Fujianingsih', 'P', 'Taj 2', 'RPL X-1'),
(11706070, 'Gabriel Alfinsius Renggi', 'L', 'Cia 2', 'TKJ X-1'),
(11706071, 'Galuh Fauziah', 'P', 'Wik 4', 'TKJ X-1'),
(11706072, 'Gifin Tri Julian', 'L', 'Cic 1', 'RPL X-2'),
(11706073, 'Gita Irrenza', 'P', 'Taj 5', 'HTL X-1'),
(11706074, 'Hafizd Ibrahim Fawwaz', 'L', 'Suk 1', 'RPL X-3'),
(11706075, 'Halisa Riezkya Fadila', 'P', 'Cia 2', 'BDP X-2'),
(11706076, 'Hamdi Hardika', 'L', 'Cic 2', 'TKJ X-4'),
(11706077, 'Hasan Mustofa', 'L', 'Cis 1', 'BDP X-2'),
(11706078, 'Helga Giovanni Idelia', 'P', 'Taj 3', 'BDP X-1'),
(11706079, 'Helmia Syadiatu Zahra', 'P', 'Cib 1', 'RPL X-2'),
(11706080, 'Heri Rizal Setiawan', 'L', 'Wik 1', 'TKJ X-1'),
(11706081, 'Herlina Putri Laurent', 'P', 'Cia 5', 'OTKP X-2'),
(11706082, 'Herlina Yuan Rahmadhani', 'P', 'Cis 5', 'BDP X-2'),
(11706084, 'Ikbal Hibatulloh', 'L', 'Cib 3', 'TKJ X-2'),
(11706085, 'Imam Firmansyah', 'L', 'Cis 2', 'RPL X-4'),
(11706086, 'Inayatul Miskiah', 'P', 'Wik 4', 'RPL X-3'),
(11706087, 'Indah Destriyani', 'P', 'Cis 1', 'BDP X-1'),
(11706088, 'Ipan Maulana', 'L', 'Taj 4', 'MMD X-1'),
(11706089, 'Iqbal Nurizky', 'L', 'Taj 5', 'TKJ X-3'),
(11706090, 'Irma', 'P', 'Suk 2', 'BDP X-2'),
(11706091, 'Irmaliani', 'L', 'Cic 4', 'RPL X-4'),
(11706092, 'Irsan Febriansyah', 'L', 'Cib 1', 'HTL X-1'),
(11706093, 'Ismanto', 'L', 'Cic 2', 'OTKP X-2'),
(11706094, 'Jafar Shodiq Asmali', 'L', 'Wik 3', 'TKJ X-3'),
(11706095, 'Jamaludin', 'L', 'Cis 2', 'RPL X-1'),
(11706096, 'James Nathanael', 'L', 'Cic 7', 'RPL X-1'),
(11706097, 'Johana Febriyani Suteja', 'P', 'Taj 3', 'OTKP X-2'),
(11706098, 'Joshua Natanael Wijaya', 'L', 'Taj 2', 'BDP X-2'),
(11706099, 'Jovandra Axl Pay', 'L', 'Wik 1', 'MMD X-1'),
(11706100, 'Julian Maulana Thamrin', 'L', 'Cia 5', 'TKJ X-1'),
(11706101, 'Kamaludin Rivaldi', 'L', 'Cib 1', 'TKJ X-1'),
(11706102, 'Karin Rizki Maulidta', 'P', 'Suk 1', 'MMD X-1'),
(11706103, 'Kavin Alderan', 'L', 'Wik 2', 'TBG X-1'),
(11706104, 'Kayla Izza Yalma', 'P', 'Cib 3', 'RPL X-3'),
(11706105, 'Khairunnisa Nurfarida', 'P', 'Cic 6', 'TKJ X-4'),
(11706106, 'Kharisma Candra Kirana', 'P', 'Cis 1', 'OTKP X-2'),
(11706107, 'Kiki Prastiwi Ananda', 'P', 'Cis 5', 'TKJ X-2'),
(11706108, 'Kresna Adinata', 'L', 'Cis 1', 'MMD X-1'),
(11706109, 'Kriesna Rianny', 'P', 'Taj 2', 'BDP X-2'),
(11706110, 'Kurnia Nurfadilah', 'P', 'Taj 2', 'OTKP X-2'),
(11706111, 'Leviany Jesilia Sopamena', 'P', 'Cis 5', 'HTL X-1'),
(11706112, 'Lianintan Suci', 'P', 'Cia 3', 'MMD X-2'),
(11706113, 'Linda Apriyanti', 'P', 'Cia 1', 'BDP X-2'),
(11706114, 'Lingga Aksara Adiyatma', 'L', 'Cib 3', 'RPL X-4'),
(11706115, 'Liska Damayanti', 'P', 'Cib 2', 'MMD X-1'),
(11706116, 'Lita', 'P', 'Wik 1', 'OTKP X-2'),
(11706117, 'Lola Wati', 'P', 'Taj 3', 'HTL X-1'),
(11706118, 'Lulu Chairul Nisa', 'P', 'Cis 1', 'MMD X-1'),
(11706119, 'Lustiara Nazwa Azzahra', 'P', 'Wik 4', 'TBG X-1'),
(11706120, 'Luthfia Nur Azizah', 'P', 'Taj 2', 'MMD X-2'),
(11706121, 'M. Adriansyah Priyatna Putra', 'L', 'Cia 5', 'TKJ X-3'),
(11706122, 'Muhamad Akbar Fadilah', 'L', 'Cib 2', 'RPL X-2'),
(11706123, 'M. Alfi Ariansyah', 'L', 'Cis 2', 'TKJ X-1'),
(11706124, 'M. Alfin Aditya Ramadhan', 'L', 'Cic 6', 'TKJ X-3'),
(11706125, 'M. Andriawan Ridwan', 'L', 'Cis 3', 'RPL X-1'),
(11706126, 'Muhammad Naufal Fadhil Rahmat', 'L', 'Cic 2', 'BDP X-1'),
(11706127, 'M. Naufal Ramdhani', 'L', 'Cic 4', 'BDP X-2'),
(11706128, 'M. Pajar Purnama Diningrat', 'L', 'Cis 4', 'TBG X-1'),
(11706129, 'M. Rafi Iskandar', 'L', 'Cic 4', 'TKJ X-3'),
(11706130, 'Mohammad Rafli Dwiputra', 'L', 'Cic 6', 'TKJ X-2'),
(11706131, 'M.Rafly Fajar Alghifari', 'L', 'Wik 2', 'MMD X-1'),
(11706132, 'Muhamad Randika Satria Putra', 'L', 'Cis 3', 'TKJ X-1'),
(11706133, 'M.Restu Inyasdi Kahvi', 'L', 'Cis 5', 'RPL X-4'),
(11706134, 'Muhamad Virgiawan Dwi Rangga', 'L', 'Taj 3', 'RPL X-2'),
(11706135, 'Maharani', 'L', 'Cia 2', 'TBG X-1'),
(11706136, 'Maharani Khalilah Syahputri', 'P', 'Cic 7', 'RPL X-2'),
(11706137, 'Maharani Utami Destiansyah', 'P', 'Cic 5', 'OTKP X-2'),
(11706138, 'Mahardhika Vijayana', 'L', 'Cib 1', 'MMD X-1'),
(11706139, 'Malida Nur Hamidah', 'P', 'Cib 3', 'OTKP X-1'),
(11706140, 'Maria De Liguori Imaculata', 'P', 'Cic 6', 'RPL X-4'),
(11706141, 'Marsela Oktavia', 'P', 'Cia 4', 'HTL X-1'),
(11706142, 'Mauladi Arif Iqbal', 'L', 'Cic 2', 'RPL X-1'),
(11706143, 'Maulana Fattur Fahman', 'L', 'Cic 6', 'HTL X-1'),
(11706144, 'Maulana Yusuf Ibrohim', 'L', 'Cib 1', 'RPL X-4'),
(11706145, 'Meilinda Krisanti', 'P', 'Taj 3', 'BDP X-1'),
(11706146, 'Melatie Auramaulidina Puteri Inayah', 'P', 'Cic 6', 'OTKP X-2'),
(11706147, 'Michael Kurniawan Prananto', 'L', 'Wik 1', 'MMD X-2'),
(11706148, 'Michellia Aryanti', 'P', 'Cis 5', 'HTL X-1'),
(11706149, 'Mira Tania Amalia', 'P', 'Cib 3', 'BDP X-2'),
(11706150, 'Moch Dika Firdaus', 'L', 'Cia 5', 'MMD X-2'),
(11706151, 'Mochamad Aditya Yazid', 'L', 'Cia 5', 'BDP X-2'),
(11706152, 'Mochamad Al-Fazri Januar', 'L', 'Taj 2', 'TKJ X-4'),
(11706153, 'Mochamad Ardafa Pratama', 'L', 'Cis 5', 'RPL X-2'),
(11706154, 'Mochamad Diass Asyami', 'L', 'Cic 5', 'TKJ X-3'),
(11706155, 'Mochamad Faiz Alamsyah ', 'L', 'Cis 5', 'RPL X-3'),
(11706156, 'Mochamad Irgi', 'L', 'Taj 2', 'TKJ X-3'),
(11706157, 'Mochamad Satriatna', 'L', 'Cis 5', 'RPL X-4'),
(11706158, 'Moh. Idam Fathahillah', 'L', 'Cic 7', 'TBG X-1'),
(11706159, 'Mohamad Fahmi Sechan', 'L', 'Cib 2', 'RPL X-2'),
(11706161, 'Mohammad Farly Putra Abidin', 'L', 'Cia 2', 'TBG X-1'),
(11706162, 'Muchtarom', 'L', 'Cis 3', 'RPL X-3'),
(11706163, 'Muhamad Abdul Jabar', 'L', 'Cia 4', 'TKJ X-1'),
(11706164, 'Muhamad Ardiansyah', 'L', 'Cis 6', 'TKJ X-1'),
(11706165, 'Muhamad Ariefin Ilham', 'L', 'Wik 1', 'TKJ X-4'),
(11706166, 'Muhamad Dias Maulana', 'L', 'Cia 5', 'MMD X-1'),
(11706167, 'Muhamad Dimas Ramadhan', 'L', 'Cis 1', 'RPL X-3'),
(11706168, 'Muhamad Fadhil Eka Lesmana', 'L', 'Cic 1', 'TKJ X-2'),
(11706169, 'Muhamad Faisal Ramadhan', 'L', 'Cic 1', 'MMD X-1'),
(11706170, 'Muhammad Farhan', 'L', 'Taj 3', 'MMD X-2'),
(11706171, 'Muhamad Farid Mahindra', 'L', 'Cic 1', 'RPL X-3'),
(11706172, 'Muhamad Faturahman', 'L', 'Taj 1', 'TKJ X-3'),
(11706173, 'Muhamad Fauzi Azhar', 'L', 'Cis 1', 'MMD X-2'),
(11706174, 'Muhamad Fikri Adjie', 'L', 'Cib 2', 'TKJ X-3'),
(11706175, 'Muhamad Fikri Ilhamsyah', 'L', 'Cis 2', 'RPL X-2'),
(11706176, 'Muhamad Firmansyah', 'L', 'Cic 5', 'RPL X-2'),
(11706177, 'Muhamad Hildan Pratama', 'L', 'Cis 1', 'MMD X-2'),
(11706178, 'Muhamad Ikbal Abdullah', 'L', 'Cis 2', 'TKJ X-3'),
(11706179, 'Muhamad Ikhsan', 'L', 'Cis 1', 'RPL X-1'),
(11706180, 'Muhamad Ilham Fadilah ', 'L', 'Cis 5', 'RPL X-1'),
(11706181, 'Muhamad Lutfi Ardiansyah', 'L', 'Suk 2', 'RPL X-1'),
(11706183, 'Muhamad Rafli Fadillah', 'L', 'Cib 2', 'TKJ X-2'),
(11706184, 'Muhamad Rafli Wijayanto', 'L', 'Cis 3', 'TKJ X-3'),
(11706185, 'Muhamad Rahman Dika Wilarto', 'L', 'Cic 5', 'TKJ X-1'),
(11706186, 'Muhamad Rajih Rabbani', 'L', 'Cic 7', 'MMD X-1'),
(11706187, 'Muhamad Rediansyah', 'L', 'Cia 1', 'TKJ X-3'),
(11706188, 'Muhamad Reza Pratama', 'L', 'Taj 3', 'MMD X-1'),
(11706189, 'Muhamad Ridwan', 'L', 'Cia 2', 'RPL X-3'),
(11706190, 'Muhamad Ridwan', 'L', 'Cic 6', 'TKJ X-4'),
(11706191, 'Muhamad Rifki Fadilah', 'L', 'Taj 2', 'MMD X-2'),
(11706192, 'Muhamad Riyansyah', 'L', 'Cis 1', 'TBG X-1'),
(11706193, 'Muhamad Rizki Abdul Latif', 'L', 'Cic 6', 'MMD X-1'),
(11706194, 'Muhamad Rizkianda', 'L', 'Cia 2', 'RPL X-2'),
(11706195, 'Muhamad Rizkie Aditia', 'L', 'Cis 1', 'TKJ X-2'),
(11706196, 'Muhamad Sofyan Muladi', 'L', 'Taj 3', 'MMD X-1'),
(11706197, 'Muhamad Syahrul Apriliansyah', 'L', 'Cib 3', 'RPL X-3'),
(11706198, 'Muhamad Syukri Lukita', 'L', 'Cia 2', 'TKJ X-2'),
(11706199, 'Muhamad Wildan', 'L', 'Cic 2', 'RPL X-1');
INSERT INTO `siswa` (`nis`, `nama`, `jk`, `rayon`, `rombel`) VALUES
(11706200, 'Muhamad Yolan Permana', 'L', 'Wik 1', 'RPL X-1'),
(11706201, 'Muhamad Zidan Mulyasaputra', 'L', 'Taj 4', 'TKJ X-1'),
(11706202, 'Muhamad Zulkifli', 'L', 'Cic 3', 'RPL X-1'),
(11706203, 'Muhamad Abdul Rohman', 'L', 'Cib 3', 'MMD X-1'),
(11706204, 'Muhammad Abdullah Alwahdi', 'L', 'Wik 3', 'TKJ X-2'),
(11706205, 'Muhammad Agung Mulyana', 'L', 'Cib 1', 'BDP X-2'),
(11706206, 'Muhammad Alfurqaan', 'L', 'Taj 5', 'TKJ X-4'),
(11706207, 'Muhammad Arafi', 'L', 'Cis 1', 'TKJ X-3'),
(11706208, 'Muhammad Arif Alhaeni', 'L', 'Cic 5', 'HTL X-1'),
(11706209, 'Muhammad Arif Maulana', 'L', 'Cia 5', 'TKJ X-4'),
(11706210, 'Muhammad Ariq Khawan', 'L', 'Cic 6', 'RPL X-2'),
(11706211, 'Muhammad Athaberyl Ramadhyli Adl', 'L', 'Cis 3', 'RPL X-3'),
(11706212, 'Muhammad Azhar Fadillah Kusumawardhana', 'L', 'Taj 3', 'MMD X-1'),
(11706213, 'Muhammad Daffa Deannova Irawan', 'L', 'Cic 2', 'MMD X-1'),
(11706214, 'Muhammad Dikiyansyah', 'L', 'Cia 2', 'MMD X-2'),
(11706215, 'Muhamad Ardi Firdaus ', 'L', 'Cic 2', 'RPL X-3'),
(11706216, 'Muhammad Fadli Hasan', 'L', 'Cic 5', 'HTL X-1'),
(11706217, 'Muhammad Fahri Saikal', 'L', 'Cis 1', 'TKJ X-1'),
(11706218, 'Muhammad Faisal Fazri', 'L', 'Cic 5', 'TKJ X-4'),
(11706219, 'Muhammad Faiz Fadillah', 'L', 'Cis 6', 'TKJ X-4'),
(11706220, 'Muhammad Farhan Darmawan', 'L', 'Cib 2', 'RPL X-3'),
(11706221, 'Muhammad Fauzi', 'L', 'Taj 5', 'TBG X-1'),
(11706222, 'Muhammad Fauzi Ridwan', 'L', 'Cic 2', 'MMD X-2'),
(11706223, 'Muhammad Febri Hidayatulloh', 'L', 'Taj 4', 'TKJ X-4'),
(11706224, 'Muhammad Febrian Arrasyid', 'L', 'Cis 1', 'RPL X-4'),
(11706225, 'Muhammad Febrianto', 'L', 'Cic 5', 'RPL X-2'),
(11706226, 'Muhammad Fikri Pratama Allatif', 'L', 'Cia 5', 'HTL X-1'),
(11706227, 'Muhammad Galuh Aldiyaksya', 'L', 'Cic 6', 'MMD X-2'),
(11706228, 'Muhammad Ghifari', 'L', 'Cia 1', 'RPL X-4'),
(11706229, 'Muhammad Haidar Lazuardi', 'L', 'Cib 1', 'RPL X-2'),
(11706230, 'Muhammad Hardiansyah', 'L', 'Wik 4', 'MMD X-1'),
(11706231, 'Muhammad Ichsan Khairullah', 'L', 'Taj 3', 'HTL X-1'),
(11706232, 'Muhammad Ikhsan Maulana', 'L', 'Cia 1', 'TKJ X-2'),
(11706233, 'Muhammad Ikram Jordy', 'L', 'Wik 3', 'TKJ X-4'),
(11706234, 'Muhammad Ilham Husein', 'L', 'Cic 7', 'RPL X-4'),
(11706235, 'Muhammad Ilham Maulidian', 'L', 'Cib 3', 'BDP X-1'),
(11706236, 'Muhammad Ilyas Destira', 'L', 'Cia 5', 'MMD X-1'),
(11706237, 'Muhammad Khairil Fajar', 'L', 'Cis 1', 'RPL X-3'),
(11706238, 'Muhammad Mauladi', 'L', 'Cis 6', 'BDP X-2'),
(11706239, 'Muhammad Maulana', 'L', 'Taj 3', 'BDP X-1'),
(11706240, 'Muhammad Mushin Yasir', 'L', 'Cis 1', 'RPL X-4'),
(11706241, 'Muhammad Mukhlis Rifai', 'L', 'Cic 2', 'RPL X-4'),
(11706242, 'Muhammad Muntasir', 'L', 'Taj 3', 'RPL X-2'),
(11706243, 'Muhammad Naufal Zaidan', 'L', 'Cic 6', 'RPL X-4'),
(11706244, 'Muhammad Rafi Alamsyah', 'L', 'Cia 3', 'OTKP X-1'),
(11706245, 'Muhammad Raflillah Pratama', 'L', 'Taj 4', 'TKJ X-4'),
(11706246, 'Muhammad Ramdan Fauzi', 'L', 'Cib 2', 'RPL X-2'),
(11706247, 'Muhammad Rayhan Alfaraby Aslam ', 'L', 'Cic 6', 'RPL X-2'),
(11706248, 'Muhammad Rayhan Alghifari Nugroho', 'L', 'Cic 4', 'TKJ X-1'),
(11706249, 'Muhammad Renaldi Pajrin', 'L', 'Cic 1', 'MMD X-2'),
(11706250, 'Muhammad Rico Fedryan', 'L', 'Cis 1', 'TKJ X-1'),
(11706251, 'Muhammad Ridho Irgiansyah', 'L', 'Cib 3', 'RPL X-4'),
(11706252, 'Muhammad Rifaldi Hibatullah', 'L', 'Cia 4', 'TKJ X-2'),
(11706253, 'Muhammad Riziq Mulyadi', 'L', 'Cic 5', 'RPL X-2'),
(11706254, 'Muhammad Robbi Zulfikar', 'L', 'Cia 2', 'RPL X-3'),
(11706255, 'Muhammad Sigit Pratama', 'L', 'Taj 2', 'BDP X-2'),
(11706256, 'Muhammad Sultan Malik', 'L', 'Wik 2', 'MMD X-1'),
(11706258, 'Muhammad Yandika Ramadhan', 'L', 'Cis 1', 'BDP X-2'),
(11706259, 'Muhammad Yaumil Ramadhani', 'L', 'Cic 7', 'RPL X-4'),
(11706260, 'Muhammad Yudistira Putra Pratama', 'L', 'Cis 2', 'RPL X-2'),
(11706261, 'Muhammad Zulfian Zaini', 'L', 'Cic 1', 'BDP X-2'),
(11706262, 'Mulyana Amalia', 'P', 'Cis 1', 'BDP X-1'),
(11706263, 'Mustafa Surya Syahputra', 'L', 'Wik 2', 'RPL X-2'),
(11706264, 'Muthia Aisyah Syahidah', 'P', 'Wik 4', 'TKJ X-1'),
(11706265, 'Mutiara Diva Riyandi', 'P', 'Cic 7', 'OTKP X-2'),
(11706266, 'Mutiara Nurhandayani', 'P', 'Cic 1', 'TBG X-1'),
(11706267, 'Nabila Baedani', 'P', 'Cic 2', 'HTL X-1'),
(11706268, 'Nadia Nuraida', 'P', 'Cic 5', 'BDP X-2'),
(11706269, 'Nadya Fauziah Putri Utami', 'P', 'Cib 1', 'OTKP X-2'),
(11706270, 'Nadzira Ahdan Samawarda', 'P', 'Cic 2', 'TKJ X-4'),
(11706271, 'Nadzira Alexandra', 'P', 'Wik 4', 'MMD X-2'),
(11706272, 'Naffa Annazwa Utami', 'P', 'Cis 1', 'BDP X-2'),
(11706273, 'Naila Fauziah Vianty', 'P', 'Cic 4', 'RPL X-1'),
(11706274, 'Nandio Septian Danuarta', 'P', 'Cia 5', 'TKJ X-2'),
(11706275, 'Nastma Dzia', 'P', 'Taj 5', 'TKJ X-4'),
(11706276, 'Naufal Akbar Adilah', 'L', 'Cia 5', 'RPL X-2'),
(11706277, 'Nazira Zahra Windayani', 'P', 'Cia 3', 'MMD X-2'),
(11706278, 'Neddy Avgha Prasetio', 'L', 'Cic 7', 'RPL X-3'),
(11706279, 'Neneng Novitawati Rahmadhani', 'P', 'Cic 7', 'HTL X-1'),
(11706280, 'Nessa Julan Aulia', 'P', 'Cic 2', 'TBG X-1'),
(11706281, 'Nindya Eka Putri Pangestu', 'P', 'Cic 1', 'OTKP X-2'),
(11706282, 'Nisa Siti Al-Hadawiah', 'P', 'Wik 4', 'OTKP X-2'),
(11706283, 'Nisrina Nurazizah', 'P', 'Wik 3', 'BDP X-2'),
(11706284, 'Nisya Andini', 'P', 'Cib 3', 'MMD X-1'),
(11706285, 'Nopita Lestari', 'P', 'Cis 5', 'TKJ X-4'),
(11706286, 'Novi Widia Damayanti', 'P', 'Taj 2', 'RPL X-2'),
(11706287, 'Nur Arsy', 'P', 'Cic 4', 'MMD X-2'),
(11706288, 'Nurizkiawati', 'P', 'Cic 6', 'BDP X-1'),
(11706289, 'Nurmalia Hidayah', 'P', 'Cia 4', 'OTKP X-2'),
(11706290, 'Nurmayanti', 'P', 'Cis 1', 'OTKP X-2'),
(11706291, 'Nurul Aeni', 'P', 'Suk 1', 'TBG X-1'),
(11706292, 'Nurul Aflah Nasution', 'P', 'Cis 3', 'BDP X-1'),
(11706293, 'Nurul Astiawati', 'L', 'Cia 4', 'TBG X-1'),
(11706294, 'Nurul Hidayah', 'P', 'Cib 1', 'MMD X-1'),
(11706295, 'Nurul Ulfa Ruslia', 'P', 'Cic 5', 'RPL X-3'),
(11706296, 'Nurwasyipa Aulia', 'P', 'Cia 3', 'OTKP X-2'),
(11706297, 'Prayogo Pangestu', 'L', 'Taj 4', 'TKJ X-3'),
(11706298, 'Prayudha Arya Nugraha', 'L', 'Cic 3', 'HTL X-1'),
(11706299, 'Putri Anasti Kholidiah', 'P', 'Cis 3', 'OTKP X-1'),
(11706300, 'Putu Ferayani', 'P', 'Cia 2', 'TKJ X-2'),
(11706301, 'R.Mohamad Alfiansyah Prawira', 'L', 'Cia 5', 'BDP X-1'),
(11706302, 'Rachmat Hidayat', 'L', 'Taj 2', 'TKJ X-4'),
(11706303, 'Raden Anita Nur Salsabila', 'P', 'Cic 4', 'OTKP X-2'),
(11706304, 'Raden Syarif', 'L', 'Cia 3', 'RPL X-2'),
(11706305, 'Rafi Aprilian', 'L', 'Wik 1', 'RPL X-3'),
(11706306, 'Rafli Ilham Alamsyah', 'L', 'Cic 1', 'MMD X-1'),
(11706307, 'Rafli Kurnia Ramdhan', 'L', 'Cic 7', 'RPL X-1'),
(11706308, 'Rafli Rai Rizky', 'L', 'Cic 5', 'RPL X-3'),
(11706309, 'Raflyansyah Adi Pratama', 'L', 'Cis 1', 'RPL X-1'),
(11706310, 'Ragil Latifah Fatin', 'L', 'Cis 6', 'OTKP X-1'),
(11706311, 'Raihan Adipramana', 'L', 'Cis 5', 'TKJ X-1'),
(11706312, 'Raihan Saiya Bustaman', 'L', 'Cic 2', 'RPL X-3'),
(11706313, 'Raina Azaliyah Putri', 'P', 'Cia 1', 'OTKP X-2'),
(11706314, 'Rairana Syahdam Dafala', 'L', 'Cis 2', 'TKJ X-3'),
(11706315, 'Ramdani Syaputra', 'L', 'Cis 5', 'RPL X-1'),
(11706316, 'Ratu Alisha', 'P', 'Cia 2', 'OTKP X-1'),
(11706317, 'Ratu Dhelila Apriani Humaidi', 'P', 'Cic 3', 'BDP X-1'),
(11706318, 'Raudatul Jannah', 'P', 'Taj 3', 'OTKP X-1'),
(11706319, 'Reihan Akmal Harimulya', 'L', 'Cic 6', 'TKJ X-4'),
(11706320, 'Renita Nur Pajar', 'P', 'Wik 2', 'RPL X-1'),
(11706321, 'Resa Dwi Putra Mahendra', 'L', 'Cib 2', 'OTKP X-1'),
(11706322, 'Resa Rezeky Hutasoit', 'P', 'Suk 1', 'BDP X-2'),
(11706323, 'Resky Ardiani', 'P', 'Cic 6', 'MMD X-1'),
(11706324, 'Resti Oktaviani', 'P', 'Suk 1', 'TKJ X-3'),
(11706325, 'Reva Anggraeni', 'P', 'Suk 2', 'TKJ X-1'),
(11706326, 'Reza Ramadhan Irianto', 'L', 'Cic 6', 'RPL X-4'),
(11706327, 'Rezha Pramudia A', 'L', 'Wik 2', 'RPL X-1'),
(11706328, 'Rezka Azzahra', 'P', 'Cis 1', 'OTKP X-1'),
(11706329, 'Rida', 'P', 'Cia 2', 'BDP X-1'),
(11706330, 'Rida Nurhelina', 'P', 'Cic 2', 'OTKP X-2'),
(11706331, 'Rifaldi Nurhadiansyah', 'L', 'Cic 5', 'MMD X-1'),
(11706332, 'Rifqi Syadzwana Ramadhan', 'L', 'Cic 3', 'RPL X-3'),
(11706334, 'Rina Yuriana', 'P', 'Cib 3', 'TBG X-1'),
(11706335, 'Riska Juliani Usman', 'P', 'Taj 3', 'BDP X-1'),
(11706336, 'Riski Ramadan', 'L', 'Taj 5', 'MMD X-2'),
(11706337, 'Risma Nurhasanah', 'P', 'Cis 6', 'OTKP X-2'),
(11706338, 'Rista Ruhan Pramascia', 'P', 'Cic 1', 'OTKP X-2'),
(11706339, 'Rival Nazar Ruslan', 'L', 'Cis 1', 'HTL X-1'),
(11706340, 'Rizal Awaludin', 'L', 'Wik 2', 'RPL X-4'),
(11706341, 'Rizfi Afriandi', 'L', 'Cic 2', 'TKJ X-3'),
(11706342, 'Rizky Ramon', 'L', 'Cis 1', 'RPL X-4'),
(11706343, 'Rosita', 'P', 'Taj 5', 'HTL X-1'),
(11706344, 'Rulyan Suwandi', 'L', 'Cis 5', 'OTKP X-2'),
(11706345, 'Saefadhli Khoiri', 'L', 'Cia 5', 'TKJ X-3'),
(11706346, 'Safitri Nur Rizki', 'P', 'Taj 2', 'MMD X-1'),
(11706347, 'Salfira Rahmi Anzani', 'P', 'Cic 3', 'OTKP X-2'),
(11706348, 'Salman Faris', 'L', 'Cia 2', 'RPL X-4'),
(11706349, 'Salsabila Raihana Darmawan', 'P', 'Cic 1', 'MMD X-1'),
(11706350, 'Samuel Sambera', 'L', 'Cib 1', 'MMD X-1'),
(11706351, 'Sanjaya', 'L', 'Cia 2', 'RPL X-4'),
(11706352, 'Satria Anugrah Pamungkas', 'L', 'Taj 2', 'TKJ X-2'),
(11706353, 'Satriyo Nuraji Rasa ', 'L', 'Cic 2', 'RPL X-3'),
(11706354, 'Satriyo Agung Ramadhan', 'L', 'Cic 6', 'RPL X-1'),
(11706355, 'Savera Joviana Putri Djama', 'P', 'Cic 7', 'OTKP X-1'),
(11706356, 'Selvia Pratiwi', 'P', 'Cic 5', 'TKJ X-4'),
(11706357, 'Seno Putra Prakoso', 'L', 'Cic 4', 'TBG X-1'),
(11706358, 'Sephia Herliana Muchtar', 'P', 'Taj 3', 'BDP X-1'),
(11706359, 'Septhiya Rachmawati', 'P', 'Cib 3', 'TKJ X-3'),
(11706360, 'Septi Aulia', 'P', 'Cic 2', 'OTKP X-1'),
(11706361, 'Shafa Haniyah', 'P', 'Cic 2', 'MMD X-1'),
(11706363, 'Shalsha Syabyllah', 'P', 'Taj 3', 'BDP X-1'),
(11706364, 'Shandra Dwi Putra Hasibuan', 'L', 'Cis 2', 'RPL X-1'),
(11706365, 'Shankara Argatira Bima', 'L', 'Suk 1', 'BDP X-1'),
(11706366, 'Shofira Khairunnisa ', 'P', 'Cib 2', 'RPL X-4'),
(11706367, 'Silvany Verolita Sibarani', 'P', 'Cic 3', 'RPL X-1'),
(11706368, 'Silvia Natasya', 'P', 'Cis 1', 'HTL X-1'),
(11706369, 'Silvia Noviyani', 'P', 'Cic 7', 'HTL X-1'),
(11706370, 'Sinta Dwi Agustina', 'P', 'Taj 2', 'OTKP X-2'),
(11706371, 'Siti Aliyah', 'P', 'Cia 3', 'OTKP X-1'),
(11706372, 'Siti Azizah', 'P', 'Cia 3', 'OTKP X-1'),
(11706373, 'Siti Azzahra', 'P', 'Cib 2', 'OTKP X-2'),
(11706374, 'Siti Badriah', 'P', 'Cia 2', 'OTKP X-2'),
(11706375, 'Siti Fadila Afrilia', 'P', 'Taj 2', 'TKJ X-2'),
(11706376, 'Siti Fahrika Az-Zahra Sutisna', 'P', 'Suk 1', 'TBG X-1'),
(11706377, 'Siti Fatimah Sakinah', 'P', 'Cia 3', 'BDP X-2'),
(11706378, 'Siti Ismarani', 'P', 'Cic 5', 'OTKP X-1'),
(11706379, 'Siti Khodijah', 'P', 'Suk 1', 'OTKP X-1'),
(11706380, 'Siti Komalasari', 'P', 'Taj 5', 'TBG X-1'),
(11706381, 'Siti Maharani Jaliyanti', 'P', 'Cis 2', 'TBG X-1'),
(11706382, 'Siti Maria Ulfa', 'P', 'Cia 1', 'TKJ X-3'),
(11706383, 'Siti Marlina', 'P', 'Cib 2', 'HTL X-1'),
(11706384, 'Siti Nur Nia Sari', 'P', 'Cis 3', 'TKJ X-2'),
(11706385, 'Siti Nuraisya Safitri', 'P', 'Cib 1', 'TBG X-1'),
(11706386, 'Siti Nurhafada Aniadi', 'P', 'Taj 2', 'BDP X-2'),
(11706387, 'Siti Nurmalinda Ulyanto', 'P', 'Cib 3', 'TKJ X-1'),
(11706388, 'Siti Nurmilah Latuapo', 'P', 'Cib 3', 'RPL X-4'),
(11706389, 'Siti Nurul Khofifah', 'P', 'Cia 5', 'RPL X-1'),
(11706390, 'Siti Paradilah', 'P', 'Cib 2', 'TBG X-1'),
(11706391, 'Siti Rahayu', 'P', 'Cia 2', 'BDP X-2'),
(11706392, 'Siti Syavadhila', 'P', 'Taj 5', 'OTKP X-1'),
(11706393, 'Siti Tanisya Nurul Hidayah', 'P', 'Taj 1', 'OTKP X-1'),
(11706394, 'Siti Yunita Awaliah', 'P', 'Cia 1', 'TBG X-1'),
(11706395, 'Siti Zahra Khairunnisa', 'P', 'Cib 3', 'OTKP X-2'),
(11706396, 'Siti Zahra Nuryani', 'P', 'Cia 3', 'MMD X-2'),
(11706397, 'Solihat Khairun Nisa', 'P', 'Suk 2', 'OTKP X-1'),
(11706398, 'Sri Wulandari', 'P', 'Taj 2', 'RPL X-1'),
(11706399, 'Stefani', 'P', 'Wik 3', 'BDP X-1'),
(11706400, 'Stefanny Greacia', 'P', 'Taj 5', 'HTL X-1'),
(11706401, 'Sultan Yusuf Albari', 'L', 'Taj 1', 'OTKP X-1'),
(11706402, 'Suryo Selamet Kamal Kalamillah', 'L', 'Wik 2', 'RPL X-1'),
(11706403, 'Syahdan Alfikri', 'L', 'Taj 3', 'MMD X-2'),
(11706404, 'Syahrul Efendi', 'L', 'Cic 2', 'TKJ X-1'),
(11706405, 'Syahrul Rahman Apendi', 'L', 'Cic 5', 'TKJ X-2'),
(11706406, 'Syaini Syahriah', 'P', 'Cia 1', 'MMD X-1'),
(11706407, 'Syarif Muhammad Abdillah', 'L', 'Cib 2', 'TKJ X-1'),
(11706408, 'Syifa Apriyani', 'P', 'Cia 1', 'TKJ X-2'),
(11706409, 'Tabah Hikmawan Yusron', 'L', 'Cis 2', 'RPL X-1'),
(11706410, 'Tantri Nurwijaya', 'P', 'Taj 2', 'TBG X-1'),
(11706411, 'Tasya Shafira Wilman', 'P', 'Taj 1', 'HTL X-1'),
(11706412, 'Taufik Hidayat', 'L', 'Cis 1', 'TKJ X-2'),
(11706413, 'Tiara Fajardini', 'P', 'Taj 2', 'RPL X-4'),
(11706414, 'Tina Agustina', 'P', 'Cic 7', 'BDP X-2'),
(11706415, 'Tita Marliani Nurhilali', 'P', 'Cis 1', 'OTKP X-1'),
(11706416, 'Tito Triarso', 'L', 'Taj 1', 'TBG X-1'),
(11706417, 'Tiwi Lusiawati', 'P', 'Taj 4', 'BDP X-2'),
(11706418, 'Topani Christiadi', 'L', 'Cic 2', 'TKJ X-2'),
(11706419, 'Tri Anhari Noer Faqih', 'L', 'Taj 3', 'TKJ X-2'),
(11706420, 'Tri Ayu Siti Nurbiah', 'P', 'Taj 5', 'MMD X-1'),
(11706421, 'Tri Harbiyanto', 'L', 'Cis 2', 'TKJ X-1'),
(11706422, 'Trie Meitha Choerunnisa', 'P', 'Suk 2', 'MMD X-1'),
(11706423, 'Triyani Sukmaningsih', 'P', 'Cis 1', 'MMD X-2'),
(11706424, 'Tubagus Radhiyya Ramandhika', 'L', 'Suk 2', 'RPL X-3'),
(11706425, 'Virda Regina', 'P', 'Suk 1', 'HTL X-1'),
(11706426, 'Vito Altamirano', 'L', 'Cia 1', 'BDP X-2'),
(11706427, 'Wahyu Awaludin', 'L', 'Cia 4', 'BDP X-2'),
(11706428, 'Wanaputri Dwi Adinda', 'P', 'Suk 2', 'TKJ X-3'),
(11706429, 'Wanda Agistira Putri', 'P', 'Cia 5', 'OTKP X-1'),
(11706430, 'Warda Puteri Sari', 'P', 'Taj 3', 'OTKP X-1'),
(11706431, 'Widya Nur Ananda', 'P', 'Taj 4', 'OTKP X-1'),
(11706432, 'Wina Dwiyanti', 'P', 'Cib 1', 'OTKP X-2'),
(11706433, 'Winardianto', 'L', 'Taj 5', 'TKJ X-4'),
(11706434, 'Windi Nurcaya Utami', 'P', 'Cic 5', 'OTKP X-1'),
(11706435, 'Wirda Surpiani', 'P', 'Taj 5', 'TBG X-1'),
(11706436, 'Wiwit Nurhawa', 'P', 'Taj 3', 'TKJ X-1'),
(11706437, 'Yoga Ariefatullah Abimanyu', 'L', 'Wik 1', 'RPL X-4'),
(11706438, 'Yudis Threeyantoro', 'L', 'Cic 2', 'MMD X-2'),
(11706439, 'Yulia Handayani', 'P', 'Cia 3', 'MMD X-1'),
(11706440, 'Yulia Rahman', 'P', 'Cis 2', 'OTKP X-1'),
(11706441, 'Yuliana Restu', 'P', 'Wik 4', 'OTKP X-2'),
(11706442, 'Yulistina Nurul Azizah', 'P', 'Cic 3', 'BDP X-1'),
(11706443, 'Yuni Wijaya', 'P', 'Cis 5', 'BDP X-1'),
(11706444, 'Yuniar Ledyanti', 'P', 'Taj 1', 'TKJ X-1'),
(11706445, 'Yunisa Yasmin', 'P', 'Cis 1', 'BDP X-2'),
(11706446, 'Yunni Agustin', 'P', 'Taj 5', 'BDP X-1'),
(11706447, 'Yurika Hanifah Putri Andi', 'P', 'Taj 4', 'RPL X-1'),
(11706448, 'Yusuf Wandana', 'L', 'Cic 4', 'RPL X-3'),
(11706449, 'Zafira Yasmin Ghiffari', 'P', 'Wik 1', 'BDP X-1'),
(11706450, 'Zahra Zakiyya', 'P', 'Suk 2', 'TKJ X-2'),
(11706451, 'Zaki Aljabbar', 'L', 'Suk 2', 'TKJ X-2'),
(11706452, 'Zara Sheilomitha Ainnaya', 'P', 'Suk 2', 'TBG X-1'),
(11706453, 'Zayyan Bagas Fibriyan', 'L', 'Taj 2', 'TKJ X-1'),
(11706454, 'Zidan Abdul Jabbar', 'L', 'Cis 5', 'TKJ X-1'),
(11706455, 'Rangga Adrian', 'L', 'Wik 4', 'TKJ X-1'),
(11706456, 'Malisa Diniyah', 'P', 'Cis 2', 'RPL X-1'),
(11706457, 'Muhammad Farchany Yusup', 'L', 'Taj 4', 'TBG X-1');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` varchar(10) NOT NULL,
  `nis` int(11) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `date` date DEFAULT NULL,
  `date_return` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `nis`, `user_id`, `date`, `date_return`) VALUES
('TR001', 11605716, 'U001', '2018-05-25', '2018-05-17'),
('TR002', 11605716, 'U001', '2018-05-25', '2018-05-25'),
('TR003', 11605735, 'U001', '2018-06-06', '2018-06-16'),
('TR004', 11605716, 'U004', '2018-07-02', '2018-07-13');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_return`
--

CREATE TABLE `transaction_return` (
  `id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `transaction_id` varchar(10) NOT NULL,
  `item_id` varchar(10) NOT NULL,
  `quantity` varchar(10) NOT NULL,
  `date` date DEFAULT NULL,
  `day_late` varchar(45) DEFAULT NULL,
  `note` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction_return`
--

INSERT INTO `transaction_return` (`id`, `user_id`, `transaction_id`, `item_id`, `quantity`, `date`, `day_late`, `note`) VALUES
('RE001', 'U001', 'TR001', 'I002', '1', '2018-05-25', '8', 'Dikembalikan oleh U001'),
('RE002', 'U001', 'TR002', 'I001', '1', '2018-05-25', '0', 'Dikembalikan oleh U001'),
('RE003', 'U001', 'TR002', 'I002', '1', '2018-05-25', '0', 'Dikembalikan oleh U001'),
('RE004', 'U001', 'TR003', 'I001', '1', '2018-07-02', '16', 'Dikembalikan oleh U001');

--
-- Triggers `transaction_return`
--
DELIMITER $$
CREATE TRIGGER `batal_kembali` AFTER DELETE ON `transaction_return` FOR EACH ROW BEGIN
UPDATE item
SET quantity = quantity - OLD.quantity
WHERE
id = OLD.item_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `kembali` AFTER INSERT ON `transaction_return` FOR EACH ROW BEGIN
UPDATE item
SET quantity = quantity + NEW.quantity
WHERE
id = NEW.item_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` varchar(10) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `nohp` varchar(15) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `level` enum('Admin S','Admin B','Master') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `nohp`, `username`, `password`, `level`) VALUES
('U001', 'NOVICA ARDINA', '08772553317', 'Admins', 'Admins', 'Admin S'),
('U002', 'NOVICAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaa', '0875126352671', 'Adminb', 'Adminb', 'Admin B'),
('U003', 'NOVICA ARDINA', '081263721', 'Mastere', 'Master', 'Master'),
('U004', 'pica', '234234', 'pica', 'pica', 'Admin B');

-- --------------------------------------------------------

--
-- Structure for view `lpengembalian`
--
DROP TABLE IF EXISTS `lpengembalian`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lpengembalian`  AS  select `transaction_return`.`id` AS `id`,`transaction_return`.`transaction_id` AS `transaction_id`,`transaction`.`nis` AS `nis`,`siswa`.`nama` AS `nama`,`item`.`name` AS `name`,`transaction_return`.`quantity` AS `quantity`,`transaction`.`date_return` AS `date_return`,`transaction_return`.`day_late` AS `day_late`,`transaction_return`.`note` AS `note` from (((`transaction_return` join `transaction` on((`transaction_return`.`transaction_id` = `transaction`.`id`))) join `siswa` on((`transaction`.`nis` = `siswa`.`nis`))) join `item` on((`transaction_return`.`item_id` = `item`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `peminjaman`
--
DROP TABLE IF EXISTS `peminjaman`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `peminjaman`  AS  select `detail`.`id` AS `id`,`detail`.`transaction_id` AS `transaction_id`,`transaction`.`nis` AS `nis`,`siswa`.`nama` AS `nama`,`detail`.`item_id` AS `item_id`,`item`.`name` AS `name`,`detail`.`quantity` AS `quantity`,`transaction`.`date` AS `date`,`detail`.`note` AS `note` from (((`detail` join `transaction` on((`detail`.`transaction_id` = `transaction`.`id`))) join `siswa` on((`transaction`.`nis` = `siswa`.`nis`))) join `item` on((`detail`.`item_id` = `item`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `pengembalian2`
--
DROP TABLE IF EXISTS `pengembalian2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pengembalian2`  AS  select `detail`.`id` AS `id`,`detail`.`transaction_id` AS `transaction_id`,`transaction`.`nis` AS `nis`,`siswa`.`nama` AS `nama`,`detail`.`item_id` AS `item_id`,`item`.`name` AS `name`,`detail`.`quantity` AS `quantity`,`detail`.`note` AS `note` from (((`detail` join `transaction` on((`detail`.`transaction_id` = `transaction`.`id`))) join `siswa` on((`transaction`.`nis` = `siswa`.`nis`))) join `item` on((`detail`.`item_id` = `item`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `pengembalianpertr`
--
DROP TABLE IF EXISTS `pengembalianpertr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pengembalianpertr`  AS  select `transaction`.`id` AS `id`,`transaction`.`nis` AS `nis`,`siswa`.`nama` AS `nama`,`transaction`.`date` AS `date`,`transaction`.`date_return` AS `date_return`,`detail`.`note` AS `note` from ((`transaction` join `siswa` on((`transaction`.`nis` = `siswa`.`nis`))) join `detail` on((`transaction`.`id` = `detail`.`transaction_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`nis`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_return`
--
ALTER TABLE `transaction_return`
  ADD KEY `fk_transaction_return_transaction1_idx` (`transaction_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaction_return`
--
ALTER TABLE `transaction_return`
  ADD CONSTRAINT `fk_transaction_return_transaction1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
