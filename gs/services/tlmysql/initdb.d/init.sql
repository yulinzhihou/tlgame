
/* create databases*/
CREATE database web;
CREATE database tlbbdb;

/* create root user and grant rights */
CREATE USER 'root'@'localhost' IDENTIFIED BY 'local';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
