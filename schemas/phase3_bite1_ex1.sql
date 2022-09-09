SELECT albums.id AS album_id, albums.title
  FROM albums
  JOIN artists
  ON albums.artist_id = artists.id
  WHERE artists.name = 'Taylor Swift';
