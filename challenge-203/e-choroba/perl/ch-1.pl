#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub special_quadruplets(@arr) {
    my $tally = 0;
    for my $i (0 .. $#arr - 3) {
        for my $j ($i + 1 .. $#arr - 2) {
            for my $k ($j + 1 .. $#arr - 1) {
                for my $l ($k + 1 .. $#arr) {
                    next unless $arr[$i] + $arr[$j] + $arr[$k] == $arr[$l];
                    ++$tally
                }
            }
        }
    }
    return $tally
}

use Test::More tests => 3 + 1;

is special_quadruplets(1, 2, 3, 6), 1, 'Example 1';
is special_quadruplets(1, 1, 1, 3, 5), 4, 'Example 2';
is special_quadruplets(3, 3, 6, 4, 5), 0, 'Example 3';

is special_quadruplets(2, 13, 19, 16, 0, 9, 11, 1, 14, 17, 9, 18, 18,
                       2, 5, 9, 7, 7, 3, 7, 10, 17, 1, 19, 10, 12, 13,
                       14, 1, 3, 16, 15, 9, 15, 3, 9, 16, 15, 10, 2,
                       12, 0, 0, 2, 14, 18, 11, 2, 5, 6),
    1795,
    'Long list';
