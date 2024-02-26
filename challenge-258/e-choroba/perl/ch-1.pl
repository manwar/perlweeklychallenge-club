#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_even_digits_number(@ints) {
    scalar grep 0 == length() % 2, @ints
}

use Test::More tests => 3;

is count_even_digits_number(10, 1, 111, 24, 1000), 3, 'Example 1';
is count_even_digits_number(111, 1, 11111), 0, 'Example 2';
is count_even_digits_number(2, 8, 1024, 256), 1, 'Example 3';
