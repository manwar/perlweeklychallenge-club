#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );
use builtin qw{ true false };

use Memoize;

sub matchstick_square(@ints) {
    return _matchstick_square(0, 0, 0, 0, @ints)
}

memoize '_matchstick_square';
sub _matchstick_square(@arr) {
    my @sides = splice @arr, 0, 4;
    return 3 == grep $sides[$_] == $sides[ $_ + 1 ], 0 .. 2
        unless @arr;

    my $match = shift @arr;
    for my $i (0 .. 3) {
        $sides[$i] += $match;
        return true if _matchstick_square(@sides, @arr);
        $sides[$i] -= $match;
    }
    return false
}

use Test::More tests => 4 + 2;

is matchstick_square(1, 2, 2, 2, 1), true, 'Example 1';
is matchstick_square(2, 2, 2, 4), false, 'Example 2';
is matchstick_square(2, 2, 2, 2, 4), false, 'Example 3';
is matchstick_square(3, 4, 1, 4, 3, 1), true, 'Example 4';

is matchstick_square(10, 2, (3) x 4, (4) x 3, 6, 6), true, 'Twelve';
is matchstick_square(10, 2, (3) x 4, (4) x 3, (2) x 6), true, 'Twelve';
