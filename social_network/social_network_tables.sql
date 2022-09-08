CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  view_number int,
  user_account_id int,
  constraint fk_user_account_298347 foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);