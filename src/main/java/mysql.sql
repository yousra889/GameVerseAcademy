-- ============================================================
--  GameVerse Academy — SQL Complet Final
--  Base de données : gameverseacademy
--  Moteur : MariaDB (XAMPP)
-- ============================================================

-- ------------------------------------------------------------
-- 0. Créer et sélectionner la base
-- ------------------------------------------------------------
DROP DATABASE IF EXISTS gameverseacademy;
CREATE DATABASE gameverseacademy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gameverseacademy;

-- ============================================================
-- 1. TABLE : users
-- ============================================================
CREATE TABLE users (
    id         INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login      VARCHAR(60)  NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    email      VARCHAR(120) DEFAULT NULL,
    role       ENUM('admin','user') NOT NULL DEFAULT 'user',
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 2. TABLE : mods  (avec toutes les colonnes utilisées dans le code)
-- ============================================================
CREATE TABLE mods (
    id           INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(150) NOT NULL,
    category     ENUM('Graphique','Gameplay','Map','Script') DEFAULT NULL,
    author       VARCHAR(100) DEFAULT NULL,
    description  TEXT         DEFAULT NULL,
    downloads    INT          NOT NULL DEFAULT 0,
    user_id      INT          DEFAULT NULL,
    developer    VARCHAR(100) DEFAULT NULL,
    publisher    VARCHAR(100) DEFAULT NULL,
    platform     VARCHAR(100) DEFAULT NULL,
    release_date VARCHAR(50)  DEFAULT NULL,
    metacritic   INT          DEFAULT 0,
    created_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_mods_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 3. TABLE : reviews
-- ============================================================
CREATE TABLE reviews (
    id         INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    mod_id     INT  NOT NULL,
    user_id    INT  NOT NULL,
    rating     INT  NOT NULL,
    comment    TEXT DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_mod  FOREIGN KEY (mod_id)  REFERENCES mods(id)  ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 4. INDEX
-- ============================================================
CREATE INDEX idx_mods_category  ON mods (category);
CREATE INDEX idx_mods_author    ON mods (author);
CREATE INDEX idx_mods_downloads ON mods (downloads DESC);
CREATE INDEX idx_reviews_mod    ON reviews (mod_id);
CREATE INDEX idx_reviews_user   ON reviews (user_id);

-- ============================================================
-- 5. DONNÉES : users
-- ============================================================
INSERT INTO users (login, password, email, role) VALUES
('admin',     'admin123', 'admin@gameverseacademy.ma',    'admin'),
('yousra889', 'pass123',  'yousra@esi.ac.ma',             'user'),
('player01',  'pass123',  'player01@gameverseacademy.ma', 'user'),
('modder99',  'pass123',  'modder99@gameverseacademy.ma', 'user');

-- ============================================================
-- 6. DONNÉES : mods
-- ============================================================
INSERT INTO mods (title, category, author, description, downloads, user_id, developer, publisher, platform, release_date, metacritic) VALUES

-- Graphique
('Skyrim Ultra HD Textures 4K',
 'Graphique', 'modder99', 'Complete texture overhaul for Skyrim — 4K resolution on all surfaces.',
 1240, 4, 'Bethesda', 'Bethesda', 'PC', '2011-11-11', 94),

('GTA V Realistic Lighting Overhaul',
 'Graphique', 'player01', 'Replaces all ambient and dynamic lights with a cinematic preset.',
 870, 3, 'Rockstar', 'Rockstar', 'PC', '2013-09-17', 97),

('Witcher 3 — Natural Colors Redux',
 'Graphique', 'yousra889', 'Desaturated, film-grain aesthetic closer to the original CGI trailers.',
 430, 2, 'CD Projekt', 'CD Projekt', 'PC', '2015-05-19', 92),

-- Gameplay
('Skyrim — Survival Mode Enhanced',
 'Gameplay', 'yousra889', 'Adds hunger, thirst, temperature and fatigue mechanics.',
 620, 2, 'Bethesda', 'Bethesda', 'PC', '2011-11-11', 94),

('GTA V — Realism Beyond',
 'Gameplay', 'modder99', 'Realistic driving physics, injury system and wanted level overhaul.',
 980, 4, 'Rockstar', 'Rockstar', 'PC', '2013-09-17', 97),

('Witcher 3 — Combat Overhaul v2',
 'Gameplay', 'player01', 'Reworked parry/dodge timings and enemy AI for a harder experience.',
 545, 3, 'CD Projekt', 'CD Projekt', 'PC', '2015-05-19', 92),

-- Map
('Skyrim — Forgotten Vale Extended',
 'Map', 'player01', 'Expands the Forgotten Vale with 3 new dungeons and a boss arena.',
 312, 3, 'Bethesda', 'Bethesda', 'PC', '2011-11-11', 94),

('GTA V — Liberty City Map Add-on',
 'Map', 'admin', 'Ports the Liberty City map into GTA V with full traffic and pedestrians.',
 2100, 1, 'Rockstar', 'Rockstar', 'PC', '2013-09-17', 97),

-- Script
('Skyrim — Auto-Loot Script',
 'Script', 'yousra889', 'Automatically loots nearby containers based on configurable filters.',
 760, 2, 'Bethesda', 'Bethesda', 'PC', '2011-11-11', 94),

('GTA V — Heist Manager Script',
 'Script', 'modder99', 'Custom script that lets players design and replay heist missions.',
 530, 4, 'Rockstar', 'Rockstar', 'PC', '2013-09-17', 97);

-- ============================================================
-- 7. DONNÉES : reviews
-- ============================================================
INSERT INTO reviews (mod_id, user_id, rating, comment) VALUES
(1, 2, 5, 'Incroyable texture pack, le jeu est méconnaissable !'),
(1, 3, 4, 'Très beau mais demande un PC puissant.'),
(2, 2, 5, 'Lighting parfait, ambiance de film !'),
(3, 4, 3, 'Bien mais pas révolutionnaire.'),
(4, 3, 5, 'Le meilleur mod survival que j ai testé !'),
(5, 2, 4, 'Combat beaucoup plus challengeant, j adore.'),
(6, 4, 4, 'Très bon mod de combat, recommandé !'),
(7, 2, 3, 'Bien fait mais un peu court.'),
(8, 3, 5, 'Liberty City dans GTA V, du pur génie !'),
(9, 4, 4, 'Super pratique, gain de temps énorme.');

-- ============================================================
-- 8. VÉRIFICATION
-- ============================================================
SELECT 'users'   AS table_name, COUNT(*) AS total FROM users
UNION ALL
SELECT 'mods',   COUNT(*) FROM mods
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;