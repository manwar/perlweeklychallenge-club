#!/usr/bin/env perl6

use Test;

is-deeply find-numbers(<0 1 2 5>, 2, 21), [10, 11, 12, 15, 20];

done-testing;

sub find-numbers(@n, $x, $y) {

    my @numbers = ();
    for @n X @n -> @x {
        my $number = ([~] @x) + 0;
        next unless $number.chars == $x && $number < $y;
        @numbers.push: $number;
    }

    return @numbers;
}
