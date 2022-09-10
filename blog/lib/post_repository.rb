require_relative 'post'
require_relative 'comment'

class PostRepository
  def find_with_comments(id)
    # execute sql
    sql = 'SELECT
            posts.id,
            posts.title AS "post_title",
            posts.content AS "post_content",
            comments.id AS "comment_id",
            author_name,
            comments.content AS "comment_content",
            comments.post_id
          FROM posts
          JOIN comments
          ON comments.post_id = posts.id
          WHERE posts.id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    first_record = result_set[0]
    post = Post.new
    post.id = first_record['id'].to_i
    post.title = first_record['post_title']
    post.content = first_record['post_content']
    result_set.each do |record|
      comment = Comment.new
      comment.id = record['comment_id'].to_i
      comment.author_name = record['author_name']
      comment.content = record['comment_content']
      comment.post_id = record['post_id'].to_i
      post.comments << comment
    end

    return post
  end
end