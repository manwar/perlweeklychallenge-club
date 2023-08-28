#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub separate_digits(@ints) {
    [map split(//), @ints]
}

use Test2::V0;
plan 2;

is separate_digits(1, 34, 5, 6), [1, 3, 4, 5, 6], 'Example 1';
is separate_digits(1, 24, 51, 60), [1, 2, 4, 5, 1, 6, 0], 'Example 2';
