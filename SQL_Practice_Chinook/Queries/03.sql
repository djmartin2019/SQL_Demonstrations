-- 3. Show the number of tracks in each playlist.

SELECT p.playlist_id, COUNT(*) AS track_count
FROM playlist AS p
JOIN playlist_track AS pt
ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id
ORDER BY track_count DESC;
