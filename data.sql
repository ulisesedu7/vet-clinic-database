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

/*
 *New data from feature 4
*/
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, 'Apr 23, 2000'),
('Maisy Smith', 26, 'Jan 17, 2019'),
('Stephanie Mendez', 64, 'May 4, 1981'),
('Jack Harkness', 38, 'Jun 8, 2008');

INSERT INTO specializations VALUES (1, 1),
(3, 1),
(3, 2),
(4, 2);

-- Data for the visits
INSERT INTO visits SELECT vets.id, animals.id, 'May 24, 2020' FROM animals JOIN vets ON vets.name='William Tatcher' and animals.name='Agumon';
INSERT INTO visits SELECT vets.id, animals.id, 'Jul 22, 2020' FROM animals JOIN vets ON vets.name='Stephanie Mendez' and animals.name='Agumon';
INSERT INTO visits SELECT vets.id, animals.id, 'Feb 2, 2021' FROM animals JOIN vets ON vets.name='Jack Harkness' and animals.name='Gabumon';
INSERT INTO visits SELECT vets.id, animals.id, 'Jan 5, 2020' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Pikachu';
INSERT INTO visits SELECT vets.id, animals.id, 'Mar 8, 2020' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Pikachu';
INSERT INTO visits SELECT vets.id, animals.id, 'May 14, 2020' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Pikachu';
INSERT INTO visits SELECT vets.id, animals.id, 'May 4, 2021' FROM animals JOIN vets ON vets.name='Stephanie Mendez' and animals.name='Devimon';
INSERT INTO visits SELECT vets.id, animals.id, 'Feb 24, 2021' FROM animals JOIN vets ON vets.name='Jack Harkness' and animals.name='Charmander';
INSERT INTO visits SELECT vets.id, animals.id, 'Dec 21, 2019' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Plantmon';
INSERT INTO visits SELECT vets.id, animals.id, 'Aug 10, 2020' FROM animals JOIN vets ON vets.name='William Tatcher' and animals.name='Plantmon';
INSERT INTO visits SELECT vets.id, animals.id, 'Apr 7, 2021' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Plantmon';
INSERT INTO visits SELECT vets.id, animals.id, 'Sep 29, 2019' FROM animals JOIN vets ON vets.name='Stephanie Mendez' and animals.name='Squirtle';
INSERT INTO visits SELECT vets.id, animals.id, 'Oct 3, 2020' FROM animals JOIN vets ON vets.name='Jack Harkness' and animals.name='Angemon';
INSERT INTO visits SELECT vets.id, animals.id, 'Nov 4, 2020' FROM animals JOIN vets ON vets.name='Jack Harkness' and animals.name='Angemon';
INSERT INTO visits SELECT vets.id, animals.id, 'Jan 24, 2019' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Boarmon';
INSERT INTO visits SELECT vets.id, animals.id, 'May 15, 2019' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Boarmon';
INSERT INTO visits SELECT vets.id, animals.id, 'Feb 27, 2020' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Boarmon';
INSERT INTO visits SELECT vets.id, animals.id, 'Aug 3, 2020' FROM animals JOIN vets ON vets.name='Maisy Smith' and animals.name='Boarmon';
INSERT INTO visits SELECT vets.id, animals.id, 'May 24, 2020' FROM animals JOIN vets ON vets.name='Stephanie Mendez' and animals.name='Blossom';
INSERT INTO visits SELECT vets.id, animals.id, 'Jan 11, 2021' FROM animals JOIN vets ON vets.name='William Tatcher' and animals.name='Blossom';

/*
 *New data from performance audit
*/
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
