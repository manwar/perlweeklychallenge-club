#!/usr/bin/env python3
"""Challenge 024 - Task 2: Inverted index full-text search.

Build a tiny inverted-index database backed by SQLite. The script supports:

- add <documents...>    index one or more documents
- search <terms...>     print matching document titles for each term

Each word is stored in lowercase and matched exactly.
"""

from __future__ import annotations

import re
import sqlite3
import sys
from pathlib import Path

DBFILE = "index.db3"
WORD_RE = re.compile(r"\w+")


def ensure_database() -> None:
    """Create the SQLite database schema if it does not already exist."""
    with sqlite3.connect(DBFILE) as con:
        con.executescript(
            """
            CREATE TABLE IF NOT EXISTS words (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                word TEXT UNIQUE NOT NULL
            );

            CREATE TABLE IF NOT EXISTS documents (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT UNIQUE NOT NULL
            );

            CREATE TABLE IF NOT EXISTS found (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                document_id INTEGER NOT NULL,
                word_id INTEGER NOT NULL,
                UNIQUE(document_id, word_id)
            );
            """
        )


def get_document_id(con: sqlite3.Connection, title: str) -> int:
    """Return the document id for title, inserting it if needed."""
    cur = con.execute("SELECT id FROM documents WHERE title = ?", (title,))
    row = cur.fetchone()
    if row is not None:
        return int(row[0])

    con.execute("INSERT INTO documents(title) VALUES(?)", (title,))
    return int(con.execute("SELECT last_insert_rowid()").fetchone()[0])


def get_word_id(con: sqlite3.Connection, word: str) -> int:
    """Return the word id for word, inserting it if needed."""
    cur = con.execute("SELECT id FROM words WHERE word = ?", (word,))
    row = cur.fetchone()
    if row is not None:
        return int(row[0])

    con.execute("INSERT INTO words(word) VALUES(?)", (word,))
    return int(con.execute("SELECT last_insert_rowid()").fetchone()[0])


def add_document(path: str) -> None:
    """Index a document into the database."""
    title = Path(path).stem
    with sqlite3.connect(DBFILE) as con:
        doc_id = get_document_id(con, title)

        with open(path, encoding="utf-8") as fh:
            for line in fh:
                for word in WORD_RE.findall(line.lower()):
                    word_id = get_word_id(con, word)
                    con.execute(
                        "INSERT OR IGNORE INTO found(document_id, word_id) VALUES(?, ?)",
                        (doc_id, word_id),
                    )

        con.commit()
        print(f"Indexed {title}")


def search(term: str) -> None:
    """Print documents containing a search term."""
    term = term.lower()
    with sqlite3.connect(DBFILE) as con:
        for row in con.execute(
            """
            SELECT words.word, documents.title
            FROM documents
            JOIN found ON found.document_id = documents.id
            JOIN words ON words.id = found.word_id
            WHERE words.word = ?
            ORDER BY documents.title
            """,
            (term,),
        ):
            print(f"{row[0]}  {row[1]}")


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    ensure_database()

    if len(argv) < 2:
        print("Usage: add documents... | search terms...")
        return 1

    command = argv[1]
    args = argv[2:]

    if command == "add":
        if not args:
            print("Usage: add documents...")
            return 1
        for filename in args:
            add_document(filename)
        return 0

    if command == "search":
        if not args:
            print("Usage: search terms...")
            return 1
        for term in args:
            search(term)
        return 0

    print("Usage: add documents... | search terms...")
    return 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
