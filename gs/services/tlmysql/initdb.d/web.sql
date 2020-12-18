/*
Navicat MySQL Data Transfer

Source Server         : 88
Source Server Version : 50045
Source Host           : 192.168.1.3:3306
Source Database       : web

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2012-09-19 16:25:04
*/

SET FOREIGN_KEY_CHECKS=0;

CREATE database web;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `password` char(32) NOT NULL,
  `question` varchar(64) default NULL,
  `answer` varchar(64) default NULL,
  `email` varchar(64) default NULL,
  `qq` varchar(16) default NULL,
  `tel` varchar(16) default NULL,
  `id_type` enum('IdCard') default 'IdCard',
  `id_card` varchar(32) default NULL,
  `is_online` tinyint(1) NOT NULL DEFAULT 0,
  `point` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`,`name`),
  UNIQUE KEY `id` USING BTREE (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `pay`
-- ----------------------------
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay` (
  `trade_no` varchar(20) NOT NULL,
  `channel` varchar(10) default NULL,
  `server_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `fee` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `create_time` datetime NOT NULL,
  `pay_time` datetime default NULL,
  PRIMARY KEY  (`trade_no`),
  KEY `trade_no` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `server`
-- ----------------------------
DROP TABLE IF EXISTS `server`;
CREATE TABLE `server` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `host` char(60) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 