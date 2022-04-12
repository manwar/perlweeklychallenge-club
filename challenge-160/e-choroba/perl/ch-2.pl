#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ sum };


sub equilibrium_index ($array) {
    my $i = 0;
    my @sums = (0, sum(@$array) - $array->[0]);
    my @results;
    for my $i (1 .. $#$array - 1) {
        $sums[0] += $array->[$i - 1];
        $sums[1] -= $array->[$i];
        push @results, $i if $sums[0] == $sums[1];
    }

    return @results if @results;

    return -1
}

use Test::More tests => 5;

is_deeply [equilibrium_index([1, 3, 5, 7, 9])], [ 3], 'Example 1';
is_deeply [equilibrium_index([1, 2, 3, 4, 5])], [-1], 'Example 2';
is_deeply [equilibrium_index([2, 4, 2])      ], [ 1], 'Example 3';

is_deeply [equilibrium_index([1, 1, 1, -3, 7, 0])], [4], 'Negative numbers';
is_deeply [equilibrium_index([0, 0, 0, 0])], [1, 2], 'More options';
