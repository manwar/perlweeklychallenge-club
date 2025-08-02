#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 276 Task 1: Complete Day
#
#       Perl solution by Matthias Muth.
#

use v5.36;
no warnings "experimental::for_list";

sub complete_day_1( @hours ) {
    my $hits = 0;
    for my $i ( 0..$#hours ) {
        for my $j ( $i + 1 .. $#hours ) {
            ++$hits
                if ( $hours[$i] + $hours[$j] ) % 24 == 0;
        }
    }
    return $hits;
}

use Math::Combinatorics;
use List::Util qw( sum );

sub complete_day_2( @hours ) {
    return scalar grep(
        sum( $_->@* ) % 24 == 0,
        combine( 2, @hours )
    );
}

*complete_day = \&complete_day_2;

use Test2::V0 qw( -no_srand );
is complete_day( 12, 12, 30, 24, 24 ), 2,
    'Example 1: complete_day( 12, 12, 30, 24, 24 ) == 2';
is complete_day( 72, 48, 24, 5 ), 3,
    'Example 2: complete_day( 72, 48, 24, 5 ) == 3';
is complete_day( 12, 18, 24 ), 0,
    'Example 3: complete_day( 12, 18, 24 ) == 0';
done_testing;
