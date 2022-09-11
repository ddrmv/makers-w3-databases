require_relative 'database_connection'
require_relative 'tag'

class TagRepository
  def find_by_post(post_name)
    # find all posts tagged with tag 'string'
    sql = 'SELECT tags.id, tags.name
            FROM tags
            JOIN posts_tags ON tags.id = posts_tags.tag_id
            JOIN posts ON posts_tags.post_id = posts.id
            WHERE posts.id = $1;'
    sql_params = [post_name]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    tags = []
    result_set.each do |record|
      tag = Tag.new
      tag.id = record['id'].to_i
      tag.name = record['name']
      tags << tag
    end

    # returns lost of posts
    return tags
  end
end