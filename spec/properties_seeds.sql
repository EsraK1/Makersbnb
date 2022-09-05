-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE properties RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

-- Our albums table has reference to a foreign key ('artist_id')
-- because of that we do line 40 and line 49, user_id
INSERT INTO albums (title, description, price_per_night, user_id) VALUES ('3 bedroom flat', 'Comfortable modern flat!', '£80', '1');
INSERT INTO albums (title, description, price_per_night, user_id) VALUES ('Semi detached 2 bedroom house', 'Amazing for the weekend', '45', '2');
INSERT INTO albums (title, description, price_per_night, user_id) VALUES ('Tiny home','Escape to a Romantic and Magical Hobbit Retreat', '£90', '1');
INSERT INTO users(username, email_adress, password) VALUES ('Jack', 'JackJones@gmail.com', 'SkyBlue123');
