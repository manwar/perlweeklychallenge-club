#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub bitwise_or(@ints) {
    return 1 < grep 0 == $_ % 2, @ints
}

use Test::More tests => 3;

ok bitwise_or(1, 2, 3, 4, 5), 'Example 1';
ok bitwise_or(2, 3, 8, 16), 'Example 2';
ok ! bitwise_or(1, 2, 5, 7, 9), 'Example 3';
