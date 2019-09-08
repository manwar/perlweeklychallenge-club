#!/usr/bin/env perl
#
# Create a script to implement full text search functionality using Inverted
# Index. According to wikipedia:
#
# In computer science, an inverted index (also referred to as a postings file or
# inverted file) is a database index storing a mapping from content, such as
# words or numbers, to its locations in a table, or in a document or a set of
# documents (named in contrast to a forward index, which maps from documents to
# content). The purpose of an inverted index is to allow fast full-text
# searches, at a cost of increased processing when a document is added to the
# database.
#
# Here is a nice example of Inverted Index.
#
# (https://en.wikipedia.org/wiki/Search_engine_indexing#Inverted_indices).
################################################################################

use strict;
use warnings;

use autodie;

use DBI;

my $DBFILE = 'ii.db';
my $USAGE = "Usage: $0 [--index-doc <doc_path> | --search <word>]\n";

my $opt = shift or die $USAGE;

# Connect to database
my $dbh = DBI->connect("dbi:SQLite:dbname=$DBFILE","","", { AutoCommit => 0 });

# Initialize database
$dbh->prepare('CREATE TABLE IF NOT EXISTS ii (word TEXT, docpath TEXT, PRIMARY KEY (word, docpath));')
    ->execute();
$dbh->prepare('CREATE INDEX IF NOT EXISTS word_idx ON ii (word);')
    ->execute();
$dbh->commit();

if ($opt eq '--index-doc') {
    # Index the given document
    my $doc_path = shift;
    open(my $dh, '<:encoding(UTF-8)', $doc_path);
    $/ = undef;
    my @words = map { lc($_) } <$dh> =~ /(\w+)/g;
    my $sth = $dbh->prepare("INSERT OR IGNORE INTO ii VALUES (?, \"$doc_path\");");
    $sth->execute($_) foreach @words;
    $dbh->commit();
} elsif ($opt eq '--search') {
    # Search the given word
    my $word = shift;
    my $sth = $dbh->prepare('SELECT DISTINCT docpath FROM ii WHERE word = ?');
    $sth->execute($word);
    my @files = map { $_->[0] } @{$sth->fetchall_arrayref()};
    if (@files) {
        printf "Word '$word' appears in documents: %s\n", join(', ', @files);
    } else {
        print "Word '$word' does not appear in any document\n";
    }
} else {
    die $USAGE;
}

$dbh->disconnect();
