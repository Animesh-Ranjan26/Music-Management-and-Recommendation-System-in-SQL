create database project;
use project;

CREATE table Users (
	user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    signup_date DATE
);

CREATE TABLE Artists (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Albums (
    album_id INT PRIMARY KEY,
    title VARCHAR(100),
    artist_id INT,
    release_date DATE,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY,
    name VARCHAR(50)
);
CREATE TABLE Songs (
    song_id INT PRIMARY KEY,
    title VARCHAR(100),
    artist_id INT,
    album_id INT,
    genre_id INT,
    duration INT,  -- Duration in seconds
    release_date DATE,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);

CREATE TABLE ListeningHistory (
    user_id INT,
    song_id INT,
    listen_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id),
    PRIMARY KEY (user_id, song_id, listen_date)
);

CREATE TABLE Preferences (
    user_id INT,
    genre_id INT,
    preference_score INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id),
    PRIMARY KEY (user_id, genre_id)
);

CREATE TABLE Playlists (
    playlist_id INT PRIMARY KEY,
    user_id INT,
    name VARCHAR(100),
    creation_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE PlaylistSongs (
    playlist_id INT,
    song_id INT,
    FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id),
    PRIMARY KEY (playlist_id, song_id)
);

CREATE TABLE Friends (
	user_id INT,
    friend_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (friend_id) REFERENCES Users(user_id),
    PRIMARY KEY (user_id, friend_id)
);
INSERT INTO Users (user_id, name, email, date_of_birth, signup_date) VALUES 
(1, 'Alice', 'alice@example.com', '1990-01-01', '2023-01-01'),
(2, 'Bob', 'bob@example.com', '1985-05-05', '2023-02-01'),
(3, 'Charlie', 'charlie@example.com', '1992-03-15', '2023-03-01'),
(4, 'David', 'david@example.com', '1988-07-20', '2023-04-01'),
(5, 'Eve', 'eve@example.com', '1995-12-10', '2023-05-01');

INSERT INTO Artists (artist_id, name) VALUES 
(1, 'Artist 1'),
(2, 'Artist 2'),
(3, 'Artist 3'),
(4, 'Artist 4'),
(5, 'Artist 5'),
(6, 'Artist 6');

INSERT INTO Albums (album_id, title, artist_id, release_date) VALUES 
(1, 'Album 1', 1, '2020-01-01'),
(2, 'Album 2', 2, '2020-02-01'),
(3, 'Album 3', 3, '2020-03-01'),
(4, 'Album 4', 4, '2020-04-01'),
(5, 'Album 5', 5, '2020-05-01'),
(6, 'Album 6', 6, '2020-06-01');

INSERT INTO Genres (genre_id, name) VALUES 
(1, 'Rock'),
(2, 'Pop'),
(3, 'Jazz'),
(4, 'Hip-Hop'),
(5, 'Classical'),
(6, 'Electronic');

INSERT INTO Songs (song_id, title, artist_id, album_id, genre_id, duration, release_date) VALUES 
(1, 'Song A', 1, 1, 1, 180, '2020-01-01'),
(2, 'Song B', 2, 2, 2, 200, '2020-02-01'),
(3, 'Song C', 3, 3, 3, 220, '2020-03-01'),
(4, 'Song D', 4, 4, 4, 240, '2020-04-01'),
(5, 'Song E', 5, 5, 5, 260, '2020-05-01'),
(6, 'Song F', 6, 6, 6, 280, '2020-06-01'),
(7, 'Song G', 1, 1, 1, 300, '2020-07-01'),
(8, 'Song H', 2, 2, 2, 320, '2020-08-01'),
(9, 'Song I', 3, 3, 3, 340, '2020-09-01');

INSERT INTO ListeningHistory (user_id, song_id, listen_date) VALUES 
(1, 1, '2024-01-01'),
(1, 2, '2024-01-02'),
(2, 3, '2024-01-03'),
(1, 3, '2024-01-03'),
(2, 1, '2024-01-04'),
(3, 2, '2024-01-05'),
(4, 4, '2024-01-06'),
(5, 5, '2024-01-07'),
(1, 6, '2024-01-08');

INSERT INTO Preferences (user_id, genre_id, preference_score) VALUES 
(1, 1, 10),
(1, 2, 8),
(2, 3, 10),
(1, 3, 7),
(2, 1, 9),
(3, 2, 8),
(4, 4, 10),
(5, 5, 6),
(1, 6, 5);

INSERT INTO Playlists (playlist_id, user_id, name, creation_date) VALUES 
(1, 1, 'Alice\'s Favorites', '2023-03-01'),
(2, 2, 'Bob\'s Playlist', '2023-03-05'),
(3, 3, 'Charlie\'s Mix', '2023-06-01'),
(4, 4, 'David\'s Favorites', '2023-07-01'),
(5, 5, 'Eve\'s Playlist', '2023-08-01');

INSERT INTO PlaylistSongs (playlist_id, song_id) VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 1),
(3, 3),
(4, 4),
(4, 5),
(5, 6),
(5, 7);

INSERT INTO Friends (user_id, friend_id) VALUES 
(1, 2),
(1, 3),
(2, 1),
(3, 1),
(2, 4),
(3, 5);


-- Using listening history and preferences, we can suggest songs to users.

SELECT s.song_id, s.title, s.artist_id
FROM Songs s
JOIN Preferences p ON s.genre_id = p.genre_id
WHERE p.user_id = 1
ORDER BY p.preference_score DESC;


-- Get User's Most Played Songs

SELECT s.title, s.artist_id, COUNT(*) AS play_count
FROM ListeningHistory lh
JOIN Songs s ON lh.song_id = s.song_id
WHERE lh.user_id = 1
GROUP BY s.title, s.artist_id
ORDER BY play_count DESC;


-- Get Recommended Songs Based on Friends' Preferences

SELECT s.title, s.artist_id
FROM Songs s
JOIN Preferences p ON s.genre_id = p.genre_id
JOIN Friends f ON p.user_id = f.friend_id
WHERE f.user_id = 1
ORDER BY p.preference_score DESC
LIMIT 10;


-- Get Recently Added Songs:
SELECT title, artist_id
FROM Songs
WHERE release_date > DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY release_date DESC;


-- Get User's Playlist Details:
SELECT p.name AS playlist_name, s.title AS song_title, s.artist_id
FROM Playlists p
JOIN PlaylistSongs ps ON p.playlist_id = ps.playlist_id
JOIN Songs s ON ps.song_id = s.song_id
WHERE p.user_id = 1;


/*
UserPreferences: Calculates the average preference score for each genre for a specific user.
GenreSongRank: Joins the songs with the user's preferences to rank songs by genre preference.
Final Select: Excludes songs already listened to by the user and orders the remaining songs by preference score.
*/
WITH UserPreferences AS (
    SELECT genre_id, AVG(preference_score) AS avg_score
    FROM Preferences
    WHERE user_id = 1
    GROUP BY genre_id
),
GenreSongRank AS (
    SELECT s.song_id, s.title, s.artist_id, up.avg_score
    FROM Songs s
    JOIN UserPreferences up ON s.genre_id = up.genre_id
)
SELECT gs.song_id, gs.title, a.name AS artist
FROM GenreSongRank gs
JOIN Artists a ON gs.artist_id = a.artist_id
WHERE gs.song_id NOT IN (
    SELECT song_id 
    FROM ListeningHistory 
    WHERE user_id = 1
)
ORDER BY gs.avg_score DESC
LIMIT 10;