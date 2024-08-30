-- Disable commits and foreign key checks
SET
    FOREIGN_KEY_CHECKS = 0;

SET
    AUTOCOMMIT = 0;

-- SQL queries to create tables

-- Create Abilities table for recording unique dragon abilities.
-- Each ability is described by a name and proficiency level.
-- 'ability_proficiency' describes the mastery level of the ability.
CREATE
OR REPLACE TABLE Abilities (
    ability_id int NOT NULL AUTO_INCREMENT UNIQUE,
    ability_name varchar(255) NOT NULL UNIQUE,
    ability_proficiency varchar(255) NOT NULL,
    total_number_of_dragons int NOT NULL,
    PRIMARY KEY (ability_id)
);

-- Create Environments table for recording environments where dragons reside.
-- Each environment has a unique identifier and is described by a name, terrain, and climate.
CREATE
OR REPLACE TABLE Environments (
    environment_id int NOT NULL AUTO_INCREMENT UNIQUE,
    environment_name varchar(255) NOT NULL UNIQUE,
    environment_terrain varchar(255) NOT NULL,
    environment_climate varchar(255) NOT NULL,
    total_number_of_dragons int NOT NULL,
    PRIMARY KEY (environment_id)
);

-- Create Types table for recording various types of dragons
-- Each type has a unique identifier and characteristics such as average height, weight, and age.
CREATE
OR REPLACE TABLE Types (
    type_id int NOT NULL AUTO_INCREMENT UNIQUE,
    type_name varchar(255) NOT NULL UNIQUE,
    type_average_height decimal(19, 2),
    type_average_weight decimal(19, 2),
    type_average_age decimal(19, 2),
    total_number_of_people_killed int,
    total_number int NOT NULL,
    PRIMARY KEY (type_id)
);

-- Create Dragons table for recording details about individual dragons. 
-- Each dragon has a unique identifier and characteristics such as name, type, height, weight, age, personality, alignment, and lore.
-- Dragons have a defined relationship with types and environments.
CREATE
OR REPLACE TABLE Dragons (
    dragon_id int NOT NULL AUTO_INCREMENT UNIQUE,
    dragon_name varchar(255) NOT NULL UNIQUE,
    type_id int,
    dragon_height decimal(19, 2) NOT NULL,
    dragon_weight decimal(19, 2) NOT NULL,
    dragon_age int NOT NULL,
    dragon_personality varchar(255) NOT NULL,
    dragon_alignment varchar(255) NOT NULL,
    environment_id int,
    number_of_people_killed int NOT NULL,
    dragon_lore varchar(255) NOT NULL,
    PRIMARY KEY (dragon_id),
    FOREIGN KEY (type_id) references Types(type_id) ON DELETE SET NULL,
    FOREIGN KEY (environment_id) references Environments(environment_id) ON DELETE SET NULL
);

-- Create Dragons_Abilities table for recording relationship between Dragons and Abilities
-- Each record links a dragon to an ability, with foreign keys referencing the primary keys of the respective tables
CREATE
OR REPLACE TABLE Dragons_Abilities(
    dragon_id int NOT NULL,
    ability_id int NOT NULL,
    PRIMARY KEY (dragon_id, ability_id),
    FOREIGN KEY (dragon_id) references Dragons(dragon_id) ON DELETE CASCADE,
    FOREIGN KEY (ability_id) references Abilities(ability_id) ON DELETE CASCADE
);

-- Input Data into the Abilities, Environments, Types, and Dragons tables
INSERT INTO
    Abilities (ability_name, ability_proficiency, total_number_of_dragons)
VALUES
    ('Flight', 'Apprentice', 0),
    ('Blue Flame', 'Intermediate', 0),
    ('Ice Manipulation', 'Intermediate', 0),
    ('Invisibility', 'Master', 0),
    ('Teleportation', 'Master', 0);

INSERT INTO
    Environments (
        environment_name,
        environment_terrain,
        environment_climate,
        total_number_of_dragons
    )
VALUES
    ('Volcanic Caverns', 'Rocky', 'Hot', 0),
    ('Frozen Tundra', 'Snowy', 'Cold', 0),
    ('Mountain Range', 'Rocky', 'Variable', 0);

INSERT INTO
    Types (
        type_name,
        type_average_height,
        type_average_weight,
        type_average_age,
        total_number
    )
VALUES
    (
        'Fire Dragon',
        20,
        1100,
        200,
        0
    ),
    (
        'Ice Dragon',
        25,
        1200,
        250,
        0
    ),
    (
        'Earth Dragon',
        30,
        1500,
        300,
        0
    );

INSERT INTO
    Dragons (
        dragon_name,
        type_id,
        dragon_height,
        dragon_weight,
        dragon_age,
        dragon_personality,
        dragon_alignment,
        environment_id,
        number_of_people_killed,
        dragon_lore
    )
VALUES
    (
        'Blaze',
        1,
        22.5,
        1050,
        220,
        'Aggressive',
        'Chaotic Evil',
        1,
        100,
        'Cooks its prey to death'
    ),
    (
        'Frostbite',
        2,
        27.8,
        1250,
        240,
        'Calm',
        'True Neutral',
        2,
        50,
        'Freezes its prey to death'
    ),
    (
        'Tremor',
        3,
        32.1,
        1550,
        270,
        'Steady',
        'Lawful Good',
        3,
        75,
        'Creates earthquakes with each step'
    );

INSERT INTO
    Dragons_Abilities (dragon_id, ability_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 4),
    (2, 1),
    (2, 3),
    (2, 5),
    (3, 1),
    (3, 4),
    (3, 5);

-- Enable commits and foreign key checks
SET
    FOREIGN_KEY_CHECKS = 1;

COMMIT;