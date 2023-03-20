-- Création de la BDD avec le jeu de caractères utf8mb4
CREATE DATABASE IF NOT EXISTS cinema_totoro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Création des utilisateurs pour la BDD
CREATE USER 'admin_cinema'@'localhost' IDENTIFIED BY 'adfLK125FsfecgDSKA5mwoDS6H';
CREATE USER 'user_cinema'@'localhost' IDENTIFIED BY 'fgM5SMhjo5963FbdCD9DwpmkBA';
/*
Requête pour visualiser les utilisateur créés :
SELECT user, host FROM mysql.user WHERE host='localhost'
   */

-- Droits sur la BDD
-- tous les droits sur la BDD pour l'utilisateur admin_cinema
GRANT ALL PRIVILEGES ON cinema_totoro.* TO 'admin_cinema'@'localhost';
-- juste le droit de lecture sur la BDD pour l'utilisateur user_cinema
GRANT SELECT ON cinema_totoro.* TO 'user_cinema'@'localhost';
-- Recharge MySQL pour prendre en compte les modifications
FLUSH PRIVILEGES;

-- Création des tables
-- Table user
CREATE TABLE IF NOT EXISTS user (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ROLE_USER', 'ROLE_ADMIN') NOT NULL DEFAULT 'ROLE_USER',
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;