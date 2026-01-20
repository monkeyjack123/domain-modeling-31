-- Drops existing tables, so we start fresh with each
-- run of this script
-- e.g. DROP TABLE IF EXISTS ______;

DROP TABLE IF EXISTS company_industries;
DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS industries;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS users;

-- CREATE TABLES

-- Sales team members (so others know who I am)
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT,
  last_name  TEXT,
  email TEXT
);

-- Companies we sell to (name)
CREATE TABLE companies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

-- Contacts (name, email, phone) and associate each contact with a company
CREATE TABLE contacts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name TEXT,
  last_name  TEXT,
  title      TEXT,  -- wireframe shows job title like "Chief Executive Officer" 
  email      TEXT,
  phone_number TEXT,
  company_id INTEGER,
  FOREIGN KEY (company_id) REFERENCES companies(id)
);

-- Activities (calls/emails/etc) with date/time + notes, associated to a contact
-- and authored by a salesperson (user)
CREATE TABLE activities (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  contact_id INTEGER,
  user_id    INTEGER,
  activity_type TEXT,     -- e.g. 'call', 'email', 'meeting'
  occurred_at   TEXT,     --with a date/time
  notes         TEXT,
  FOREIGN KEY (contact_id) REFERENCES contacts(id),
  FOREIGN KEY (user_id)    REFERENCES users(id)
);

-- Go Further: industries + company has 1+ industries
CREATE TABLE industries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

-- Join table for many-to-many (company <> industry)
CREATE TABLE company_industries (
  company_id  INTEGER,
  industry_id INTEGER,
  PRIMARY KEY (company_id, industry_id),
  FOREIGN KEY (company_id)  REFERENCES companies(id),
  FOREIGN KEY (industry_id) REFERENCES industries(id)
);