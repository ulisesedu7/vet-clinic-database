/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', 'Feb 3, 2020', 0, true, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', 'Nov 15, 2018', 2, true, 8);
INSERT INTO animals VALUES (3, 'Pikachu', 'Jan 7, 2021', 1, false, 15.04);
INSERT INTO animals VALUES (4, 'Devimon', 'May 12, 2017', 5, true, 11);

/* New data from feature 2 */
INSERT INTO animals VALUES (5, 'Charmander', 'Feb 8, 2020', 0, false, -11, ''),
(6, 'Plantmon', 'Nov 15, 2021', 2, true, -5.7, ''),
(7, 'Squirtle', 'Apr 2, 1993', 3, false, -12.13, ''),
(8, 'Angemon', 'Jun 12, 2005', 1, true, -45, ''),
(9, 'Boarmon', 'Jun 7, 2005', 7, true, 20.4, ''),
(10, 'Blossom', 'Oct 13, 1998', 3, true, 17, ''),
(11, 'Ditto', 'May 14, 2022', 4, true, 22, '');

/* Transactions actions */
-- Set the species column and then rollback
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

-- Set the species column correctly
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Delete everthing and rollback
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Create SavePoint transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT ripNew;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO ripNew;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0; 
COMMIT;
