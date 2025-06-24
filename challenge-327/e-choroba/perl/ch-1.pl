#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub missing_integers(@ints) {
    my %missing;
    @missing{1 .. @ints} = ();
    delete @missing{@ints};
    return keys %missing
}

use Test2::V0;
plan(3 + 1);

is [missing_integers(1, 2, 1, 3, 2, 5)], bag { item($_) for 4, 6; end() },
    'Example 1';
is [missing_integers(1, 1, 1)], bag { item($_) for 2, 3; end() }, 'Example 2';
is [missing_integers(2, 2, 1)], [3], 'Example 3';

is [missing_integers(5, 9)], bag { item($_) for 1, 2; ;end() },
    'greater than n';
