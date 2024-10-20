#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 291 Task 2: Poker Hand Rankings
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( reduce sum pairkeys );

sub factorial( $n ) { return reduce { $a * $b } 1..$n; }

sub n_choose_k( $n, $k ) {
    return
        ( reduce { $a *= $b } ( $n - $k + 1 ) .. $n )
        / ( reduce { $a *= $b } 1..$k );
}

my @combinations = (
    "Five of a kind" => 0,
    "Straight flush" => 4 * ( 13 - 4 + 1 ),
    "Four of a kind" => 13 * ( 52 - 4 ),
    "Full house" =>
        ( 52 * 3 * 2 ) / factorial( 3 ) * ( ( 52 - 4 ) * 3 ) / factorial( 2 ),
    "Flush" =>
        4 * n_choose_k( 13, 5 ) - ( 13 - 4 + 1 ) * 4,
    "Straight" =>
        ( 13 - 4 + 1 )
        * 4 * 4 * 4 * 4 * 4
            - ( 13 - 4 + 1 ) * 4,
    "Three of a kind" =>
        52 * 3 * 2 / factorial( 3 )
            * ( 52 - 4 ) * ( 52 -8 ) / factorial( 2 ),
    "Two pair" =>
        52 * 3 / factorial( 2 )
            * ( 52 - 4 ) * 3 / factorial( 2 )
            / factorial( 2 )
            * ( 52 - 8 ),
    "One pair" =>
        52 * 3 / factorial( 2 )
            * ( 52 - 4 ) * ( 52 - 8 ) * ( 52 - 12 )
            / factorial( 3 ),
    "High card" =>
        52 * (52 - 4 ) * (52 - 8 ) * (52 - 12 ) * (52 - 16 )
            / factorial( 5 ),
);

my %combinations = ( @combinations );
my @hand_types = pairkeys @combinations;

$combinations{"High card"} -=
    ( $combinations{"Straight flush"}
        + $combinations{"Flush"}
        + $combinations{"Straight"} );

$combinations{"Total"} = sum values %combinations;

sub poker_hand_rankings( $hand ) {
    return $combinations{$hand};
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

=for unit tests
note "\nUnit tests:\n\n";
is factorial( 3 ), 6, "factorial( 3 ) == 6";
is factorial( 3 ), 6, "factorial( 3 ) == 6";
is n_choose_k( 10, 3 ), 120, "n_choose_k( 10, 3 ) == 120";
is n_choose_k( 52, 5 ), 2598960, "n_choose_k( 52, 5 ) == 2598960";
note "\n";
note "\nTests:\n\n";
=cut

my %expected = (
    "Five of a kind"  => 0,
    "Straight flush"  => 40,
    "Four of a kind"  => 624,
    "Full house"      => 3744,
    "Flush"           => 5108,
    "Straight"        => 10200,
    "Three of a kind" => 54912,
    "Two pair"        => 123552,
    "One pair"        => 1098240,
    "High card"       => 1302540,
    "Total"           => 2598960,
);

is $combinations{$_}, $expected{$_},
    "$expected{$_} combinations for '$_'"
    for @hand_types, "Total";

done_testing;
