require_relative 'post'

class PostRepository

  def all
    sql = 'SELECT id, title, content, view_number, user_account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    posts = []
    result_set.each do |record|
      post = Post.new
      post.id = record['id'].to_i
      post.title = record['title']
      post.content = record['content']
      post.view_number = record['view_number'].to_i
      post.user_account_id = record['user_account_id'].to_i
      posts << post
    end
    return posts
  end

  def find(id)
    sql = 'SELECT id, title, content, view_number, user_account_id FROM posts WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    post_record = result_set.first
    post = Post.new
    post.id = post_record['id'].to_i
    post.title = post_record['title']
    post.content = post_record['content']
    post.view_number = post_record['view_number'].to_i
    post.user_account_id = post_record['user_account_id'].to_i
    return post
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, view_number, user_account_id) VALUES($1, $2, $3, $4);'
    sql_params = [ post.title, post.content, post.view_number, post.user_account_id ]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  # def update(post) SKIP
  # end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end