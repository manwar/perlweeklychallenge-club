#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 386 Task 1: Reverse Base
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Math::Prime::Util qw( fromdigits );

sub reverse_base( $num, $base ) {
    if ( 0 < $base <= 36 ) {
        # For bases up to 36, we can let 'fromdigits' with a
        # string parameter handle everything.
        return fromdigits( $num, $base );
    }
    elsif ( $base <= 64 ) {
        # For bases up to 64, 'fromdigits' with an array of
        # digit values returns the result.
        # The digit values are obtained using a hash lookup.
        my @digits = ( 0..9, "A".."Z", "a".."z", "+", "/" );
        my %digit_values = map { ( $digits[$_] => $_ ) } keys @digits;
        my @num_digits = map $digit_values{$_}, split "", $num;
        return fromdigits( \@num_digits, $base );
    }
    else {
        return undef;
    }
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["101010", 2], 42 ],
    [ "Example 2", ["EEADEE", 16], 15642094 ],
    [ "Example 3", ["755", 8], 493 ],
    [ "Example 4", ["1BRJB", 36], 2228519 ],
    [ "Example 5", ["7MyqL", 64], 123456789 ],
);

is reverse_base( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;
done_testing;
