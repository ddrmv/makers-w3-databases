TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username)
  VALUES ('user1@gmail.com', 'username1');
INSERT INTO user_accounts (email_address, username)
  VALUES ('user2@gmail.com', 'username2');

INSERT INTO posts (title, content, view_number, user_account_id)
  VALUES('title 1', 'content 1', 50, 1);
INSERT INTO posts (title, content, view_number, user_account_id)
  VALUES('title 2', 'content 2', 60, 2);