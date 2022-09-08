require_relative '../app'
require 'album_repository'
require 'artist_repository'

def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  RSpec.describe Application do
    before(:each) do
      reset_albums_table
    end

  it "exists" do
    terminal = double(:terminal)
    album_repository = AlbumRepository.new
    artist_repository = ArtistRepository.new
    app = Application.new('music_library_test', terminal, 
      album_repository, artist_repository)
    expect(app).to be
  end

#   # prints first part of menu
#   it "prints the option selection menu" do
#     terminal = double(:terminal)
#     album_repository = AlbumRepository.new
#     artist_repository = ArtistRepository.new
#     app = Application.new('music_library_test', terminal, 
#       album_repository, artist_repository)
#     menu_string = "Welcome to the music library manager!\n\n" \
#     "What would you like to do?\n" \
#     " 1 - List all albums\n" \
#     " 2 - List all artists\n\n" \
#     "Enter your choice: "
#     expect(terminal).to receive(:puts).and_return(menu_string)
#     app.run
#   end

it "gets 5 and raises error" do
  terminal = double(:terminal)
  album_repository = AlbumRepository.new
  artist_repository = ArtistRepository.new
  app = Application.new('music_library_test', terminal, 
    album_repository, artist_repository)
  menu_string = "Welcome to the music library manager!\n\n" \
  "What would you like to do?\n" \
  " 1 - List all albums\n" \
  " 2 - List all artists\n\n" \
  "Enter your choice: "
  expect(terminal).to receive(:puts).with(menu_string)
  expect(terminal).to receive(:gets).and_return("5")
  expect { app.run } .to raise_error "Invalid choice."
end

  it "gets 1 as choice and prints list of albums" do
    terminal = double(:terminal)
    album_repository = AlbumRepository.new
    artist_repository = ArtistRepository.new
    app = Application.new('music_library_test', terminal, 
      album_repository, artist_repository)
    menu_string = "Welcome to the music library manager!\n\n" \
    "What would you like to do?\n" \
    " 1 - List all albums\n" \
    " 2 - List all artists\n\n" \
    "Enter your choice: "
    expect(terminal).to receive(:puts).with(menu_string)
    expect(terminal).to receive(:gets).and_return("1")
    expect(terminal).to receive(:puts).with("Here is the list of albums:")
    album_string = " * 1 - Doolittle\n * 2 - Surfer Rosa\n"
    expect(terminal).to receive(:puts).with(album_string)
    app.run
  end

  it "gets 2 as choice and prints list of artists" do
    terminal = double(:terminal)
    album_repository = AlbumRepository.new
    artist_repository = ArtistRepository.new
    app = Application.new('music_library_test', terminal, 
      album_repository, artist_repository)
    menu_string = "Welcome to the music library manager!\n\n" \
    "What would you like to do?\n" \
    " 1 - List all albums\n" \
    " 2 - List all artists\n\n" \
    "Enter your choice: "
    expect(terminal).to receive(:puts).with(menu_string)
    expect(terminal).to receive(:gets).and_return("2")
    expect(terminal).to receive(:puts).with("Here is the list of artists:")
    artist_string = " * 1 - Pixies\n * 2 - ABBA\n"
    expect(terminal).to receive(:puts).with(artist_string)
    app.run
  end
end




