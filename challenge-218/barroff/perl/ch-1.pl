#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

use List::Util               qw( max reduce );
use Algorithm::Combinatorics qw( combinations );

sub get_product (@numbers) {
    return reduce { $a * $b } @numbers;
}

sub maximum_product ( $k, @s ) {
    return max map( { get_product(@$_) } combinations( \@s, $k ) );
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 4;

    is maximum_product( 3, ( 3,  1, 2 ) ), 6, "works for (3, 1, 2)";
    is maximum_product( 3, ( 4,  1, 3, 2 ) ), 24, "works for (4, 1, 3, 2)";
    is maximum_product( 3, ( -1, 0, 1, 3, 1 ) ), 3,
      "works for (-1, 0, 1, 3, 1)";
    is maximum_product( 3, ( -8, 2, -9, 0, -4, 3 ) ), 216,
      "works for (-8, 2, -9, 0, -4, 3)";
}

MAIN();
