#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub matching_members(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    return scalar grep $ints[$_] == $sorted[$_], 0 .. $#ints
}

use Test::More tests => 3;

is matching_members(1, 1, 4, 2, 1, 3), 3, 'Example 1';
is matching_members(5, 1, 2, 3, 4), 0, 'Example 2';
is matching_members(1, 2, 3, 4, 5), 5, 'Example 3';
