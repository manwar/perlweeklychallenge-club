#! /usr/bin/perl6

use Test;

plan 5;

is(divisiblepairs([4, 5, 1, 6], 2), 2, 'example 1');
is(divisiblepairs([1, 2, 3, 4], 2), 2, 'example 2');
is(divisiblepairs([1, 3, 4, 5], 3), 2, 'example 3');
is(divisiblepairs([5, 1, 2, 3], 4), 2, 'example 4');
is(divisiblepairs([7, 2, 4, 5], 4), 1, 'example 5');

sub divisiblepairs(@a, $k) {
    my $ct = 0;
    for @a.combinations(2) -> @b {
        if ((@b[0] + @b[1]) % $k == 0) {
            $ct++;
        }
    }
    return $ct;
}
