#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 282 Task 2: Changing Keys
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub changing_keys( $str ) {
    return scalar( () = $str =~ /(.)(?=.)(?=.)(?!\g1)/ig );
}

use Test2::V0 qw( -no_srand );
is changing_keys( "pPeERrLl" ), 3,
    'Example 1: changing_keys( "pPeERrLl" ) == 3';
is changing_keys( "rRr" ), 0,
    'Example 2: changing_keys( "rRr" ) == 0';
is changing_keys( "GoO" ), 1,
    'Example 3: changing_keys( "GoO" ) == 1';
done_testing;
