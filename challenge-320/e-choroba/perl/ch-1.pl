#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub maximum_count(@ints) {
    my %count = (1 => 0, -1 => 0);
    ++$count{ $_ <=> 0 } for @ints;
    return (($count{1}) x 2, $count{-1})[ $count{1} <=> $count{-1} ]
}

use Test::More tests => 3 + 3;

is maximum_count(-3, -2, -1, 1, 2, 3), 3, 'Example 1';
is maximum_count(-2, -1, 0, 0, 1), 2, 'Example 2';
is maximum_count(1, 2, 3, 4), 4, 'Example 3';

is maximum_count(0, 0, 0), 0, 'All zeros';
is maximum_count(-1, -1), 2, 'All negative';
is maximum_count(1, 2, 0, 0, -1), 2, 'More positive';
