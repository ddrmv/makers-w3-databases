--INSERT INTO tags (name) VALUES ('sql');
--SELECT id, name FROM tags WHERE name = 'sql';
--SELECT id, title FROM posts WHERE title = 'SQL basics';
--INSERT INTO posts_tags (post_id, tag_id) VALUES (7,5);
SELECT posts.id, posts.title
  FROM posts
  JOIN posts_tags ON posts.id = posts_tags.post_id
  JOIN tags ON posts_tags.tag_id = tags.id
  WHERE tags.name = 'sql';