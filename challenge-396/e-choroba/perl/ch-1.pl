#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub finishing_order($order, $friends) {
    my %place = reverse %$order[0 .. $#$order];
    return sort { $place{$a} <=> $place{$b} } @$friends
}

use Test2::V0;
plan(5);

is [finishing_order([3, 1, 4, 2, 5], [1, 2, 4])], [1, 4, 2], 'Example 1';
is [finishing_order([5, 4, 3, 2, 1], [1, 3, 5])], [5, 3, 1], 'Example 2';
is [finishing_order([2, 4, 1, 3], [1, 2, 3, 4])], [2, 4, 1, 3], 'Example 3';
is [finishing_order([4, 1, 3, 2], [3])], [3], 'Example 4';
is [finishing_order([1, 3, 2, 6, 5, 4], [1, 2, 3])], [1, 3, 2], 'Example 5';
