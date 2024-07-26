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

Database Schema
Users Table
user_id (INT): Unique identifier for each user.
name (VARCHAR): User’s name.
email (VARCHAR): User’s email address (unique).
date_of_birth (DATE): User’s date of birth.
signup_date (DATE): Date when the user signed up.
Artists Table
artist_id (INT): Unique identifier for each artist.
name (VARCHAR): Name of the artist.
Albums Table
album_id (INT): Unique identifier for each album.
title (VARCHAR): Title of the album.
artist_id (INT): Foreign key referencing the artist.
release_date (DATE): Release date of the album.
Genres Table
genre_id (INT): Unique identifier for each genre.
name (VARCHAR): Name of the genre.
Songs Table
song_id (INT): Unique identifier for each song.
title (VARCHAR): Title of the song.
artist_id (INT): Foreign key referencing the artist.
album_id (INT): Foreign key referencing the album.
genre_id (INT): Foreign key referencing the genre.
duration (INT): Duration of the song in seconds.
release_date (DATE): Release date of the song.
ListeningHistory Table
user_id (INT): Foreign key referencing the user.
song_id (INT): Foreign key referencing the song.
listen_date (DATE): Date when the song was listened to.
PRIMARY KEY: Combination of user_id, song_id, and listen_date.
Preferences Table
user_id (INT): Foreign key referencing the user.
genre_id (INT): Foreign key referencing the genre.
preference_score (INT): Preference score for the genre.
PRIMARY KEY: Combination of user_id and genre_id.
Playlists Table
playlist_id (INT): Unique identifier for each playlist.
user_id (INT): Foreign key referencing the user.
name (VARCHAR): Name of the playlist.
creation_date (DATE): Date when the playlist was created.
PlaylistSongs Table
playlist_id (INT): Foreign key referencing the playlist.
song_id (INT): Foreign key referencing the song.
PRIMARY KEY: Combination of playlist_id and song_id.
Friends Table
user_id (INT): Foreign key referencing the user.
friend_id (INT): Foreign key referencing the friend.
PRIMARY KEY: Combination of user_id and friend_id.
