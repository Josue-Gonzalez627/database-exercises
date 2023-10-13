-- Use the albums_db database.
USE albums_db;
SELECT database();

-- What is the primary key for the albums table?
DESCRIBE albums;
-- A: The ID

-- What does the column named 'name' represent?
SELECT name FROM albums;
-- A: Represents the titles of the albums.

-- What do you think the sales column represents?
SELECT sales FROM albums;
-- A: Represents the amount of album Sales. (perhaps copies sold)

-- Find the name of all albums by Pink Floyd.
SELECT artist, name
FROM albums
WHERE artist = 'Pink Floyd';
-- A:
/* The Wall
The Dark Side of the Moon */

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT name, release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- A: 1967

-- What is the genre for the album Nevermind? 
SELECT name, genre
FROM albums
WHERE name = 'Nevermind';
-- A: Grunge, Alternative rock

-- Which albums were released in the 1990s?
SELECT name, release_date
FROM albums
WHERE release_date > 1989 and release_date < 2000
order by release_date desc;
/* A:
Come On Over
Dangerous
Falling into You
Jagged Little Pill
Let's Talk About Love
Metallica
Nevermind
Supernatural
The Bodyguard
The Immaculate Collection
Titanic: Music from the Motion Picture */

-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT 
	name AS low_selling_albums,
    sales
FROM albums
WHERE sales < 20
ORDER by sales desc;
/* A: 
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall
*/