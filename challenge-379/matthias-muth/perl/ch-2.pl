#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 379 Task 2: Armstrong Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );
use Math::Prime::Util qw( todigits );

sub armstrong_number_math_prime_util( $base, $limit ) {
    my @results;
    for ( 0..$limit ) {
        my @digits = $_ == 0 ? ( 0 ) : todigits( $_, $base ); 
        push @results, $_
            if sum( map $_ ** scalar @digits, @digits ) == $_;
    }
    return @results;
}

sub armstrong_number( $base, $limit ) {
    my @results;
    my @powers = my @digits = ( 0 );
    for my $n ( 0..$limit ) {
        push @results, $n
            if sum( @powers ) == $n;

        # Increment digits and powers,
        # starting with the least significant digit.
        my $pos = 0;
        while ( ++$digits[$pos] == $base ) {
            $digits[$pos] = $powers[$pos] = 0;
            ++$pos;
        }
        $powers[$pos] = $digits[$pos] ** scalar @digits;
    }
    return @results;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [10, 1000], [0 .. 9, 153, 370, 371, 407] ],
    [ "Example 2", [7, 1000], [0 .. 6, 10, 25, 32, 45, 133, 134, 152, 250] ],
    [ "Example 3", [16, 1000], [0 .. 15, 342, 371, 520, 584, 645] ],
);

is [ armstrong_number( $_->[1]->@* ) ], $_->[2], $_->[0]
    for @tests;
done_testing;
