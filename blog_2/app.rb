require_relative 'lib/post_repository'
require_relative 'lib/tag_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('blog_2')

# print posts associated with a tag
post_repo = PostRepository.new
tag_to_find = 'coding'
posts_by_tag = post_repo.find_by_tag(tag_to_find)
puts "Posts for tag '#{tag_to_find}':"
posts_by_tag.each do |post|
  puts " * #{post.id} - #{post.title}"
end

# print tags associated with a post
tag_repo = TagRepository.new
post_id = 2
tags_for_post = tag_repo.find_by_post(post_id)
puts "Tags for post with id '#{post_id}':"
tags_for_post.each do |tag|
  puts " * #{tag.id} - #{tag.name}"
end