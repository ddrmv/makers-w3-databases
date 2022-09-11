require 'post_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_blog_2_tables.sql')
  connection = PG.connect({host: '127.0.0.1', dbname: 'blog_2_test'})
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do
    reset_tables
  end

# The test has been designed in this spec file instead of recipe .md file
# 1 - test #find_by_tag
# repo = PostRepository.new
# posts = repo.find_by_tag('ruby')
# posts.length # => 2
# posts.first.id # => 2
# posts.first.title # => 'Ruby classes'
# posts.last.id # => 3
# posts.last.title # => 'Using IRB'

  describe "#find_by_tag" do
    it "returns list of posts tagged with 'ruby'" do
      repo = PostRepository.new
      posts = repo.find_by_tag('ruby')
      expect(posts.length).to eq(2)
      expect(posts.first.id).to eq(2)
      expect(posts.first.title).to eq('Ruby classes')
      expect(posts.last.id).to eq(3)
      expect(posts.last.title).to eq('Using IRB')
    end
  end
end