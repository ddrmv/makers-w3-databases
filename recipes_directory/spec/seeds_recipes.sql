TRUNCATE TABLE recipes RESTART IDENTITY;

INSERT INTO recipes (name, cooking_time, rating)
  VALUES('test meal 1', 15, 3);
INSERT INTO recipes (name, cooking_time, rating)
  VALUES('test meal 2', 20, 4);