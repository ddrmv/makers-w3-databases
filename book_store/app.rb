require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

DatabaseConnection.connect('book_store')

sql = 'SELECT id, title, author_name FROM books;'
result = DatabaseConnection.exec_params(sql, [])

# result.each do |record|
#   p record
# end

book_repository = BookRepository.new

book_repository.all.each do |record|
  puts "#{record.id} - #{record.title} - #{record.author_name}"
end

# 1 - Nineteen Eighty-Four - George Orwell