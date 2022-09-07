require_relative 'album'

class AlbumRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, arsist_id FROM albums;
    sql = "SELECT * FROM albums;"
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []
    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      albums << album
    end
    # Returns an array of Album objects.
    return albums
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    # Returns an Album object.
    album_record = result_set[0]

    album = Album.new
    album.id = album_record['id']
    album.title = album_record['title']
    album.release_year = album_record['release_year']
    album.artist_id = album_record['artist_id']

    return album
  end
end