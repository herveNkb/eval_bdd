-- Création de la BDD avec le jeu de caractères utf8mb4
CREATE DATABASE IF NOT EXISTS cinema_totoro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Création des utilisateurs pour la BDD
CREATE USER 'admin_cinema'@'localhost' IDENTIFIED BY 'adfLK125FsfecgDSKA5mwoDS6H';
CREATE USER 'user_cinema'@'localhost' IDENTIFIED BY 'fgM5SMhjo5963FbdCD9DwpmkBA';

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
CREATE TABLE IF NOT EXISTS user
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    role ENUM ('ROLE_USER', 'ROLE_ADMIN') NOT NULL DEFAULT 'ROLE_USER',
    first_name VARCHAR(100) NOT NULL,
    last_name  VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table cinema_complex
CREATE TABLE IF NOT EXISTS cinema_complex
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    zip_code INT NOT NULL,
    city VARCHAR(255) NOT NULL,
    phone_number INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table cinema_rooms
CREATE TABLE IF NOT EXISTS cinema_rooms
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    hall_number INT NOT NULL,
    number_of_places INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table film_show
CREATE TABLE IF NOT EXISTS film_show
(
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATETIME     NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table movie
CREATE TABLE IF NOT EXISTS movie
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    synopsis LONGTEXT NOT NULL,
    movie_type VARCHAR(100) NOT NULL,
    duration   VARCHAR(25)  NOT NULL,
    director   VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table booking
CREATE TABLE IF NOT EXISTS booking
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    booking_date DATETIME NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table customer
CREATE TABLE IF NOT EXISTS customer
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name_customer VARCHAR(255) NOT NULL,
    last_name_customer  VARCHAR(255) NOT NULL,
    date_of_birth       DATE         NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table price_list
CREATE TABLE IF NOT EXISTS price_list
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    price FLOAT  NOT NULL,
    price_type VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Table payment
CREATE TABLE IF NOT EXISTS payment
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    payment_type   VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Création des clés étrangères (relation)
-- Table cinema_complex vers la table user (one to many)
ALTER TABLE cinema_complex
    ADD CONSTRAINT FK_cinema_complex_user_id FOREIGN KEY (id) REFERENCES user (id);
-- création d'une table associative reliant la table cinema_complex et la table booking (many to many)
CREATE TABLE IF NOT EXISTS cinema_complex_booking
(
    cinema_complex_id INT UNSIGNED NOT NULL,
    booking_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (cinema_complex_id, booking_id),
    CONSTRAINT FK_cinema_complex_booking_cinema_complex_id FOREIGN KEY (cinema_complex_id) REFERENCES cinema_complex (id),
    CONSTRAINT FK_cinema_complex_booking_booking_id FOREIGN KEY (booking_id) REFERENCES booking (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- Table cinema_rooms vers la table cinema_complex (many to one)
ALTER TABLE cinema_rooms
    ADD CONSTRAINT FK_cinema_rooms_cinema_complex_id FOREIGN KEY (id) REFERENCES cinema_complex (id);
-- Table cinema_rooms vers la table film_show (one to many)
ALTER TABLE cinema_rooms
    ADD CONSTRAINT FK_cinema_rooms_film_show_id FOREIGN KEY (id) REFERENCES film_show (id);
-- Table movie vers la table film_show (one to many)
ALTER TABLE movie
    ADD CONSTRAINT FK_movie_film_show_id FOREIGN KEY (id) REFERENCES film_show (id);
-- Table booking vers la table film_show (many to one)
ALTER TABLE booking
    ADD CONSTRAINT FK_booking_film_show_id FOREIGN KEY (id) REFERENCES film_show (id);
-- création d'une table associative reliant la table booking et la table customer (many to many)
CREATE TABLE IF NOT EXISTS booking_customer
(
    booking_id INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (booking_id, customer_id),
    CONSTRAINT FK_booking_customer_booking_id FOREIGN KEY (booking_id) REFERENCES booking (id),
    CONSTRAINT FK_booking_customer_customer_id FOREIGN KEY (customer_id) REFERENCES customer (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- création d'une table associative reliant la table customer et la table price_list (many to many)
CREATE TABLE IF NOT EXISTS customer_price_list
(
    customer_id INT UNSIGNED NOT NULL,
    price_list_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (customer_id, price_list_id),
    CONSTRAINT FK_customer_price_list_customer_id FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT FK_customer_price_list_price_list_id FOREIGN KEY (price_list_id) REFERENCES price_list (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
-- création d'une table associative reliant la table price_list et la table payment (many to many)
CREATE TABLE IF NOT EXISTS price_list_payment
(
    price_list_id INT UNSIGNED NOT NULL,
    payment_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (price_list_id, payment_id),
    CONSTRAINT FK_price_list_payment_price_list_id FOREIGN KEY (price_list_id) REFERENCES price_list (id),
    CONSTRAINT FK_price_list_payment_payment_id FOREIGN KEY (payment_id) REFERENCES payment (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

-- Insertion des données fictives dans les tables
-- Table user
INSERT INTO user (id, email, password, role, first_name, last_name) VALUES
       (1, 'gbraganza0@freewebs.com', '$2y$10$ZzPYmLAS/.pbjx7kidD25OEIkCmB62rVdRvD4vAV7oL.IHv4L.eeC', 'ROLE_ADMIN', 'Sélène','Braganza'),
       (2, 'lmoir1@reddit.com', '$2y$10$rOPltkBiTNgqtsKNP9aFFOX1t4avYF.UYwTofzV7zKSHSer/wlWAy', 'ROLE_USER', 'Maëlle', 'Moir'),
       (3, 'nparrin2@irs.gov', '$2y$10$JtH/4.TN89mOzES.Sp42i.WUGx3PVOf4f63iXOF1Rj/e5ObHcemUq', 'ROLE_USER', 'Andréanne','Parrin'),
       (4, 'dcone3@arstechnica.com', '$2y$10$YVUV468TwpAdZ9HHKdBLpOzaGdVQCYqiALVedn5xsTtdh3s7fhQOy', 'ROLE_USER', 'Garçon','Cone'),
       (5, 'arosone4@printfriendly.com', '$2y$10$6R8wIFCg7pYy.fZzYExFqeqXTUlgqu.7zLOXdRWCPOwFTl02x7lSa', 'ROLE_USER', 'Athéna','Rosone');
-- Table cinema_complex
INSERT INTO cinema_complex (id, name, address, zip_code, city, phone_number) VALUES
        (1, 'Totoro cinema', '30 rue du trou noir', '70313', 'Ainvelle', '0485326908'),
        (2, 'Totoro complex', '69 ave Jean Jaures', '67002', 'Barr', '05376490'),
        (3, 'Totoro écran blanc', '20 Village Green Place', '25236', 'Anteuil', '0390768225'),
        (4, 'Totoro 7eme art', '247 rue du ciel', '30758', 'Alès', '0412549635');
-- Table cinema_rooms
INSERT INTO cinema_rooms (id, hall_number, number_of_places) VALUES
        (1, 1, 50),
        (2, 2, 70),
        (3, 3, 80),
        (4, 1, 110);
-- Table film_show
INSERT INTO film_show (id, date) VALUES
        (1, '2023-02-02 06:23:20'),
        (2, '2022-12-15 23:41:47'),
        (3, '2023-01-06 13:12:00'),
        (4, '2023-02-04 01:22:16'),
        (5, '2022-08-30 22:26:38'),
        (6, '2022-06-26 07:20:27'),
        (7, '2022-08-05 03:12:35'),
        (8, '2022-07-10 15:08:55'),
        (9, '2023-01-24 17:10:21'),
        (10, '2022-12-16 11:36:59'),
        (11, '2022-11-06 08:24:49'),
        (12, '2022-10-18 05:24:22'),
        (13, '2022-11-25 02:34:13'),
        (14, '2022-05-17 11:32:15'),
        (15, '2022-07-02 12:41:46'),
        (16, '2022-05-07 03:15:46'),
        (17, '2022-10-09 10:54:07'),
        (18, '2022-06-15 17:58:38'),
        (19, '2022-07-17 07:34:53'),
        (20, '2022-12-24 00:49:23');

-- Table movie
INSERT INTO movie (id, title, synopsis, movie_type, duration, director) VALUES
        (1, 'Hounds, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Crime|Horror|Thriller',
         '1h30',
         'Franchioni'),
        (2, 'Bad Company',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Action|Crime|Drama',
         '2h45',
         'Blasi'),
        (3, 'Jesse Stone: Innocents Lost',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Crime|Drama',
         '2h47',
         'Creaser'),
        (4, 'Valachi Papers,The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Crime|Drama',
         '1h54',
         'Klamman'),
        (5, 'Fingers at the Window',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.U',
         'Drama|Film-Noir|Mystery',
         '2h33',
         'Dunlap'),
        (6, 'Lion King II: Simba''s Pride, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Adventure|Animation|Children|Musical|Romance',
         '1h48',
         'Give'),
        (7, 'Perfect Host, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Crime|Drama|Thriller',
         '1h36',
         'Kerwin'),
        (8, 'Paperboy, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Thriller',
         '2h54',
         'Blood'),
        (9, 'Aurora',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Romance|Sci-Fi',
         '2h44',
         'Giabucci'),
        (10, 'Flower Drum Song',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Comedy|Musical|Romance',
         '2h18',
         'Peever'),
        (11, 'Winning of Barbara Worth, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama|Romance|Western',
         '3h52',
         'Lenthall'),
        (12, 'Spring Subway',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama|Romance',
         '1h55',
         'Brower'),
        (13, 'They Came to Cordura',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Western',
         '1h56',
         'Riccetti'),
        (14, 'Misunderstood',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama',
         '2h34',
         'Dobie'),
        (15, 'Bekas',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama',
         '3h21',
         'Sleite'),
        (16, 'Architect, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama',
         '2h15',
         'Pampling'),
        (17, 'Shit Year',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama',
         '3h54',
         'Janowicz'),
        (18, 'Brasher Doubloon, The',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Crime|Drama|Film-Noir|Mystery',
         '2h23',
         'Najera'),
        (19, 'Failan',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Drama|Romance',
         '2h14',
         'Mills'),
        (20, 'Sentimental Swordsman, The (To ching chien ko wu ching chien)',
         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit duis tristique. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Nisi lacus sed viverra tellus in hac habitasse. Consequat interdum varius sit amet mattis vulputate enim nulla. Consectetur purus ut faucibus pulvinar.',
         'Action|Adventure',
         '2h41',
         'Humburton');
-- Table booking
INSERT INTO booking (id, booking_date) VALUES
        (1, '2023-02-02 06:23:20'),
        (2, '2022-12-15 23:41:47'),
        (3, '2023-01-06 13:12:00'),
        (4, '2023-02-04 01:22:16'),
        (5, '2022-08-30 22:26:38'),
        (6, '2022-06-26 07:20:27'),
        (7, '2022-08-05 03:12:35');
-- Table customer
INSERT INTO customer (id, first_name_customer, last_name_customer, date_of_birth) VALUES
       (1, 'Iznogoud', 'Dupont', '1986-03-22'),
       (2, 'Marie', 'Pizza', '1975-09-15'),
       (3, 'Pierre', 'Molle', '1938-10-21'),
       (4, 'Bernard', 'Minet', '1999-01-01'),
       (5, 'Titi', 'Le Piaf', '2000-07-02'),
       (6, 'Jeanne', 'Moldu', '2018-12-31'),
       (7, 'Jacques', 'La Moule', '2019-03-06');
-- Table price_list
INSERT INTO price_list (id, price, price_type) VALUES
        (1, 9.20, 'Plein tarif'),
        (2, 7.60, 'Étudiant'),
        (3, 5.90, 'Moins de 14 ans');
-- Table payment
INSERT INTO payment (id, payment_type) VALUES
        (1, 'CB'),
        (2, 'Espèces'),
        (3, 'Chèque');










