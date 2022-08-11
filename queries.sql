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
SELECT AVG(escape_attempts) FROM animals WHERE neutered = false;
SELECT AVG(escape_attempts) FROM animals WHERE neutered = true;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth > '1990-12-31' AND date_of_birth < '2000-01-01' GROUP BY species;
