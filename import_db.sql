PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Arnob', 'Dam'),
    ('Cath', 'Anderson'),
    ('Amin', 'Babar');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Basic SQL Commands', 'Which command should I use to create a table?', (SELECT id FROM users WHERE fname = 'Cath')),
    ('Insert SQL Command', 'How do I insert something into a table?', (SELECT id FROM users WHERE fname = 'Arnob'));

INSERT INTO
    question_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Cath'), (SELECT id FROM questions WHERE title = 'Basic SQL Commands')),
    ((SELECT id FROM users WHERE fname = 'Arnob'), (SELECT id FROM questions WHERE title = 'Insert SQL Command'));

INSERT INTO
    replies (body, user_id, question_id, parent_reply_id)
VALUES
    ('Hi Cath, you should use CREATE TABLE :) (insert Amin''s voice here)', (SELECT id FROM users WHERE fname = 'Amin'), (SELECT id FROM questions WHERE title = 'Basic SQL Commands'), NULL),
    ('Hi Arnob, you should use INSERT INTO :D (insert Amin''s voice here)', (SELECT id FROM users WHERE fname = 'Amin'), (SELECT id FROM questions WHERE title = 'Insert SQL Command'), NULL),
    ('Thank you!', (SELECT id FROM users WHERE fname = 'Cath'), (SELECT id FROM questions WHERE title = 'Basic SQL Commands'), (SELECT id FROM replies WHERE body = 'Hi Cath, you should use CREATE TABLE :) (insert Amin''s voice here)'));

INSERT INTO 
    question_likes (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Cath'), (SELECT id FROM questions WHERE title = 'Insert SQL Command'));

