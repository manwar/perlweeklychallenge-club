#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub element_digit_sum(@ints) {
    abs(sum(@ints) - sum(map { split // } @ints))
}

use Test::More tests => 4;

is element_digit_sum(1, 2, 3, 45), 36, 'Example 1';
is element_digit_sum(1, 12, 3), 9, 'Example 2';
is element_digit_sum(1, 2, 3, 4), 0, 'Example 3';
is element_digit_sum(236, 416, 336, 350), 1296, 'Example 4';
