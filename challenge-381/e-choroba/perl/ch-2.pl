#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ minmax };
use List::Util qw{ sum0 };

sub smaller_greater_element(@int) {
    my %uniq;
    ++$uniq{$_} for @int;
    delete @uniq{ minmax(@int) };
    return sum0(values %uniq)
}

use Test::More tests => 5;

is smaller_greater_element(2, 4), 0, 'Example 1';
is smaller_greater_element(1, 1, 1, 1), 0, 'Example 2';
is smaller_greater_element(1, 1, 4, 8, 12, 12), 2, 'Example 3';
is smaller_greater_element(3, 6, 6, 9), 2, 'Example 4';
is smaller_greater_element(0, -5, 10, -2, 4), 3, 'Example 5';
