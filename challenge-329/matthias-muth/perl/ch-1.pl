#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 329 Task 1: Counter Integers
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( uniq );

sub counter_integers( $str ) {
    return uniq $str =~ /(\d+)/g;
}

use Test2::V0 qw( -no_srand );

is [ counter_integers( "the1weekly2challenge2" ) ], [ 1, 2 ],
    'Example 1: counter_integers( "the1weekly2challenge2" ) == (1, 2)';
is [ counter_integers( "go21od1lu5c7k" ) ], [ 21, 1, 5, 7 ],
    'Example 2: counter_integers( "go21od1lu5c7k" ) == (21, 1, 5, 7)';
is [ counter_integers( "4p3e2r1l" ) ], [ 4, 3, 2, 1 ],
    'Example 3: counter_integers( "4p3e2r1l" ) == (4, 3, 2, 1)';

done_testing;
