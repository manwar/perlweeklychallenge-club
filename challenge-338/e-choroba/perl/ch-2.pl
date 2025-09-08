#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max min };

sub max_distance($arr1, $arr2) {
    return max(max(@$arr1) - min(@$arr2), max(@$arr2) - min(@$arr1))
}

use Test::More tests => 5;

is max_distance([4, 5, 7], [9, 1, 3, 4]), 6, 'Example 1';
is max_distance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]), 6, 'Example 2';
is max_distance([2, 1, 11, 3], [2, 5, 10, 2]), 9, 'Example 3';
is max_distance([1, 2, 3], [3, 2, 1]), 2, 'Example 4';
is max_distance([1, 0, 2, 3], [5, 0]), 5, 'Example 5';
