#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 292 Task 1: Twice Largest
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub twice_largest( @ints ) {
    my @sorted = sort { $b <=> $a } @ints;
    return $sorted[0] >= 2 * $sorted[1] || -1;
}

sub twice_largest_2( @ints ) {
    return -1
        unless @ints >= 2;
    my ( $largest, $second ) =
        $ints[0] > $ints[1]
        ? @ints[0,1]
        : @ints[1,0];
    for ( 2..$#ints ) {
        if ( $ints[$_] > $second ) {
            if ( $ints[$_] > $largest ) {
                ( $largest, $second ) = ( $ints[$_], $largest );
            }
            else {
                $second = $ints[$_];
            }
        }
    }
    return $largest >= 2 * $second || -1;
}


use Test2::V0; # qw( -no_srand );
use List::Util qw( shuffle );
use Data::Dump qw( pp );

is twice_largest_2( 2, 4, 1, 0 ), 1,
    'Example 1: twice_largest( 2, 4, 1, 0 ) == 1';
is twice_largest_2( 1, 2, 3, 4 ), -1,
    'Example 2: twice_largest( 1, 2, 3, 4 ) == -1';

done_testing;

use Benchmark qw( cmpthese );

for my $n_entries ( 10, 100, 1000, 10000 ) {
    my @data = shuffle( 1..$n_entries );
    cmpthese( -3, {
        "sort_$n_entries" => sub{ twice_largest( @data ) },
        "loop_$n_entries" => sub{ twice_largest_2( @data ) },
    } );
    say "";
}

exit 0;
