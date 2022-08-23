/*
 *Data Base Schema based on Diagram
*/
-- Create Tables Part
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  name VARCHAR,
  date_of_birth DATE,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR,
  PRIMARY KEY (id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  PRIMARY KEY (id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY (id)
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  type VARCHAR,
  name VARCHAR,
  PRIMARY KEY (id)
);

-- Create Foreign keys connection
ALTER TABLE medical_histories ADD CONSTRAINT fk_patients FOREIGN KEY (patient_id) REFERENCES patients(id);

ALTER TABLE medical_histories ADD CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES treatments(id);

ALTER TABLE invoice_items ADD CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id);

ALTER TABLE invoice_items ADD CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id);

ALTER TABLE invoices ADD CONSTRAINT fk_invoices FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

-- Create Many to Many Relationship
CREATE TABLE history_treatments (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  treatment_id INT,
  medical_history_id INT,
  PRIMARY KEY (treatment_id, medical_history_id)
);

-- Add many to many keys
ALTER TABLE history_treatments ADD CONSTRAINT fk_history FOREIGN KEY (treatment_id) REFERENCES treatments(id);

ALTER TABLE history_treatments ADD CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

