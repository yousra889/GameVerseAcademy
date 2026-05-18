-- ============================================================
--  GameVerse Academy — MySQL Schema + Sample Data
--  Database : gameverseacademy
--  Generated from project analysis (GameVerseAcademy.zip)
-- ============================================================

-- ------------------------------------------------------------
-- 0. Create & select database
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS gameverseacademy
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE gameverseacademy;

-- ============================================================
-- 1. TABLE : users
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id          INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login       VARCHAR(60)   NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,
    email       VARCHAR(120)  DEFAULT NULL,
    role        ENUM('admin','user') NOT NULL DEFAULT 'user',
    created_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 2. TABLE : mods
-- ============================================================
CREATE TABLE IF NOT EXISTS mods (
    id          INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(150)  NOT NULL,
    category    ENUM('Graphique','Gameplay','Map','Script') DEFAULT NULL,
    author      VARCHAR(100)  DEFAULT NULL,
    description TEXT          DEFAULT NULL,
    downloads   INT           NOT NULL DEFAULT 0,
    user_id     INT           DEFAULT NULL,
    created_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_mods_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 3. INDEXES
-- ============================================================
CREATE INDEX idx_mods_category  ON mods (category);
CREATE INDEX idx_mods_author    ON mods (author);
CREATE INDEX idx_mods_downloads ON mods (downloads DESC);

-- ============================================================
-- 4. SAMPLE DATA — users
-- ============================================================
INSERT INTO users (login, password, email, role) VALUES
    ('admin',     'admin123',  'admin@gameverseacademy.ma',    'admin'),
    ('yousra889', 'pass123',   'yousra@esi.ac.ma',             'user'),
    ('player01',  'pass123',   'player01@gameverseacademy.ma', 'user'),
    ('modder99',  'pass123',   'modder99@gameverseacademy.ma', 'user');

-- ============================================================
-- 5. SAMPLE DATA — mods
-- ============================================================
INSERT INTO mods (title, category, author, description, downloads, user_id) VALUES
    -- Graphique
    ('Skyrim Ultra HD Textures 4K',
     'Graphique', 'modder99',
     'Complete texture overhaul for Skyrim — 4K resolution on all surfaces.',
     1240, 4),

    ('GTA V Realistic Lighting Overhaul',
     'Graphique', 'player01',
     'Replaces all ambient and dynamic lights with a cinematic preset.',
     870, 3),

    ('Witcher 3 — Natural Colors Redux',
     'Graphique', 'yousra889',
     'Desaturated, film-grain aesthetic closer to the original CGI trailers.',
     430, 2),

    -- Gameplay
    ('Skyrim — Survival Mode Enhanced',
     'Gameplay', 'yousra889',
     'Adds hunger, thirst, temperature and fatigue mechanics.',
     620, 2),

    ('GTA V — Realism Beyond',
     'Gameplay', 'modder99',
     'Realistic driving physics, injury system and wanted level overhaul.',
     980, 4),

    ('Witcher 3 — Combat Overhaul v2',
     'Gameplay', 'player01',
     'Reworked parry / dodge timings and enemy AI for a harder experience.',
     545, 3),

    -- Map
    ('Skyrim — Forgotten Vale Extended',
     'Map', 'player01',
     'Expands the Forgotten Vale with 3 new dungeons and a boss arena.',
     312, 3),

    ('GTA V — Liberty City Map Add-on',
     'Map', 'admin',
     'Ports the Liberty City map into GTA V with full traffic and pedestrians.',
     2100, 1),

    -- Script
    ('Skyrim — Auto-Loot Script',
     'Script', 'yousra889',
     'Automatically loots nearby containers based on configurable filters.',
     760, 2),

    ('GTA V — Heist Manager Script',
     'Script', 'modder99',
     'Custom script that lets players design and replay heist missions.',
     530, 4);

-- ============================================================
-- 6. VERIFICATION QUERIES  (run manually to check)
-- ============================================================
-- SELECT * FROM users;
-- SELECT * FROM mods ORDER BY downloads DESC;
-- SELECT category, COUNT(*) AS total FROM mods GROUP BY category;