require_relative 'database_connection'
require_relative 'post'

class PostRepository
  def find_by_tag(tag_name)
    # find all posts tagged with tag 'string'
    sql = 'SELECT posts.id, posts.title
            FROM posts
            JOIN posts_tags ON posts.id = posts_tags.post_id
            JOIN tags ON posts_tags.tag_id = tags.id
            WHERE tags.name = $1;'
    sql_params = [tag_name]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    posts = []
    result_set.each do |record|
      post = Post.new
      post.id = record['id'].to_i
      post.title = record['title']
      posts << post
    end

    # returns lost of posts
    return posts
  end
end