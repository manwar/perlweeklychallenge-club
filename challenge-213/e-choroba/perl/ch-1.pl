#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub fun_sort(@list) {
    [sort { $a % 2 <=> $b % 2 || $a <=> $b } @list]
}

use Test2::V0;
plan 3;

is fun_sort(1, 2, 3, 4, 5, 6), [2, 4, 6, 1, 3, 5], 'Example 1';
is fun_sort(1, 2), [2, 1], 'Example 2';
is fun_sort(1), [1], 'Example 3';
