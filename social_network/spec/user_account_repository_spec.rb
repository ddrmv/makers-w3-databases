require 'user_account_repository'

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe UserAccountRepository do
  before(:each) do
    reset_user_accounts_table
  end

  describe "#all" do
    it "gets all user accounts" do
      user_account_repository = UserAccountRepository.new
      user_accounts = user_account_repository.all
      expect(user_accounts.length).to eq(2)
      expect(user_accounts.first.id).to eq(1)
      expect(user_accounts.first.email_address).to eq('user1@gmail.com')
      expect(user_accounts.first.username).to eq('username1')
      expect(user_accounts[1].id).to eq(2)
      expect(user_accounts[1].email_address).to eq('user2@gmail.com')
      expect(user_accounts[1].username).to eq('username2')
    end
  end

  describe "#find(id)" do
    it "gets a single user account" do
      user_account_repository = UserAccountRepository.new
      user_account = user_account_repository.find(2)
      expect(user_account.id).to eq(2)
      expect(user_account.email_address).to eq('user2@gmail.com')
      expect(user_account.username).to eq('username2')
    end
  end

  describe "#create" do
    it "creates a record from UserAccount object" do
      user_account_repository = UserAccountRepository.new
      user_account = UserAccount.new
      user_account.email_address = 'user99@gmail.com'
      user_account.username = 'username99'
      user_account_repository.create(user_account)
      user_accounts = user_account_repository.all
      expect(user_accounts.length).to eq(3)
      expect(user_accounts.last.id).to eq(3)
      expect(user_accounts.last.email_address).to eq('user99@gmail.com')
      expect(user_accounts.last.username).to eq('username99')
    end
  end

  describe "#delete" do
    it "deletes a record from the database, selected by id" do
      user_account_repository = UserAccountRepository.new
      user_account_repository.delete(1)
      user_accounts = user_account_repository.all
      expect(user_accounts.length).to eq(1)
      expect(user_accounts.first.id).to eq(2)
      expect(user_accounts.first.email_address).to eq('user2@gmail.com')
      expect(user_accounts.first.username).to eq('username2')
    end
  end
end