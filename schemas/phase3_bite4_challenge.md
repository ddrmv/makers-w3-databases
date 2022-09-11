# Two Tables (Many-to-Many) Design Recipe Template

_Copy this recipe template to design and create two related database tables having a Many-to-Many relationship._

## 1. Extract nouns from the user stories or specification

```
As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of movies with their title and release date.

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of my cinemas with their city name (e.g 'London' or 'Manchester').

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which cinemas are showing a specific movie.

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which movies are being shown a specific cinema.
```

```
Nouns:
movies           id, title, release_date
cinemas          id, city_name
movies_cinemas
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
movies            id, title, release_date
cinemas           id, city_name
movies_cinemas    movie_id, cinema_id


## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: movies
id: SERIAL
title text,
release_date date

Table: cinemas
id: SERIAL,
city_name text,

Table: movies_cinemas
movie_id, cinema_id
```

## 4. Design the Many-to-Many relationship

Many to many

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `table1_table2`.

```
movies_cinemas   movie_id, cinema_id
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: posts_tags.sql

-- Replace the table name, columm names and types.

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

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 phase3_bite4_challenge < phase3_bite4_challenge.sql
```
