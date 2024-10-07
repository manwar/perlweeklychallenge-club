#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub double_exist(@ints) {
    my %seen;
    @seen{@ints} = ();
    exists $seen{ 2 * $_ } and return 1 for keys %seen;
    return 0
}

use Test::More tests => 3;

is double_exist(6, 2, 3, 3), 1, 'Example 1';
is double_exist(3, 1, 4, 13), 0, 'Example 2';
is double_exist(2, 1, 4, 2), 1, 'Example 3';
