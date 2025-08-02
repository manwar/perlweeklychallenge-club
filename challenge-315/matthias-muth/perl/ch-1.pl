#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 315 Task 1: Find Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub find_words( $list, $char ) {
    return grep $list->[$_] =~ /$char/, keys $list->@*;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ find_words( ["the", "weekly", "challenge"], "e" ) ], [ 0, 1, 2 ],
    'Example 1: find_words( ["the", "weekly", "challenge"], "e" ) == (0, 1, 2)';
is [ find_words( ["perl", "raku", "python"], "p" ) ], [ 0, 2 ],
    'Example 2: find_words( ["perl", "raku", "python"], "p" ) == (0, 2)';
is [ find_words( ["abc", "def", "bbb", "bcd"], "b" ) ], [ 0, 2, 3 ],
    'Example 3: find_words( ["abc", "def", "bbb", "bcd"], "b" ) == (0, 2, 3)';

done_testing;
