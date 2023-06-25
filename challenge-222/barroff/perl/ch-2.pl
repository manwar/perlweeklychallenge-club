#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

use List::Util qw( uniq );

sub matching_members (@numbers) {
    my @sorted_numbers = sort(@numbers);
    scalar grep( { $sorted_numbers[$_] == $numbers[$_] } 0 .. @numbers - 1 );
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 3;

    is matching_members( 1, 1, 4, 2, 1, 2 ), 3, 'works for (1, 1, 4, 2, 1, 2)';
    is matching_members( 5, 1, 2, 3, 4 ), 0, 'works for (5, 1, 2, 3, 4)';
    is matching_members( 1, 2, 3, 4, 5 ), 5, 'works for (1, 2, 3, 4, 5)';
}

MAIN();
