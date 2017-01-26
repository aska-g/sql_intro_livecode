# the list of artists with albums title including the word 'hits', ordered by artist name.
SELECT artists.name, albums.title 
FROM artists
JOIN albums ON albums.artist_id = artists.id
WHERE title LIKE '%hits%'
ORDER BY name

# list of top 5 artists (names) with more albums
# count number of albums by the artists.name
SELECT artists.name, COUNT(albums.id) AS number_of_albums
FROM artists
JOIN albums ON albums.artist_id = artists.id
GROUP BY artists.name
ORDER BY number_of_albums DESC, artists.name ASC
LIMIT 5;

# list of top 5 artists (names) with more genres - Check DISTINCT
SELECT artists.name, COUNT(DISTINCT genres.id) AS number_of_genres
FROM artists
JOIN albums ON albums.artist_id = artists.id
JOIN tracks ON tracks.album_id = albums.id
JOIN genres ON tracks.genre_id = genres.id
GROUP BY artists.name
ORDER BY number_of_genres DESC, artists.name ASC
LIMIT 5;


# avg number of tracks per album - Check DISTINCT
# count tracks / count of albums
SELECT COUNT(tracks.id)*1.0/COUNT(DISTINCT tracks.album_id)
FROM tracks

# list of artists (id and name) that do not have any album - Check NOT IN
SELECT artists.id, artists.name
FROM artists
WHERE artists.id NOT IN (SELECT albums.artist_id FROM albums)

# list of albums (title) that have song length average > 180s - Check HAVING
SELECT albums.title, avg(tracks.milliseconds) / 10000 AS avg_length
FROM tracks JOIN albums ON (tracks.album_id = albums.id)
GROUP BY albums.title
HAVING avg_length > 180

# list of artists that have tracks of all genres - Check NOT EXISTS
SELECT a.name
FROM artists a
WHERE NOT EXISTS 
	(SELECT *
	 FROM genres
	 WHERE genres.id NOT IN 
	 	(SELECT tracks.genre_id 
	 	 FROM tracks JOIN albums ON (albums.id = tracks.album_id)
	 	 WHERE albums.artist_id = a.id))




















# return the distinct genres.name 
SELECT artists.name, genres.name
FROM artists
JOIN albums ON albums.artist_id = artists.id
JOIN tracks ON tracks.album_id = albums.id
JOIN genres ON tracks.genre_id = genres.id
GROUP BY artists.name, genres.name
ORDER BY artists.name, genres.name


# list of albums and top genre - Subquery example
SELECT a.title,
	(SELECT genres.name 
	 FROM genres JOIN tracks ON genres.id = tracks.genre_id
	 WHERE tracks.album_id = a.id
	 GROUP BY genres.name
	 ORDER BY COUNT(tracks.id) DESC
	 LIMIT 1)
FROM albums a



