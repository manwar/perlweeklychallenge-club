#!/usr/bin/perl
use warnings;
use strict;

# Each node in the tree is represented as
#   [ value ( , first child ( , second child ) ) ]

sub sum_path {
    my ($tree, $sum) = @_;
    $sum += $tree->[0];
    return $sum if @$tree == 1;

    my @sums = map sum_path($_, $sum), @$tree[1 .. $#$tree];
    return $sums[0] + ($sums[1] // 0)
}

use Test::More tests => 4;
is sum_path([1, [2, [3], [4]]]), 13, 'Example 1';
is sum_path([1, [2, [4]], [3, [5], [6]]]), 26, 'Example 2';

is sum_path([42]), 42, 'trivial';
is sum_path([2, [1, [1, [1, [1], [1]], [1]], [1]], [1]]), 24, 'deep';
