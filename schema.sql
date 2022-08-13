/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species TEXT,
    PRIMARY KEY(id)
);

-- Command used to add the species column to the table without recreating it
ALTER TABLE animals ADD COLUMN species TEXT;

-- Command to modify the animals table id without recreating it
BEGIN;
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD id INT GENERATED ALWAYS AS IDENTITY NOT NULL;
ALTER TABLE animals ADD PRIMARY KEY (id);
COMMIT;

/*
 *New tables for Feature 3
*/
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    full_name TEXT,
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name TEXT,
    PRIMARY KEY(id)
);

-- Commands to modify the animals table new columns
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owner_id INT;

-- Commands to add the foreign key 
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

/*
 *New table4 for Feature 4
*/
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name TEXT,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE specializations (
    vet_id INT, 
    species_id INT
);

CREATE TABLE visits (
    vet_id INT,
    animal_id INT,
    date_of_visit DATE
);
