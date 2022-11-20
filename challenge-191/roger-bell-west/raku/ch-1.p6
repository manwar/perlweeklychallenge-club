#! /usr/bin/perl6

use Test;

plan 4;

is(twicelargest([1, 2, 3, 4]), False, 'example 1');
is(twicelargest([1, 2, 0, 5]), True, 'example 2');
is(twicelargest([2, 6, 3, 1]), True, 'example 3');
is(twicelargest([4, 5, 2, 3]), False, 'example 4');

sub twicelargest(@l0) {
    my @l = @l0.sort;
    return @l[*-1] >= 2*@l[*-2];
}
