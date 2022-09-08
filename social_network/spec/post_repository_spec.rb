require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  describe "#all" do
    it "gets all user accounts" do
      post_repository = PostRepository.new
      posts = post_repository.all
      expect(posts.length).to eq 2
      expect(posts.first.id).to eq 1
      expect(posts.first.title).to eq 'title 1'
      expect(posts.first.content).to eq 'content 1'
      expect(posts.first.view_number).to eq 50
      expect(posts.first.user_account_id).to eq 1
      expect(posts.last.id).to eq 2
      expect(posts.last.title).to eq 'title 2'
      expect(posts.last.content).to eq 'content 2'
      expect(posts.last.view_number).to eq 60
      expect(posts.last.user_account_id).to eq 2
    end
  end

  describe "#find(id)" do
    it "gets a single post" do
      post_repository = PostRepository.new
      post = post_repository.find(2)
      expect(post.id).to eq 2
      expect(post.title).to eq 'title 2'
      expect(post.content).to eq 'content 2'
      expect(post.view_number).to eq 60
      expect(post.user_account_id).to eq 2
    end
  end

  describe "#create" do
    it "creates a record from Post object" do
      post_repository = PostRepository.new
      post = Post.new
      post.title = 'title 3'
      post.content = 'content 3'
      post.view_number = '70'
      post.user_account_id = '1'
      post_repository.create(post)
      posts = post_repository.all
      expect(posts.last.id).to eq 3
      expect(posts.last.title).to eq 'title 3'
      expect(posts.last.content).to eq 'content 3'
      expect(posts.last.view_number).to eq 70
      expect(posts.last.user_account_id).to eq 1
    end
  end

  describe "#delete" do
    it "deletes a record from the database, selected by id" do
      post_repository = PostRepository.new
      post_repository.delete(1)
      posts = post_repository.all
      expect(posts.length).to eq 1
      expect(posts.first.id).to eq 2
      expect(posts.first.title).to eq 'title 2'
      expect(posts.first.content).to eq 'content 2'
      expect(posts.first.view_number).to eq 60
      expect(posts.first.user_account_id).to eq 2
    end
  end
end