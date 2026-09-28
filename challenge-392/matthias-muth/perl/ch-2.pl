#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 392 Task 2: Words Length Product
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( reduce );
use Algorithm::Combinatorics qw( combinations );

sub words_length_product( @words ) {
    my @sigs = map {
        reduce { $a |= 1 << ( 26 - ( ord( $b ) & 0x1F ) ) }
            0, split "", $_;
    } @words;

    my $max = 0;
    my $iter = combinations( [ keys @words ], 2 );
    while (my $c = $iter->next) {
        my ( $i, $j ) = $c->@*;
        if ( ( $sigs[$i] & $sigs[$j] ) == 0 ) {
            my $product = length( $words[$i] ) * length( $words[$j] );
            $max = $product
                if $product > $max;
        }
    }
    return $max;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", ["a", "ab", "abc", "d", "de", "def"], 9 ],
    [ "Example 2", ["a", "aa", "aaa", "aaaa"], 0 ],
    [ "Example 3", ["meet", "app", "code", "sky", "bold"], 16 ],
    [ "Example 4", ["a", "ab", "abc", "abcd", "efghi"], 20 ],
    [ "Example 5", ["xyz", "w", "abcdefg", "hij"], 21 ],
);

is words_length_product( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
