#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ min sum };

sub triangle_sum_path {
    my ($triangle) = @_;
    return sum(map min(@$_), @$triangle)
}

use Test::More tests => 2;

is triangle_sum_path([ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]),
    8,
    'Example 1';
is triangle_sum_path([ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]),
    9,
    'Example 2';
