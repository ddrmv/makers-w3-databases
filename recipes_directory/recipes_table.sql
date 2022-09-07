CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name text,
  cooking_time int,
  rating int
);

INSERT INTO recipes (name, cooking_time, rating)
  VALUES('meal name 1', 21, 4);
INSERT INTO recipes (name, cooking_time, rating)
  VALUES('meal name 2', 22, 3);
INSERT INTO recipes (name, cooking_time, rating)
  VALUES('meal name 3', 23, 2);
INSERT INTO recipes (name, cooking_time, rating)
  VALUES('meal name 4', 24, 5);
INSERT INTO recipes (name, cooking_time, rating)
  VALUES('meal name 5', 25, 1);
INSERT INTO recipes (name, cooking_time, rating)
  VALUES('meal name 6', 26, 4);