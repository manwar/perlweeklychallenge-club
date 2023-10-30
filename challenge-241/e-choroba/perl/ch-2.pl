#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Prime::Util qw{ factor };
use List::UtilsBy qw{ nsort_by };

sub prime_order(@int) {
    [nsort_by { scalar factor($_) } nsort_by { $_ } @int]
}

use Test2::V0;
plan 1 + 1;

is prime_order(11, 8, 27, 4), [11, 4, 8, 27], 'Example 1';
is prime_order(27, 8), [8, 27], 'Secondary order';
