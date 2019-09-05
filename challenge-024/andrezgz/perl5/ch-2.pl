#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-024/
# Task #2
# Create a script to implement full text search functionality using Inverted Index. According to wikipedia:
# In computer science, an inverted index (also referred to as a postings file or inverted file)
# is a database index storing a mapping from content, such as words or numbers, to its locations in a table,
# or in a document or a set of documents (named in contrast to a forward index, which maps from documents to content).
# The purpose of an inverted index is to allow fast full-text searches, at a cost of increased processing
# when a document is added to the database.
# Here is a nice example of Inverted Index.
# https://en.wikipedia.org/wiki/Search_engine_indexing#Inverted_indices

use strict;
use warnings;

die "Usage: $0 <file1> [<fileN>]" if @ARGV == 0;

# Prepare inverted index
my %index;
while (<>) {
    chomp;                                 # remove line trailing string
    s/["'?!]/ /ig;                         # some cleaning
    my @words = grep {                     # filter words...
                    length > 2             # with 3 or more...
                    && /^[a-z\-]+$/i       # alphabetic and hyphen characters only
                }
                split /[.,; ]/;            # split line in words
    $index{lc $_}{$ARGV}++ for (@words);   # store word usage in file
}
print 'Words added: ' . join(',',sort keys %index) . "\n";

# Search word
print "\nSearch word: ";
my $w = <>;
chomp $w;
if ( exists $index{lc $w} ) {
    print "'$w' was found on ", join(',',keys $index{lc $w}) . "\n";
}
else {
    print "'$w' wasn't found on any document\n";
}
