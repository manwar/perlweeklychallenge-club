#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 356 Task 1: Kolakoski Sequence
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub kolakoski_sequence( $n ) {
    my @k = ();
    for ( 0 .. $n - 1 ) {
        my $next = 3 - ( $k[-1] // 2 );
        push @k, ( $next ) x ( $k[$_] // $next );
        return @k == $n ? @k : @k[0..$n - 1]
            if @k >= $n;
    }
}

sub kolakoski_ones( $int ) {
    return scalar grep $_ == 1, kolakoski_sequence( $int );
}

use Test2::V0 qw( -no_srand );


is kolakoski_ones( 4 ), 2,
    'Example 1: kolakoski_ones( 4 ) == 2';
is kolakoski_ones( 5 ), 3,
    'Example 2: kolakoski_ones( 5 ) == 3';
is kolakoski_ones( 6 ), 3,
    'Example 3: kolakoski_ones( 6 ) == 3';
is kolakoski_ones( 7 ), 4,
    'Example 4: kolakoski_ones( 7 ) == 4';
is kolakoski_ones( 8 ), 4,
    'Example 5: kolakoski_ones( 8 ) == 4';

done_testing;
