#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub good_triplets ($arr, $x, $y, $z) {
    # Optimization: abs can't be < 0.
    return 0 if grep $_ < 0, $x, $y, $z;

    my $c = 0;
    for my $i (0 .. $#$arr - 2) {
        for my $j ($i + 1 .. $#$arr - 1) {
            next unless abs($arr->[$i] - $arr->[$j]) <= $x;
            for my $k ($j + 1 .. $#$arr) {
                ++$c if abs($arr->[$j] - $arr->[$k]) <= $y
                     && abs($arr->[$i] - $arr->[$k]) <= $z;
            }
        }
    }
    return $c
}

use Test::More tests => 2 + 1;

is good_triplets([3, 0, 1, 1, 9, 7], 7, 2, 3), 4, 'Example 1';
is good_triplets([1, 1, 2, 2, 3], 0, 0, 1), 0, 'Example 2';

is good_triplets([map int rand 100, 1 .. 1000], 0, 0, -1), 0, 'Negative';
