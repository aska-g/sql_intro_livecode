# the list of artists with albums title including the word 'hits', ordered by artist name.
SELECT artists.name, albums.title
FROM albums JOIN artists ON (albums.artist_id = artists.id)
WHERE albums.title LIKE '%hits%'
ORDER BY artists.name


# list of top 5 artists (names) with more albums
SELECT artists.name, count(albums.id) as albums_count
FROM albums JOIN artists ON (albums.artist_id = artists.id)
GROUP BY artists.name
ORDER BY albums_count DESC
LIMIT 5

# list of top 5 artists (names) with more genres
SELECT artists.name, count(DISTINCT tracks.genre_id) as genres_count
FROM albums JOIN artists ON (albums.artist_id = artists.id)
	JOIN tracks ON (tracks.album_id = albums.id)
GROUP BY artists.name
ORDER BY genres_count DESC
LIMIT 5

# avg number of tracks per album
SELECT count(tracks.id) / count(DISTINCT tracks.album_id)
FROM tracks

# list of artists (id and name) that do not have any album
SELECT artists.id, artists.name
FROM artists
WHERE artists.id NOT IN (SELECT albums.artist_id FROM albums)

# list of albums (title) that have average song length > 180s
SELECT albums.title, avg(tracks.milliseconds) / 10000 AS avg_length
FROM tracks JOIN albums ON (tracks.album_id = albums.id)
GROUP BY albums.title
HAVING avg_length > 180

# list of artists that have tracks of all genres
SELECT a.name
FROM artists a
WHERE NOT EXISTS 
	(SELECT *
	 FROM genres
	 WHERE genres.id NOT IN 
	 	(SELECT tracks.genre_id 
	 	 FROM tracks JOIN albums ON (albums.id = tracks.album_id)
	 	 WHERE albums.artist_id = a.id))


