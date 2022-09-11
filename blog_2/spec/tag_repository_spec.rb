require 'tag_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_blog_2_tables.sql')
  connection = PG.connect({host: '127.0.0.1', dbname: 'blog_2_test'})
  connection.exec(seed_sql)
end

RSpec.describe TagRepository do
  before(:each) do
    reset_tables
  end

# The test has been designed in this spec file instead of recipe .md file
# 1 - test #find_by_post
# repo = TagRepository.new
# tags = repo.find_by_post(2)
# tags.length # => 2
# tags.first.id # => 1
# tags.first.name # => 'coding'
# tags.last.id # => 4
# tags.last.name # => 'ruby'

  describe "#find_by_post" do
    it "returns list of tags for post with id 2" do
      repo = TagRepository.new
      tags = repo.find_by_post(2)
      expect(tags.length).to eq(2)
      expect(tags.first.id).to eq(1)
      expect(tags.first.name).to eq('coding')
      expect(tags.last.id).to eq(4)
      expect(tags.last.name).to eq('ruby')
    end
  end
end