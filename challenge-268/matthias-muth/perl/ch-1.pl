#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 268 Task 1: Magic Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( all zip min );

sub magic_number_short( $x, $y ) {
    return min( $y->@* ) - min( $x->@* );
}

sub magic_number( $x, $y ) {
    @$x && ( @$x == @$y )
        or return undef;
    my @diffs = map $_->[1] - $_->[0],
        zip [ sort { $a <=> $b } $x->@* ],
            [ sort { $a <=> $b } $y->@* ];
    return
        ( all { $_ == $diffs[0] } @diffs[1..$#diffs] )
        ? $diffs[0]
        : undef;
}

use Test2::V0 qw( -no_srand );
is magic_number( [], [] ), undef,
    'Test 1: magic_number( [], [] ) == undef';
is magic_number( [3, 7, 5], [9, 5, 7] ), 2,
    'Example 1: magic_number( [3, 7, 5], [9, 5, 7] ) == 2';
is magic_number( [1, 2, 1], [5, 4, 4] ), 3,
    'Example 2: magic_number( [1, 2, 1], [5, 4, 4] ) == 3';
is magic_number( [2], [5] ), 3,
    'Example 3: magic_number( [2], [5] ) == 3';
done_testing;
