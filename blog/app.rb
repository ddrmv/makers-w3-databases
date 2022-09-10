require_relative 'lib/post_repository'
require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('blog')
repo = PostRepository.new
post = repo.find_with_comments(2)
puts "Post (#{post.id} - '#{post.title}' - '#{post.content}' has" \
  " #{post.comments.length} comment(s):"
post.comments.each_with_index do |comment, index|
  puts " * #{index + 1} - '#{comment.content}' by #{comment.author_name}"
end
