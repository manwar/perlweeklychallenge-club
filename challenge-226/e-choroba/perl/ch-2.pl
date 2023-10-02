#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# It makes no sense to subtract anything but the minimum (otherwise,
# we'd have to subtract the remaining quantity in a later step). To
# get the number of steps, it's enough to count the number of unique
# positive elements.

sub zero_array(@ints) {
    my %element;
    @element{@ints} = ();
    delete $element{0};
    return keys %element
}

use Test::More tests => 3;

is zero_array(1, 5, 0, 3, 5), 3, 'Example 1';
is zero_array(0), 0, 'Example 2';
is zero_array(2, 1, 4, 0, 3), 4, 'Example 3';
