#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub maximum_xor($list) {
    my $max = 0;
    for my $x_index (0 .. $#$list - 1) {
        for my $y_index ($x_index + 1 .. $#$list) {
            my $candidate = $list->[$x_index] ^ $list->[$y_index];
            $max = $candidate if $candidate > $max;
        }
    }
    return $max
}

use Test::More tests => 3;

is maximum_xor([1, 2, 3, 4, 5, 6, 7]), 7, 'Example 1';
is maximum_xor([2, 4, 1, 3]), 7, 'Example 2';
is maximum_xor([10, 5, 7, 12, 8]), 15, 'Example 3';
