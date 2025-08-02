#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub product_sign(@ints) {
    my %count;
    ++$count{ $_ <=> 0 } for @ints;
    return 0 if $count{0};
    return $count{-1} % 2 ? -1 : 1
}

use Test::More tests => 3;

is product_sign(-1, -2, -3, -4, 3, 2, 1), 1, 'Example 1';
is product_sign(1, 2, 0, -2, -1), 0, 'Example 2';
is product_sign(-1, -1, 1, -1, 2), -1, 'Example 3';
