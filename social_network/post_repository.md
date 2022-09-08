# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table ``*

```
# EXAMPLE

Table: posts

Columns:
id, title, content, view_number, user_account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_posts.sql)

-- Write your SQL seed here. 

TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username)
  VALUES ('user1@gmail.com', 'username1');
INSERT INTO user_accounts (email_address, username)
  VALUES ('user2@gmail.com', 'username2');

INSERT INTO posts (title, content, view_number, user_account_id)
  VALUES('title 1', 'content 1', 50, 1);
INSERT INTO posts (title, content, view_number, user_account_id)
  VALUES('title 2', 'content 2', 60, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
class Post
 
end

class PostRepository
  
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Post
  attr_accessor :id, :title, :content, :view_number, :user_account_id
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# get all user accounts
post_repository = PostRepository.new
posts = post_repository.all
posts.length # => 2
posts.first.id # => 1
posts.first.title # => 'title 1'
posts.first.content # => 'content 1'
posts.first.view_number # => 50
posts.first.user_account_id # => 1
posts.last.id # => 2
posts.last.title # => 'title 2'
posts.last.content # => 'content 2'
posts.last.view_number # => 60
posts.last.user_account_id # => 2

# 2
# Get a single student
post_repository = PostRepository.new
post = post_repository.find(2)
post.id # => 2
post.title # => 'title 2'
post.content # => 'content 2'
post.view_number # => 60
post.user_account_id # => 2

# 3
# creates a record from Post object
post_repository = PostRepository.new
post = Post.new
post.title = 'title 3'
post.content = 'content 3'
post.view_number = '70'
post.user_accout_id = '1'
post_repository.create(post)

# 4
# deletes a record from the database, selected by id
post_repository = PostRepository.new
post_repository.delete(1)
posts = post_repository.all
posts.length # => 1
posts.last.id # => 2
posts.last.title # => 'title 2'
posts.last.content # => 'content 2'
posts.last.view_number # => 60
posts.last.user_account_id # => 2
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._