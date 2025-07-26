#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub binary_date($date) {
    join '-', map sprintf('%b', $_), split /-/, $date
}

use Test::More tests => 3;

is binary_date('2025-07-26'), '11111101001-111-11010', 'Example 1';
is binary_date('2000-02-02'), '11111010000-10-10', 'Example 2';
is binary_date('2024-12-31'), '11111101000-1100-11111', 'Example 3';
