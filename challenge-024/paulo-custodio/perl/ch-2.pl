#!/usr/bin/perl

# Challenge 019
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

# Solution: store the inverted index in a SQLite database, use DBI to access it

use strict;
use warnings;
use 5.030;
use Path::Tiny;
use DBI;
use DBD::SQLite;
use Path::Tiny;
use constant DBFILE => "index.db3";

# Create database if index does not exist
BEGIN {
    if (! -f DBFILE) {
        open(my $p, "| sqlite3 ".DBFILE) or die "cannot start sqlite3";
        say $p <<END;
CREATE TABLE words (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    word        TEXT UNIQUE
);
CREATE TABLE documents (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    title       TEXT UNIQUE
);
CREATE TABLE found (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    document_id INTEGER,
    word_id     INTEGER
);
END
        close($p) or die "sqlite3 failed";
    }
};

# main
my($op, @args) = @ARGV;
if (@ARGV>=2 && $op =~ /^add/i) {
    add_doc($_) for @args;
}
elsif (@ARGV>=2 && $op =~ /^sea/) {
    search($_) for @args;
}
else {
    die "Usage: add documents | search words\n";
}


# add words from document to index
sub add_doc {
    my($doc) = @_;

    # get title
    my $title = path($doc)->basename;

    # connect to index database
    my $dbh = DBI->connect("dbi:SQLite:dbname=".DBFILE,"","",
                           { RaiseError => 1, AutoCommit => 1 });

    # get document id
    my $document_id = get_document_id($dbh, $title);

    # read document
    my $word_count = 0;
    my $text = path($doc)->slurp;
    while ($text =~ /(\w+)/g) {
        my $word = lc($1);
        my $word_id = get_word_id($dbh, $word);
        add_found($dbh, $document_id, $word_id);
        $word_count++;
    }

    say "Indexed $title: found $word_count words";

    # disconnect from database
    $dbh->disconnect();
}

# get or add value to table
sub get_or_add_id {
    my($dbh, $table, $column, $value) = @_;

    for (1..2) {
        # search document in db
        my $sth = $dbh->prepare("SELECT id FROM $table WHERE $column = ?");
        $sth->execute($value);
        my($id) = $sth->fetchrow();
        $sth->finish();

        return $id if defined $id;

        # add value if not found
        $sth = $dbh->prepare("INSERT INTO $table($column) VALUES(?)");
        $sth->execute($value);
        $sth->finish();
    }

    die "failed to insert $column to $table value '$value'";
}

# get or add document id
sub get_document_id {
    my($dbh, $title) = @_;
    return get_or_add_id($dbh, "documents", "title", $title);
}

# get or add word id
sub get_word_id {
    my($dbh, $word) = @_;
    return get_or_add_id($dbh, "words", "word", $word);
}

# add a found location if not already found
sub add_found {
    my($dbh, $document_id, $word_id) = @_;

    # search location in db
    my $sth = $dbh->prepare("
        SELECT id FROM found
        WHERE document_id = ?
          AND word_id     = ?");
    $sth->execute($document_id, $word_id);
    my($id) = $sth->fetchrow();
    $sth->finish();

    return if defined($id);

    # location not found, insert in db
    $sth = $dbh->prepare("INSERT INTO found (document_id, word_id)
                          VALUES(?,?)");
    $sth->execute($document_id, $word_id);
    $sth->finish();
}

# search word
sub search {
    my($word) = @_;

    # connect to index database
    my $dbh = DBI->connect("dbi:SQLite:dbname=".DBFILE,"","",
                           { RaiseError => 1, AutoCommit => 1 });

    # search locations of each word
    my $sth = $dbh->prepare("
        SELECT word, title
        FROM documents, words, found
        WHERE word = ?
          AND found.document_id = documents.id
          AND found.word_id     = words.id
        ORDER BY title");

    $sth->execute($word);

    while (my($word, $title) = $sth->fetchrow()) {
        say "$word  $title";
    }

    $sth->finish();

    # disconnect from database
    $dbh->disconnect();
}
