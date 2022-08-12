/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', 'Feb 3, 2020', 0, true, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', 'Nov 15, 2018', 2, true, 8);
INSERT INTO animals VALUES (3, 'Pikachu', 'Jan 7, 2021', 1, false, 15.04);
INSERT INTO animals VALUES (4, 'Devimon', 'May 12, 2017', 5, true, 11);

/*
  *New data from feature 2
*/
INSERT INTO animals VALUES (5, 'Charmander', 'Feb 8, 2020', 0, false, -11, ''),
(6, 'Plantmon', 'Nov 15, 2021', 2, true, -5.7, ''),
(7, 'Squirtle', 'Apr 2, 1993', 3, false, -12.13, ''),
(8, 'Angemon', 'Jun 12, 2005', 1, true, -45, ''),
(9, 'Boarmon', 'Jun 7, 2005', 7, true, 20.4, ''),
(10, 'Blossom', 'Oct 13, 1998', 3, true, 17, ''),
(11, 'Ditto', 'May 14, 2022', 4, true, 22, '');

/*
 *New data from feature 3
*/
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 15),
('Melody Pond', 77),
('Dean Winchester ', 14),
('Jodie Whittake', 38);

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Modify the animals table to include the respective species id
BEGIN;
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
SELECT name, species_id FROM animals;
COMMIT;

-- Modify the animals table to include the owners id
BEGIN;
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';
SELECT name, owner_id FROM animals;
COMMIT;