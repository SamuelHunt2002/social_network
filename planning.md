As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

---

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

User: Email Adress, Username 
Post: Title, Content, Number of Views, user_id (foreign key)


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email text,
    username text,
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title text,
    content text,
    number_of_views int4,
    user_id int, 
    constraint fk_user foreign_key(user_id)
    references users(id)
    on delete cascade 
);