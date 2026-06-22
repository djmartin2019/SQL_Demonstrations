-- 6. Get all albums released by the artist "AC/DC".

SELECT a.album_id, a.title, art.name
FROM album AS a
JOIN artist AS art
ON art.artist_id = a.artist_id
WHERE art.name = 'AC/DC';. Get all albums released by the artist "AC/DC".
