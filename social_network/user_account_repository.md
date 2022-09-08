# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table ``*

```
# EXAMPLE

Table: user_accounts

Columns:
id, email_address, username
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE user_accounts, posts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username)
  VALUES ('user1@gmail.com', 'username1');
INSERT INTO user_accounts (email_address, username)
  VALUES ('user2@gmail.com', 'username2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h localhost social_network_test < spec/seeds_user_accounts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
class UserAccount
  
end

class UserAccountRepository
  
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class UserAccount
  attr_accessor :id, :email_address, :username
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts;

    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts WHERE id = $1;

    # Returns a single UserAccount object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(user_account)
  end

  # def update(user_account) SKIP
  # end

  def delete(user_account)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# get all user accounts
user_account_repository = UserAccountRepository.new
user_accounts = user_account_repository.all
user_accounts.length # => 2
user_accounts.first.id # => 1
user_accounts.first.email_address # => 'user1@gmail.com'
user_accounts.first.username # => 'username1'
user_accounts[1].id # => 2
user_accounts[1].email_address # => 'user2@gmail.com'
user_accounts[1].username # => 'username2'

# 2
# Get a single student
user_account_repository = UserAccountRepository.new
user_account = user_account_repository.find(1)
user_account.id # => 1
user_account.email_address # => 'user1@gmail.com'
user_account.username # => 'username1'

# 3
# creates a record from UserAccount object
user_account_repository = UserAccountRepository.new
user_account = UserAccount.new
user_account.email_address = 'user99@gmail.com'
user_account.username = 'username99'
user_account_repository.create(user_account)

# 4
# deletes a record from the database, selected by id
user_account_repository = UserAccountRepository.new
user_account_repository.delete(1)
user_accounts = user_account_repository.all
user_accounts.length # => 1
user_accounts.first.id # => 2
user_accounts.first.email_address # => 'user2@gmail.com'
user_accounts.first.username # => 'username2'
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