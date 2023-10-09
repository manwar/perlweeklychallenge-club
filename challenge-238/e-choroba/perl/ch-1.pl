#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub running_sum(@int) {
    my @running_sum = shift @int;
    push @running_sum, $running_sum[-1] + shift @int while @int;
    return \@running_sum
}

use Test2::V0;
plan 3;

is running_sum(1, 2, 3, 4, 5), [1, 3, 6, 10, 15], 'Example 1';
is running_sum(1, 1, 1, 1, 1), [1, 2, 3, 4, 5], 'Example 2';
is running_sum(0, -1, 1, 2), [0, -1, 0, 2], 'Example 3';
