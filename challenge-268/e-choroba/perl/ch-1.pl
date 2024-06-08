#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub magic_number($x, $y) {
    my @mins = map min(@$_), $x, $y;
    return $mins[1] - $mins[0]
}

use Test::More tests => 3;

is magic_number([3, 7, 5], [9, 5, 7]), 2, 'Example 1';
is magic_number([1, 2, 1], [5, 4, 4]), 3, 'Example 2';
is magic_number([2], [5]), 3, 'Example 3';
