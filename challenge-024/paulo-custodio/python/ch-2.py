#!/usr/bin/python3

# Challenge 024
#
# Task #2
# Create a script to implement full text search functionality using Inverted
# Index. According to wikipedia:
#
# In computer science, an inverted index (also referred to as a postings file
# or inverted file) is a database index storing a mapping from content, such as
# words or numbers, to its locations in a table, or in a document or a set of
# documents (named in contrast to a forward index, which maps from documents to
# content). The purpose of an inverted index is to allow fast full-text
# searches, at a cost of increased processing when a document is added to the
# database.

import sys
import sqlite3
import os.path
import re

DBFILE = "index.db3"

# Create database if it does not exist
def create_database():
    if not os.path.isfile(DBFILE):
        con = sqlite3.connect(DBFILE)
        cur = con.cursor()

        # Create tables
        cur.execute('''
            CREATE TABLE words (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                word        TEXT UNIQUE
            );
            ''')
        cur.execute('''
            CREATE TABLE documents (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                title       TEXT UNIQUE
            );
            ''')
        cur.execute('''
            CREATE TABLE found (
                id          INTEGER PRIMARY KEY AUTOINCREMENT,
                document_id INTEGER,
                word_id     INTEGER
            );
            ''')
        cur.execute('''
            CREATE UNIQUE INDEX found_index ON found(document_id, word_id);
            ''')

        con.commit()
        con.close()

# get or add value to table
def get_or_add_id(con, table, column, value):
    cur = con.cursor()
    for i in range(2):      # lookup, insert, lookup again
        # lookup
        for id, in cur.execute(f"SELECT id FROM {table} WHERE {column} = ?", \
                              (value,)):
            return id

        # insert
        cur.execute(f"INSERT INTO {table}({column}) VALUES(?)", (value,))
        con.commit()
    return None # not reached

# get or add document id
def get_document_id(con, title):
    return get_or_add_id(con, "documents", "title", title)

# get or add word id
def get_word_id(con, word):
    return get_or_add_id(con, "words", "word", word)

# add a found location if not already found
def add_found(con, document_id, word_id):
    cur = con.cursor()
    for id, in cur.execute("""
                    SELECT id FROM found
                    WHERE document_id = ?
                      AND word_id     = ?
                """, (document_id,word_id)):
        return  # found

    # location not found, insert in db
    cur.execute("""
                INSERT INTO found (document_id, word_id)
                          VALUES(?,?)
                """, (document_id,word_id))
    con.commit()

# add words from document to index
def add_doc(file):
    con = sqlite3.connect(DBFILE)

    title = re.sub(r"\.\w+$", "", os.path.basename(file))
    document_id = get_document_id(con, title)

    # read document
    word_count = 0
    with open(file) as f:
        for line in f.readlines():
            for word in re.findall(r"\w+", line):
                word = word.lower()
                word_id = get_word_id(con, word)
                add_found(con, document_id, word_id)
                word_count += 1
    print(f"Indexed {title}")

# search word
def search(find_word):
    con = sqlite3.connect(DBFILE)
    cur = con.cursor()
    for word, title in cur.execute("""
                        SELECT word, title
                        FROM documents, words, found
                        WHERE word = ?
                          AND found.document_id = documents.id
                          AND found.word_id     = words.id
                        ORDER BY title""", (find_word,)):
        print(f"{word}  {title}")

create_database()
if sys.argv[1]=="add":
    for file in sys.argv[2:]:
        add_doc(file)
elif sys.argv[1]=="search":
    for word in sys.argv[2:]:
        search(word)
else:
    print("Usage: add documents | search words")
