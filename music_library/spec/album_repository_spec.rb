require 'album_repository'
require 'database_connection'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
  before(:each) do
    reset_albums_table
  end

  it "reads all elements of records" do
    album_repository = AlbumRepository.new
    albums = album_repository.all
    expect(albums.length).to eq(2)

    expect(albums.first.id).to eq('1')
    expect(albums.first.title).to eq('Doolittle')
    expect(albums.first.release_year).to eq('1989')
    expect(albums.first.artist_id).to eq('1')

    expect(albums[1].id).to eq('2')
    expect(albums[1].title).to eq('Surfer Rosa')
    expect(albums[1].release_year).to eq('1988')
    expect(albums[1].artist_id).to eq('1')
  end

  describe "#find(id)" do
    it "returns populated Album object by passed id" do
      repo = AlbumRepository.new
      album = repo.find(2)
      expect(album.id).to eq '2'
      expect(album.title).to eq 'Surfer Rosa'
      expect(album.release_year).to eq '1988'
      expect(album.artist_id).to eq '1'
    end
  end
end