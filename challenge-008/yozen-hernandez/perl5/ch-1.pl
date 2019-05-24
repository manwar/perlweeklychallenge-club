#!/usr/bin/env perl

use strict;
use warnings;

use constant mersenne_exps => (
    2,        3,        5,        7,        13,       17,
    19,       31,       61,       89,       107,      127,
    521,      607,      1279,     2203,     2281,     3217,
    4253,     4423,     9689,     9941,     11213,    19937,
    21701,    23209,    44497,    86243,    110503,   132049,
    216091,   756839,   859433,   1257787,  1398269,  2976221,
    3021377,  6972593,  13466917, 20996011, 24036583, 25964951,
    30402457, 32582657, 37156667, 42643801, 43112609
);

my $n = 5;
print join( ", ", perfect_nums($n) ), "\n";

sub perfect_nums {
    my $n = shift;
    my @nums;
    for my $i ( 0 .. $n-1 ) {
        my $exp = (mersenne_exps)[$i];

        push( @nums, 2**($exp-1)*((2**$exp) - 1) );
    }

    return @nums;
}
