#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub acronyms($array, $word) {
    $word eq join "", map substr($_, 0, 1), @$array
}

use Test2::V0;
plan(3);

is acronyms(['Perl', 'Weekly', 'Challenge'], 'PWC'), bool(1), 'Example 1';
is acronyms(['Bob', 'Charlie', 'Joe'], 'BCJ'), bool(1), 'Example 2';
is acronyms(['Morning', 'Good'], 'MM'), bool(0), 'Example 3';
