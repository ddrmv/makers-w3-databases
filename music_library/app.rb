require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, terminal, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @terminal = terminal
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    menu_string = "Welcome to the music library manager!\n\n" \
    "What would you like to do?\n" \
    " 1 - List all albums\n" \
    " 2 - List all artists\n\n" \
    "Enter your choice: "
    @terminal.puts menu_string
    choice = @terminal.gets.chomp
    if choice == "1"
        @terminal.puts "Here is the list of albums:" 
        albums_string = ""
        @album_repository.all.each do |album|
          albums_string << " * #{album.id} - #{album.title}\n"
        end
        @terminal.puts albums_string
    elsif choice == "2"
      @terminal.puts "Here is the list of artists:"
      artists_string = ""
      @artist_repository.all.each do |artist| 
        artists_string << " * #{artist.id} - #{artist.name}\n"
      end
      @terminal.puts artists_string
    else
      fail "Invalid choice."
    end
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library_test',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end