require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')

artist_repository = ArtistRepository.new

# artist_repository.all.each do |record|
#   p record
# end

artist = artist_repository.find(2)
puts "#{artist.id} - #{artist.name} - #{artist.genre}"

album_repository = AlbumRepository.new

# album_repository.all.each do |record|
#   p record.title
# end

album = album_repository.find(3)
puts "#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}"