#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 323 Task 1: Increment Decrement
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum0 );

sub increment_decrement( @operations ) {
    return sum0( map /\Q++/ ? +1 : /--/ ? -1 : 0, @operations );
}

use Test2::V0 qw( -no_srand );

is increment_decrement( "--x", "x++", "x++" ), 1,
    'Example 1: increment_decrement( "--x", "x++", "x++" ) == 1';
is increment_decrement( "x++", "++x", "x++" ), 3,
    'Example 2: increment_decrement( "x++", "++x", "x++" ) == 3';
is increment_decrement( "x++", "++x", "--x", "x--" ), 0,
    'Example 3: increment_decrement( "x++", "++x", "--x", "x--" ) == 0';

done_testing;
