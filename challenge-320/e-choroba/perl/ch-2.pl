#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub sum_difference(@ints) {
    abs(sum(@ints) - sum(map { split // } @ints))
}

use Test::More tests => 3;

is sum_difference(1, 23, 4, 5), 18, 'Example 1';
is sum_difference(1, 2, 3, 4, 5), 0, 'Example 2';
is sum_difference(1, 2, 34), 27, 'Example 3';
