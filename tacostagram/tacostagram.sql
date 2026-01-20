-- Drops existing tables, so we start fresh with each
-- run of this script
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS follows;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

-- USERS
-- A user has a username (unique), real name, and location
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username  TEXT,
  real_name TEXT,
  location  TEXT
);

-- POSTS
-- One user can have many posts; each post belongs to exactly one user
CREATE TABLE posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  photo_filename TEXT,  -- store the filename/path of the photo
  caption TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- LIKES
-- A user can like many posts; a post can be liked by many users
-- Use a composite primary key to prevent the same user from liking the same post twice
CREATE TABLE likes (
  user_id INTEGER,
  post_id INTEGER,
  PRIMARY KEY (user_id, post_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- COMMENTS
-- A user can leave many comments; a post can have many comments
CREATE TABLE comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  post_id INTEGER,
  body TEXT,            -- comment text
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- FOLLOWS
-- Users can follow other users (many-to-many self-referential relationship)
-- Composite primary key prevents duplicate follows; CHECK prevents self-follow
CREATE TABLE follows (
  follower_id INTEGER,
  followee_id INTEGER,
  PRIMARY KEY (follower_id, followee_id),
  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (followee_id) REFERENCES users(id)
);