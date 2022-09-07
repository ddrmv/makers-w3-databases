require 'artist_repository'
require 'database_connection'

def reset_artists_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test'})
  connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do
  before(:each) do
    reset_artists_table
  end

  it "accesses all records" do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq 2
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq 'Pixies'
    expect(artists.first.genre).to eq 'Rock'
    expect(artists[1].id).to eq '2'
  end

  describe "#find" do
    it "returns one Artist object selected by id using parameter" do
      repo = ArtistRepository.new
      artist = repo.find(2)
      expect(artist.id).to eq '2'
      expect(artist.name).to eq 'ABBA'
      expect(artist.genre).to eq 'Pop'
    end
  end
end