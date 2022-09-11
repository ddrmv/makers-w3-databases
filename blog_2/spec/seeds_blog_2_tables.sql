DROP TABLE IF EXISTS posts, tags, posts_tags;

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name text
);

CREATE TABLE posts_tags (
  post_id int,
  tag_id int,
  constraint fk_post_12614234253 foreign key(post_id) references posts(id) on delete cascade,
  constraint fk_tag_23452394853 foreign key(tag_id) references tags(id) on delete cascade,
  PRIMARY KEY (post_id, tag_id)
);

-- TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY;

INSERT INTO posts (title) VALUES
('How to use Git'),
('Ruby classes'),
('Using IRB'),
('My weekend in Edinburgh'),
('The best chocolate cake EVER'),
('A foodie week in Spain'),
('SQL basics');

INSERT INTO tags (name) VALUES
('coding'),
('travel'),
('cooking'),
('ruby'),
('sql');

INSERT INTO posts_tags (post_id, tag_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4),
(7, 5);