-- -------------------------------------------------------------
-- TablePlus 4.5.0(396)
--
-- https://tableplus.com/
--
-- Database: blog
-- Generation Time: 2022-05-11 14:52:14.0840
-- -------------------------------------------------------------


DROP TABLE IF EXISTS  "public"."posts";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
-- CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

-- Table Definition
CREATE TABLE "public"."posts" (
    "id" SERIAL PRIMARY KEY,
    "title" text
    --PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."posts_tags";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."posts_tags" (
    "post_id" int4,
    "tag_id" int4
);

DROP TABLE IF EXISTS "public"."tags";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
-- CREATE SEQUENCE IF NOT EXISTS tags_id_seq;

-- Table Definition
CREATE TABLE "public"."tags" (
    "id" SERIAL PRIMARY KEY,
    "name" text
    --PRIMARY KEY ("id")
);

TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY;

INSERT INTO "public"."posts" ("title") VALUES
('How to use Git'),
('Ruby classes'),
('Using IRB'),
('My weekend in Edinburgh'),
('The best chocolate cake EVER'),
('A foodie week in Spain'),
('SQL basics');

INSERT INTO "public"."posts_tags" ("post_id", "tag_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4);

INSERT INTO "public"."tags" ("name") VALUES
('coding'),
('travel'),
('cooking'),
('ruby');

ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id");
ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id");