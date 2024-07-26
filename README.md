# Music-Management-and-Recommendation-System-in-SQL

This project is a comprehensive Music Management and Recommendation System designed to handle various aspects of music interaction, including user preferences, listening history, social connections, and playlist management. It allows users to manage their music libraries, receive personalized song recommendations, and interact with friends.

#Features

User Management: Create and manage user profiles with personal details.
Artist and Album Management: Track artists and albums, linking them to songs.
Genre Classification: Categorize songs by genre for better organization and recommendations.
Song Management: Maintain a catalog of songs with detailed information.
Listening History: Record and analyze users' listening habits.
Preferences: Capture user preferences for different music genres.
Playlists: Create and manage user-specific playlists.
Social Integration: Connect users as friends and incorporate friends' preferences into recommendations.
Recommendations: Suggest songs based on user preferences, listening history, and friends' preferences.
Recent Releases: Fetch recently added songs to keep the music library up-to-date.


#Database Schema

--Users Table--

user_id (INT): Unique identifier for each user.
name (VARCHAR): User’s name.
email (VARCHAR): User’s email address (unique).
date_of_birth (DATE): User’s date of birth.
signup_date (DATE): Date when the user signed up.

--Artists Table--

artist_id (INT): Unique identifier for each artist.
name (VARCHAR): Name of the artist.

--Albums Table--

album_id (INT): Unique identifier for each album.
title (VARCHAR): Title of the album.
artist_id (INT): Foreign key referencing the artist.
release_date (DATE): Release date of the album.

--Genres Table--

genre_id (INT): Unique identifier for each genre.
name (VARCHAR): Name of the genre.

--Songs Table--

song_id (INT): Unique identifier for each song.
title (VARCHAR): Title of the song.
artist_id (INT): Foreign key referencing the artist.
album_id (INT): Foreign key referencing the album.
genre_id (INT): Foreign key referencing the genre.
duration (INT): Duration of the song in seconds.
release_date (DATE): Release date of the song.

--ListeningHistory Table--

user_id (INT): Foreign key referencing the user.
song_id (INT): Foreign key referencing the song.
listen_date (DATE): Date when the song was listened to.
PRIMARY KEY: Combination of user_id, song_id, and listen_date.

--Preferences Table--

user_id (INT): Foreign key referencing the user.
genre_id (INT): Foreign key referencing the genre.
preference_score (INT): Preference score for the genre.
PRIMARY KEY: Combination of user_id and genre_id.

--Playlists Table--

playlist_id (INT): Unique identifier for each playlist.
user_id (INT): Foreign key referencing the user.
name (VARCHAR): Name of the playlist.
creation_date (DATE): Date when the playlist was created.

--PlaylistSongs Table--

   playlist_id (INT): Foreign key referencing the playlist.
   song_id (INT): Foreign key referencing the song.
   PRIMARY KEY: Combination of playlist_id and song_id.

--Friends Table--

   user_id (INT): Foreign key referencing the user.
   friend_id (INT): Foreign key referencing the friend. 
   PRIMARY KEY: Combination of user_id and friend_id.


SQL Queries

1. Recommend Songs Based on User Preferences

        SELECT s.song_id, s.title, s.artist_id
        FROM Songs s
        JOIN Preferences p ON s.genre_id = p.genre_id
        WHERE p.user_id = 1
        ORDER BY p.preference_score DESC;

2. Get User's Most Played Songs

        SELECT s.title, s.artist_id, COUNT(*) AS play_count
        FROM ListeningHistory lh
        JOIN Songs s ON lh.song_id = s.song_id
        WHERE lh.user_id = 1
        GROUP BY s.title, s.artist_id
        ORDER BY play_count DESC;

3.Get Recommended Songs Based on Friends' Preferences

        SELECT s.title, s.artist_id
        FROM Songs s
        JOIN Preferences p ON s.genre_id = p.genre_id
        JOIN Friends f ON p.user_id = f.friend_id
        WHERE f.user_id = 1
        ORDER BY p.preference_score DESC
        LIMIT 10;

4. Get Recently Added Songs

        SELECT title, artist_id
        FROM Songs
        WHERE release_date > DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        ORDER BY release_date DESC;

5. Get User's Playlist Details
        
        SELECT p.name AS playlist_name, s.title AS song_title, s.artist_id
        FROM Playlists p
        JOIN PlaylistSongs ps ON p.playlist_id = ps.playlist_id
        JOIN Songs s ON ps.song_id = s.song_id
        WHERE p.user_id = 1;

6. Recommend Songs Based on User Preferences and Listening History

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

Setup

1. Create Database: CREATE DATABASE project;
2. Use Database: USE project;
3. Run Table Creation Scripts: Execute the provided CREATE TABLE statements to set up the database schema.
4. Insert Data: Use the INSERT INTO statements to populate tables with sample data

Notes
1. Ensure that all foreign key constraints are correctly set up to maintain referential integrity.
2. Customize the SQL queries as needed to fit specific use cases or user requirements.
3. Regularly update the data to reflect new music releases and user interactions.
