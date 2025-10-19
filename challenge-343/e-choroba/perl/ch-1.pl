#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub zero_friend(@nums) {
    my $zf = abs shift @nums;
    abs $_ < $zf and $zf = abs for @nums;
    return $zf
}

use Test::More tests => 5;

is zero_friend(4, 2, -1, 3, -2), 1, 'Example 1';
is zero_friend(-5, 5, -3, 3, -1, 1), 1, 'Example 2';
is zero_friend(7, -3, 0, 2, -8), 0, 'Example 3';
is zero_friend(-2, -5, -1, -8), 1, 'Example 4';
is zero_friend(-2, 2, -4, 4, -1, 1), 1, 'Example 5';
