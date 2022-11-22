#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ sum };

sub equal_distribution ($list) {
    my $sum = sum(@$list);
    if (0 == $sum % @$list) {
        my $avg = $sum / @$list;
        my $moves = 0;
        my $sum_part = 0;
        for my $i (0 .. $#$list) {
            $sum_part += $list->[$i];
            $moves += abs($sum_part - ($avg * ($i + 1)));
        }
        return $moves
    } else {
        return -1
    }
}

use Test::More tests => 3 + 4;

is equal_distribution([1, 0, 5]),  4, 'Example 1';
is equal_distribution([0, 2, 0]), -1, 'Example 2';
is equal_distribution([0, 3, 0]),  2, 'Example 3';

is equal_distribution([1, 5, 0]), 3, '1-5-0';
is equal_distribution([5, 1, 0]), 5, '5-1-0';
is equal_distribution([3, 3, 0]), 3, '3-3-0';
is equal_distribution([1, 0, 6, 2, 4, 7, 1]), 16, 'long';
