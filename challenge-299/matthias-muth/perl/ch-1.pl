#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 299 Task 1: Replace Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub replace_words( $words, $sentence ) {
    $sentence =~ s/\b$_[a-z]+/$_/g
	for $words->@*;
    return $sentence;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is replace_words( ["cat", "bat", "rat"], "the cattle was rattle by the battery" ), "the cat was rat by the bat",
    'Example 1: replace_words( ["cat", "bat", "rat"], "the cattle was rattle by the battery" ) == "the cat was rat by the bat"';
is replace_words( ["a", "b", "c"], "aab aac and cac bab" ), "a a a c b",
    'Example 2: replace_words( ["a", "b", "c"], "aab aac and cac bab" ) == "a a a c b"';
is replace_words( ["man", "bike"], "the manager was hit by a biker" ), "the man was hit by a bike",
    'Example 3: replace_words( ["man", "bike"], "the manager was hit by a biker" ) == "the man was hit by a bike"';

done_testing;
