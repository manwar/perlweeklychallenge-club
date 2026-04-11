#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 368 Task 1: Make it Bigger
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub make_it_bigger( $str, $char ) {
    $str =~ s/ $char (?! [0-${char}] ) //x
        || $str =~ s/ ${char} (?= [^${char}]* $ )//x;
    return $str;
}

use Test2::V0 qw( -no_srand );

is make_it_bigger( 15456, 5 ), 1546,
    'Example 1: make_it_bigger( 15456, 5 ) == 1546';
is make_it_bigger( 7332, 3 ), 732,
    'Example 2: make_it_bigger( 7332, 3 ) == 732';
is make_it_bigger( 2231, 2 ), 231,
    'Example 3: make_it_bigger( 2231, 2 ) == 231';
is make_it_bigger( 543251, 5 ), 54321,
    'Example 4: make_it_bigger( 543251, 5 ) == 54321';
is make_it_bigger( 1921, 1 ), 921,
    'Example 5: make_it_bigger( 1921, 1 ) == 921';

is make_it_bigger( 543215, 5 ), 54321,
    'Own Test 1: make_it_bigger( 543215, 5 ) == 54321';

done_testing;
