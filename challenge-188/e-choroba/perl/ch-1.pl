#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub divisible_pairs ($list, $k) {
    my $found = 0;
    for my $i (0 .. $#$list - 1) {
        for my $j ($i + 1 .. $#$list) {
            ++$found if 0 == ($list->[$i] + $list->[$j]) % $k;
        }
    }
    return $found
}

use Test::More tests => 5;

is divisible_pairs([4, 5, 1, 6], 2), 2, 'Example 1';
is divisible_pairs([1, 2, 3, 4], 2), 2, 'Example 2';
is divisible_pairs([1, 3, 4, 5], 3), 2, 'Example 3';
is divisible_pairs([5, 1, 2, 3], 4), 2, 'Example 4';
is divisible_pairs([7, 2, 4, 5], 4), 1, 'Example 5';
