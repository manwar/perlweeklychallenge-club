#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub number_placement($list, $count) {
    (() = "@$list" =~ /0 0(?= 0)/g) >= $count ? 1 : 0
}

use Test::More tests => 3 + 1;
is number_placement([1, 0, 0, 0, 1], 1), 1, 'Example 1';
is number_placement([1, 0, 0, 0, 1], 2), 0, 'Example 2';
is number_placement([1, 0, 0, 0, 0, 0, 0, 0, 1], 3), 1, 'Example 3';

# Why /0(?= 0 0)/ is wrong:
is number_placement([1, 0, 0, 0, 0, 0, 0, 1], 3), 0, 'Edge case';
