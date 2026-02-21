-- Blog Website Database Schema
-- Run this to set up your local database

-- Users table (for admin login)
CREATE TABLE IF NOT EXISTS users (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  name       TEXT NOT NULL,
  email      TEXT UNIQUE NOT NULL,
  password   TEXT NOT NULL,
  role       TEXT DEFAULT 'admin',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Posts table
CREATE TABLE IF NOT EXISTS posts (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  title       TEXT NOT NULL,
  slug        TEXT UNIQUE NOT NULL,
  excerpt     TEXT,
  content     TEXT NOT NULL,
  cover_image TEXT,
  author_id   INTEGER REFERENCES users(id),
  status      TEXT DEFAULT 'draft',  -- draft | published
  published_at DATETIME,
  created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tags table
CREATE TABLE IF NOT EXISTS tags (
  id   INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  slug TEXT UNIQUE NOT NULL
);

-- Post <-> Tags (many to many)
CREATE TABLE IF NOT EXISTS post_tags (
  post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
  tag_id  INTEGER REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (post_id, tag_id)
);

-- Comments table
CREATE TABLE IF NOT EXISTS comments (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id    INTEGER REFERENCES posts(id) ON DELETE CASCADE,
  name       TEXT NOT NULL,
  email      TEXT NOT NULL,
  body       TEXT NOT NULL,
  approved   INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
