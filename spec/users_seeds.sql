-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users, properties RESTART IDENTITY; -- replace with your own table name.
-- TRUNCATE TABLE properties RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email_address, password) VALUES ('Jack', 'JackJones@gmail.com', 'SkyBlue123');
INSERT INTO users (username, email_address, password) VALUES ('Skye', 'Skyhatesthis@ooutlook.com', 'Catperson339');

