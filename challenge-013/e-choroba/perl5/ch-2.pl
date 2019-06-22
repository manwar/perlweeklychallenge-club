#!/usr/bin/perl
use warnings;
use strict;

use Function::Parameters;

use Memoize;
memoize('F');
memoize('M');

fun F ($n) {
    return $n ? $n - M(F($n - 1)) : 1
}

fun M ($n) {
    return $n ? $n - F(M($n - 1)) : 0
}

use Test::More;

warn +(F(98))[-1]; # To see the efficiency

is_deeply
    [map F($_), 0 .. 20],
    [1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 13];

is_deeply
    [map M($_), 0 .. 20],
    [0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 12];

done_testing();
