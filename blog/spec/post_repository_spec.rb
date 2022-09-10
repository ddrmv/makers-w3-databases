require 'post_repository'

def reset_blog_tables
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect(({host: '127.0.0.1', dbname: 'blog_test'}))
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_blog_tables
  end

  describe "#find_with_comments" do
    it "returns post with two comments" do
      repo = PostRepository.new
      post = repo.find_with_comments(2)
      expect(post.comments.length).to eq 2
      expect(post.title).to eq 'second post title'
      expect(post.content).to eq 'Hello again, world!'

      expect(post.comments.first.id).to eq 2
      expect(post.comments.first.author_name).to eq 'sadsfd'
      expect(post.comments.first.content).to eq "crop"
      expect(post.comments.first.post_id).to eq 2

      expect(post.comments[1].id).to eq 3
      expect(post.comments[1].author_name).to eq 'sadddd'
      expect(post.comments[1].content).to eq "lalala"
      expect(post.comments[1].post_id).to eq 2
    end
  end
end