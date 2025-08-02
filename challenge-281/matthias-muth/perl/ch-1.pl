#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 281 Task 1: Check Color
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub check_color( $coordinates ) {
    return sum( map ord, split "", $coordinates ) % 2;
}

use Test2::V0 qw( -no_srand );
ok check_color( "d3" ),
    'Example 1: check_color( "d3" ) is true';
ok ! check_color( "g5" ),
    'Example 2: check_color( "g5" ) is false';
ok check_color( "e6" ),
    'Example 3: check_color( "e6" ) is true';
done_testing;
