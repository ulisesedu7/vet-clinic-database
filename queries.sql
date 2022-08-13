/*Queries that provide answers to the questions from all projects.*/

/*
  *Queries of feature 1
*/
--Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

--List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth > '2016-12-31' AND date_of_birth < '2019-01-01';

--List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

--List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

--List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--Find all animals that are neutered
SELECT * FROM animals where neutered = true;

--Find all animals not named Gabumon
SELECT * FROM animals where name <> 'Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals where weight_kg BETWEEN 10.4 AND 17.3;

/*
  *Queries of feature 2
*/
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-12-31' AND date_of_birth <= '2000-01-01' GROUP BY species;

/*
  *Transactions actions
*/
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

/*
 *Queries from feature 3
*/
-- What animals belong to Melody Pond?
SELECT animals.name, owners.full_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name, species.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species_id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name
FROM animals
FULL JOIN owners
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(species_id), species.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, animals.species_id, owners.full_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Jennifer Orwell' AND species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owners.full_name, animals.escape_attempts
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(owner_id)
FROM animals
FULL JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY count DESC;

/*
 *Queries from feature 4
*/
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit
FROM animals
JOIN visits
ON visits.vet_id = 1 AND visits.animal_id = animals.id
ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(DISTINCT animal_id) AS animals_visited
FROM visits
JOIN vets
ON visits.vet_id = vets.id
WHERE visits.vet_id = 3
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species_id
FROM vets
FULL JOIN specializations
ON vets.id = specializations.vet_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits ON visits.animal_id = animals.id
WHERE visits.vet_id = 3 AND
visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(animal_id) FROM visits
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit AS first_visit FROM animals
FULL JOIN visits on animals.id = visits.animal_id
WHERE visits.vet_id = 2
ORDER BY date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM visits
JOIN animals on animals.id = visits.animal_id
JOIN vets on vets.id = visits.vet_id
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animal_id) AS visitations FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets on visits.vet_id = vets.id
WHERE visits.vet_id NOT IN (SELECT species_id FROM specializations WHERE vet_id = vets.id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species_id) FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name ORDER BY COUNT DESC LIMIT 1;