#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ product };

sub array_of_product {
    my (@n) = @_;
    return [map { local $n[$_] = 1; product(@n) } 0 .. $#n]
}

use Test::More tests => 3;

is_deeply array_of_product(5, 2, 1, 4, 3), [24, 60, 120, 30, 40], 'Example 1';
is_deeply array_of_product(2, 1, 4, 3), [12, 24, 6, 8], 'Example 2';

is_deeply array_of_product(1, 2, 3, 0), [0, 0, 0, 6], 'Zero';
