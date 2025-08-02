#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub multiple_by_two($start, @ints) {
    $start *= 2 while grep $_ == $start, @ints;
    return $start
}

use Test::More tests => 3;

is multiple_by_two(3, 5, 3, 6, 1, 12), 24, 'Example 1';
is multiple_by_two(1, 1, 2, 4, 3), 8, 'Example 2';
is multiple_by_two(2, 5, 6, 7), 2, 'Example 3';
