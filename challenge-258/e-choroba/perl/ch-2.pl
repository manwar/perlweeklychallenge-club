#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub sum_of_values($ints, $k) {
    # See perldoc -f unpack for this one.
    sum(@$ints[ grep $k == unpack('%32b*', pack N => $_), 0 .. $#$ints ])
}

use Test::More tests => 3;

is sum_of_values([2, 5, 9, 11, 3], 1), 17, 'Example 1';
is sum_of_values([2, 5, 9, 11, 3], 2), 11, 'Example 2';
is sum_of_values([2, 5, 9, 11, 3], 0),  2, 'Example 3';
