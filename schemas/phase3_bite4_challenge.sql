-- Create the first table.
CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  release_date date
);

-- Create the second table.
CREATE TABLE cinemas (
  id SERIAL PRIMARY KEY,
  city_name text
);

-- Create the join table.
CREATE TABLE movies_cinemas (
  movie_id int,
  cinema_id int,
  constraint fk_movie_68342523523 foreign key(movie_id) references movies(id) on delete cascade,
  constraint fk_cinema_24235423136 foreign key(cinema_id) references cinemas(id) on delete cascade,
  PRIMARY KEY (movie_id, cinema_id)
);