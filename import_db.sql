PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS users;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    -- account for asker and follower
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    subject_q INTEGER NOT NULL,
    parent_reply INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (subject_q) REFERENCES questions(id),
    FOREIGN KEY (parent_reply) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    subject_q INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
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
    question_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Kat'), (SELECT id FROM questions WHERE title LIKE '%join table%')),
    ((SELECT id FROM users WHERE fname = 'Yosyp'), (SELECT id FROM questions WHERE title LIKE '%Big O%'));

INSERT INTO
    replies (subject_q, parent_reply, user_id, body)
VALUES
    ((SELECT id FROM questions WHERE title LIKE '%join table%'), NULL, (SELECT id FROM users WHERE lname = 'Dobosh'), 'hi kat, great question! join tables is a SQL function that joins multiple tables of data. hope that helps'),
    ((SELECT id FROM questions WHERE title LIKE '%join table%'), (SELECT id FROM replies WHERE body LIKE '%hope that helps%'), (SELECT id FROM users WHERE lname = 'Smith'), 'thanks, you''re super');

INSERT INTO
    question_likes (user_id, subject_q)
VALUES
   ((SELECT id FROM users WHERE lname = 'Dobosh'), (SELECT id FROM questions WHERE title LIKE '%join table%'));