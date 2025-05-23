#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ uniq };

sub rank_array(@ints) {
    my @uniq = sort { $a <=> $b } uniq(@ints);
    my %rank;
    @rank{@uniq} = 1 .. @uniq;
    return @rank{@ints}
}

use Test2::V0;
plan(3);

is [rank_array(55, 22, 44, 33)], [4, 1, 3, 2], 'Example 1';
is [rank_array(10, 10, 10)], [1, 1, 1], 'Example 2';
is [rank_array(5, 1, 1, 4, 3)], [4, 1, 1, 3, 2], 'Example 3';
