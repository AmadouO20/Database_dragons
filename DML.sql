-- Data Manipulation Queries
 
-- *** Abilities PAGE ***
-- Get an ability
SELECT
    *
FROM
    Abilities;

-- Insert a new ability
INSERT INTO
    Abilities (ability_name, ability_proficiency, total_number_of_dragons)
VALUES
    (:abilityNameInput, :abilityProficiencyInput, 0);

-- Update an adiblity
UPDATE
    Abilities a
SET
    ability_name = :abilityNameInput,
    ability_proficiency = :abilityProficiencyInput,
    total_number_of_dragons = (
        SELECT
            COUNT(*)
        FROM
            Dragons_Abilities da
        WHERE
            da.ability_id = a.ability_id
    )
WHERE
    ability_id = :ability_id;

-- Delete an ability
DELETE FROM
    Abilities
WHERE
    ability_id = :ability_id;

-- *** Dragons_Abilities ***
-- Get a Dragons_Ability
SELECT
    Abilities.ability_name
FROM
    Abilities
    INNER JOIN Dragons_Abilities ON Abilities.ability_id = Dragons_Abilities.ability_id
WHERE
    Dragons_Abilities.dragon_id = :dragon_id;

-- Insert new Dragons_Ability
INSERT INTO
    Dragons_Abilities (dragon_id, ability_id)
VALUES
    (:dragon_id, :ability_id);

-- Delete Dragons_Ability
DELETE FROM
    Dragons_Abilities
WHERE
    dragon_id = :dragon_id;

-- *** Environments PAGE ***
-- Get an environment
SELECT
    *
FROM
    Environments;

-- Insert a new environment
INSERT INTO
    Environments (
        environment_name,
        environment_terrain,
        environment_climate,
        total_number_of_dragons
    )
VALUES
    (
        :environmentNameInput,
        :environmentTerrainInput,
        :environmentClimateInput,
        0
    );

-- Update an environment
UPDATE
    Environments
SET
    environment_name = :environmentNameInput,
    environment_terrain = :environmentTerrainInput,
    environment_climate = :environmentClimateInput,
    total_number_of_dragons = (
        SELECT
            COUNT(*)
        FROM
            Dragons d
        WHERE
            d.environment_id = e.environment_id
     );
WHERE
    environment_id = :environment_id;

-- Delete an environment
DELETE FROM
    Environments
WHERE
    environment_id = :environment_id;

-- *** Types PAGE ***
-- Get a type
SELECT 
    t.type_id, 
    t.type_name, 
    AVG(d.dragon_height) AS type_average_height, 
    AVG(d.dragon_weight) AS type_average_weight, 
    AVG(d.dragon_age) AS type_average_age, 
    SUM(d.number_of_people_killed) AS total_number_of_people_killed,
    COUNT(d.dragon_id) AS total_number
FROM 
    Types t
LEFT JOIN 
    Dragons d ON t.type_id = d.type_id
GROUP BY 
    t.type_id, t.type_name
ORDER BY 
    t.type_name;

-- Insert a new type
INSERT INTO
    Types (type_name)
VALUES
    (:typeNameInput);

-- Update a type
UPDATE
    Types
SET
    type_name = :typeNameInput
WHERE
    type_id = :type_id;

-- Delete a type
DELETE FROM
    Types
WHERE
    type_id = :type_id;

-- *** Dragons PAGE ***
-- Get a dragon
SELECT
    *
FROM
    Dragons;

-- Insert a new dragon
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
        dragon_lore,
        number_of_people_killed
    )
VALUES
    (
        :dragonNameInput,
        :typeidInput,
        :dragonHeightInput,
        :dragonWeightInput,
        :dragonAgeInput,
        :dragonPersonalityInput,
        :dragonAlignmentInput,
        :environmentidInput,
        :dragonLoreInput,
        :number_of_people_killedInput
    );

-- Update a dragon
UPDATE
    Dragons
SET
    dragon_name = :dragonNameInput,
    type_id = :typeidInput,
    dragon_height = :dragonHeightInput,
    dragon_weight = :dragonWeightInput,
    dragon_age = :dragonAgeInput,
    dragon_personality = :dragonPersonalityInput,
    dragon_alignment = :dragonAlignmentInput,
    environment_id = :environmentidInput,
    dragon_lore = :dragonLoreInput,
    number_of_people_killed = :number_of_people_killedInput
WHERE
    dragon_id = :dragon_id;

-- Delete a dragon
DELETE FROM
    Dragons
WHERE
    dragon_id = :dragon_id;


-- Get all Types for the dropdown
SELECT
    type_id,
    type_name
FROM
    Types
ORDER BY
    type_name;

-- Get all Environments for the dropdown
SELECT
    environment_id,
    environment_name
FROM
    Environments
ORDER BY
    environment_name;

-- Get all Abilities for the dropdown
SELECT
    ability_id,
    ability_name
FROM
    Abilities
ORDER BY
    ability_name;