# The Weekly Challenge 230
# Task 1 Separate Digits
use v5.30.0;
use warnings;

sub sd {
    my @ints = @_;
    my @ans = map {split "", 0+$_} @ints;
    return [@ans];
}

use Test::More tests=>2;
use Test::Deep;
cmp_deeply sd(1, 34, 5, 6), [1,3,4,5,6];
cmp_deeply sd(1, 24, 51, 60), [1, 2, 4, 5, 1, 6, 0];
