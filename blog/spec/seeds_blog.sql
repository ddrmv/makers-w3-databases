-- CREATE TABLE posts (
--   id SERIAL PRIMARY KEY,
--   title text,
--   content text
-- );

-- CREATE TABLE comments (
--   id SERIAL PRIMARY KEY,
--   author_name text,
--   content text,
--   post_id int,
--   constraint fk_post_121212 foreign key (post_id)
--     references posts(id)
--     on delete cascade
-- );

TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content)
  VALUES ('first post title', 'Hello, world!');
INSERT INTO posts (title, content)
  VALUES ('second post title', 'Hello again, world!');

INSERT INTO comments (author_name, content, post_id)
  VALUES ('anonymous', 'Awesome!', 1);
INSERT INTO comments (author_name, content, post_id)
  VALUES ('sadsfd', 'crop', 2);
INSERT INTO comments (author_name, content, post_id)
  VALUES ('sadddd', 'lalala', 2);