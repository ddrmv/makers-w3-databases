SELECT
    albums.id AS album_id,
    albums.title
  FROM albums
  JOIN artists
  ON albums.artist_id = artists.id
  WHERE
    name = 'Pixies' AND release_year = 1988;
