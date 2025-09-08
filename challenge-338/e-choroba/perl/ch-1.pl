#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub highest_row(@matrix) {
    return pdl(@matrix)->sumover->max
}

use Test::More tests => 5;

is highest_row([4,  4, 4, 4],
               [10, 0, 0, 0],
               [2,  2, 2, 9]),
    16, 'Example 1';

is highest_row([1, 5],
               [7, 3],
               [3, 5]),
    '10', 'Example 2';

is highest_row([1, 2, 3],
               [3, 2, 1]),
    6, 'Example 3';

is highest_row([2, 8, 7],
               [7, 1, 3],
               [1, 9, 5]),
    '17', 'Example 4';

is highest_row([10, 20,  30],
               [5,  5,   5],
               [0,  100, 0],
               [25, 25,  25]),
    100, 'Example 5';
