#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-024/
#               
#
#    Create a script to implement full text search functionality using Inverted Index. According to wikipedia:
#
#        In computer science, an inverted index (also referred to as a postings file or inverted file) is a database index storing a mapping from content, such as words or numbers, to its locations in a table, or in a document or a set of documents (named in contrast to a forward index, which maps from documents to content). The purpose of an inverted index is to allow fast full-text searches, at a cost of increased processing when a document is added to the database.
#
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 09/08/2019 12:32:53 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Carp;
use Data::Dumper;

my @files = glob "*";

my %words;

for my $file (@files) {
    open my $what, '<', $file or croak "Cannot open $file $!";
    while (my $line = <$what>) {
        for (split /\s+/msx, $line) {
            s/\W//gmsx;
            $words{lc($_)}{$file} = 1;
        }
    }
    close $what;
}

warn Dumper \%words;

# ------ TESTS -----------

use Test::More;

is ($words{'using'}{'ch-2.pl'}, 1);
is ($words{'using'}{'ch-1.pl'}, undef);

done_testing;


