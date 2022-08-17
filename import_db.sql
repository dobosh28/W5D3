PRAGMA foreign_keys = ON;


DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;


CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
    -- id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    -- account for asker and follower
    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    subject_q INTEGER NOT NULL,
    parent_reply INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (subject_q) REFERENCES questions(id)
    FOREIGN KEY (parent_reply) REFERENCES replies(id)
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    subject_q INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (subject_q) REFERENCES questions(id)
);

INSERT INTO 
    users (fname, lname)
VALUES
    ('Yosyp', 'Dobosh'),
    ('Kat', 'Smith');

INSERT INTO
    questions (title, body, user_id)
VALUES
    ('What''s a join table?', 'I don''t know anything about join tables! SOS! Please help!', (SELECT id FROM users WHERE fname = 'Kat')),
    ('Help needed! What is Big O?', 'Can someone please explain Big O to be before I go crazy?!', (SELECT id FROM users WHERE fname = 'Yosyp'));

INSERT INTO
    
