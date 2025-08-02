#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 311 Task 1: Upper Lower
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub upper_lower( $str ) {
    return $str =~ s{ ([a-z]) | [A-Z] }{ $1 ? uc( $& ) : lc( $& ) }xegr;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is upper_lower( "pERl" ), "PerL",
    'Example 1: upper_lower( "pERl" ) == "PerL"';
is upper_lower( "rakU" ), "RAKu",
    'Example 2: upper_lower( "rakU" ) == "RAKu"';
is upper_lower( "PyThOn" ), "pYtHoN",
    'Example 3: upper_lower( "PyThOn" ) == "pYtHoN"';

done_testing;
