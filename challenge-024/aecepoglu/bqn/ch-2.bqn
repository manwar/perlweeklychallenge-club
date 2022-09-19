# Task 2
d←(⊢+32×1="A["⊸⍋)"In computer science, an inverted index (also referred to as a postings file or inverted file) is a database index storing a mapping from content, such as words or numbers, to its locations in a table, or in a document or a set of documents (named in contrast to a forward index, which maps from documents to content). The purpose of an inverted index is to allow fast full-text searches, at a cost of increased processing when a document is added to the database."
a←'a'+↕'z'-'a'                  # lowercase letters
w←∊⊸/a((¬-˜⊢×·+`»⊸>)∘(∨˝=⌜)⊔⊢)d # words in text
w(>⊣⋈¨(/∘⍷)⌜)⋈d
