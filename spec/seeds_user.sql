DROP TABLE IF EXISTS "public"."posts";
DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

CREATE TABLE "public"."users" (
    "id" SERIAL PRIMARY KEY,
    "email" text,
    "username" text
);

TRUNCATE TABLE users RESTART IDENTITY;

INSERT INTO "public"."users" ("email", "username") VALUES
('test@hotmail.com', 'first_user'),
('OtherTest@gmail.com', 'second_user'),
('finalTest@yahoo.com', 'third_user');

CREATE TABLE "posts" (
    "id" SERIAL PRIMARY KEY,
    "title" text,
    "content" text,
    "number_of_views" int,
    "user_id" int, 
    constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE "posts" RESTART IDENTITY;

INSERT INTO "posts" ("title", "content", "number_of_views", "user_id") VALUES
('Big Post', 'Isnt this cool?', 12, 1),
('Small post', 'I think pineapple is bad', 843, 2),
('Medium post', 'The weather is horrible', 10 , 3);





