#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 383 Task 2: Nearest RGB
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub nearest_rgb( $color ) {
    my @values = unpack "C3", pack "(H2)*", unpack "x(a2)*", $color;
    $_ =  int( ( $_ + int( 51 / 2 ) ) / 51 ) * 51
        for @values;
    return sprintf "#%02X%02X%02X", @values;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "#F4B2D1", "#FF99CC" ],
    [ "Example 2", "#15E6E5", "#00FFCC" ],
    [ "Example 3", "#191A65", "#003366" ],
    [ "Example 4", "#2D5A1B", "#336633" ],
    [ "Example 5", "#00FF66", "#00FF66" ],
);

is nearest_rgb( $_->[1] ), $_->[2], $_->[0]
    for @tests;
done_testing;
