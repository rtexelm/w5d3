PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes, replies, question_follows, questions, users;

CREATE TABLE users
(
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions
(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL

  FOREIGN KEY (author_id) REFERENCES users (id)
);

CREATE TABLE question_follows
(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL

  FOREIGN KEY (question_id) REFERENCES questions (id)
  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE replies
(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  question_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions (id)
  FOREIGN KEY (question_reply_id) REFERENCES replies (id)
  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE question_likes
(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL

  FOREIGN KEY (question_id) REFERENCES questions (id)
  FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO users (fname, lname)
VALUES 
('Barry', 'Gold'),
('Tom', 'Lee'),
('Steven', 'Ralph'),
('Bob', 'Tree'),
;

INSERT INTO questions (title, body, author_id)
VALUES
('I like Dogs', 'Dogs are very cool', (SELECT id FROM users WHERE fname = 'Barry' AND lname = 'Gold'))
('I like lizards', 'Lizards are very cool!', (SELECT id FROM users WHERE fname = 'Tom' AND lname = 'Lee'))
('White T-Shirts', 'Where do I get good T-Shirts?', (SELECT id FROM users WHERE fname = 'Steven' AND lname = 'Ralph'))
('Coffee', 'Who needs coffee?', (SELECT id FROM users WHERE fname = 'Bob' AND lname = 'Tree'))

INSERT INTO question_follows (question_id, user_id)
VALUES
((SELECT id FROM questions WHERE title = 'I like lizards'),(SELECT id FROM users WHERE fname = 'Barry' AND lname = 'Gold'))
((SELECT id FROM questions WHERE title = 'Coffee'),(SELECT id FROM users WHERE fname = 'Steven' AND lname = 'Ralph'))
