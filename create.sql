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

/*
 Se connecter à la BDD avec l'utilisateur admin_cinema
puis sélectionner la base de données avec la requête suivante :
 */
USE cinema_totoro;

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
-- Table cinema_complex
CREATE TABLE IF NOT EXISTS cinema_complex (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    zip_code INT NOT NULL,
    city VARCHAR(255) NOT NULL,
    phone_number INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table cinema_rooms
CREATE TABLE IF NOT EXISTS cinema_rooms (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hall_number INT NOT NULL,
    number_of_places INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table film_show
CREATE TABLE IF NOT EXISTS film_show (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATETIME NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table movie
CREATE TABLE IF NOT EXISTS movie (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    synopsis LONGTEXT NOT NULL,
    movie_type VARCHAR(100) NOT NULL,
    duration VARCHAR(25) NOT NULL,
    director VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table booking
CREATE TABLE IF NOT EXISTS booking (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    booking_date DATETIME NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table customer
CREATE TABLE IF NOT EXISTS customer (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name_customer VARCHAR(255) NOT NULL,
    last_name_customer VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table price_list
CREATE TABLE IF NOT EXISTS price_list (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    price INT NOT NULL,
    price_type VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Table payment
CREATE TABLE IF NOT EXISTS payment (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    payment_type VARCHAR(100) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Création des clés étrangères (relation)
-- Table cinema_complex vers la table user (one to many)
ALTER TABLE cinema_complex ADD CONSTRAINT FK_cinema_complex_user_id FOREIGN KEY (id) REFERENCES user(id);
-- création d'une table associative reliant la table cinema_complex et la table booking (many to many)
CREATE TABLE IF NOT EXISTS cinema_complex_booking (
    cinema_complex_id INT UNSIGNED NOT NULL,
    booking_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (cinema_complex_id, booking_id),
    CONSTRAINT FK_cinema_complex_booking_cinema_complex_id FOREIGN KEY (cinema_complex_id) REFERENCES cinema_complex(id),
    CONSTRAINT FK_cinema_complex_booking_booking_id FOREIGN KEY (booking_id) REFERENCES booking(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;







