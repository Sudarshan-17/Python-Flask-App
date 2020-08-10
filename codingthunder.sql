-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 10, 2020 at 12:55 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `s_no` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`s_no`, `name`, `email`, `phone`, `msg`, `date`) VALUES
(1, 'firtst', 'sud@gmail.com', '123456789', 'dfadvcv', '2020-08-08 14:45:46'),
(2, 'Sudarshan Gosavi', 'sudarshangosavi17@gmail.com', '8793213034', 'dqwdas', '2020-08-08 17:16:08'),
(3, 'sneha gosavi', 'sneha.gosavi00@gmail.com', '8793213034', 'hello', '2020-08-08 17:18:51'),
(5, 'sneha gosavi', 'sudarshangosavi17@gmail.com', '8793213034', 'Hi, i am Destroyer', '2020-08-08 18:13:55'),
(6, 'sneha gosavi', 'sudarshangosavi17@gmail.com', '8793213034', 'hi', '2020-08-08 18:16:46');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `s_no` int(50) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`s_no`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(3, 'Variables', 'Template variables are defined by the context dictionary passed to the template.', 'thirdpost', 'You can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.', 'about-bg.jpg', '2020-08-09 14:56:48'),
(4, 'Tests', 'Beside filters, there are also so-called “tests” available. ', 'fourthpost', 'Beside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.\r\n\r\nTests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:\r\n\r\n{% if loop.index is divisibleby 3 %}\r\n{% if loop.index is divisibleby(3) %}\r\nThe List of Builtin Tests below describes all the builtin tests.', '', '2020-08-09 14:56:48'),
(5, 'Whitespace Control', 'In the default configuration:', 'fifthpost', 'In the default configuration:\r\n\r\na single trailing newline is stripped if present\r\n\r\nother whitespace (spaces, tabs, newlines etc.) is returned unchanged\r\n\r\nIf an application configures Jinja to trim_blocks, the first newline after a template tag is removed automatically (like in PHP). The lstrip_blocks option can also be set to strip tabs and spaces from the beginning of a line to the start of a block. (Nothing will be stripped if there are other characters before the start of the block.)\r\n\r\nWith both trim_blocks and lstrip_blocks enabled, you can put block tags on their own lines, and the entire block line will be removed when rendered, preserving the whitespace of the contents. For example, without the trim_blocks and lstrip_blocks options, this template:', '', '2020-08-09 14:58:56'),
(6, 'Template Inheritance', 'Base Template', 'sixthpost', 'This template, which we’ll call base.html, defines a simple HTML skeleton document that you might use for a simple two-column page. It’s the job of “child” templates to fill the empty blocks with content:\r\n\r\n<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n    {% block head %}\r\n    <link rel=\"stylesheet\" href=\"style.css\" />\r\n    <title>{% block title %}{% endblock %} - My Webpage</title>\r\n    {% endblock %}\r\n</head>\r\n<body>\r\n    <div id=\"content\">{% block content %}{% endblock %}</div>\r\n    <div id=\"footer\">\r\n        {% block footer %}\r\n        &copy; Copyright 2008 by <a href=\"http://domain.invalid/\">you</a>.\r\n        {% endblock %}\r\n    </div>\r\n</body>\r\n</html>', 'about-bg.jpg', '2020-08-09 14:58:56'),
(7, 'Sudarshan Gosavi', 'PUBG', 'new-post', 'dscsdcs', 'cdscscd.png', '2020-08-09 18:58:39'),
(8, 'Destroyer', 'PUBG', 'new-post', 'jhgf', 'jhkl.png', '2020-08-09 19:06:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`s_no`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`s_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `s_no` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `s_no` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
