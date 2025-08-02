#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub distinct_average(@nums) {
    @nums = sort { $a <=> $b } @nums;
    my %avg;
    undef $avg{ ($nums[$_] + $nums[ $#nums - $_ ]) / 2 } for 0 .. @nums / 2;
    return scalar keys %avg
}

use Test::More tests => 3;

is distinct_average(1, 2, 4, 3, 5, 6), 1, 'Example 1';
is distinct_average(0, 2, 4, 8, 3, 5), 2, 'Example 2';
is distinct_average(7, 3, 1, 0, 5, 9), 2, 'Example 3';
