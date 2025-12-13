#!/usr/bin/env perl

# You are given an array of integers.
# Write a script to return the average excluding the minimum and maximum
# of the given array.

use 5.018;
use strict;
use warnings;
use Test2::V0;
use List::Util qw(min max sum0);

plan tests => 5;

sub special_average {
    my (@ints) = @_;

    print 'Input: @ints = (' . join( ', ', @ints ) . ")\n";

    my $min = min @ints;
    my $max = max @ints;

    @ints = grep { !/$min|$max/ } @ints;

    my $sum     = sum0 @ints;
    my $count   = scalar @ints || 1;
    my $average = $sum / $count;

    say 'Output: ' . $average;

    # say 'Min ' . $min;
    # say 'Max ' . $max;
    # say 'Avg ' . $average;

    return $average;
}

is( special_average( ( 8000, 5000, 6000, 2000, 3000, 7000 ) ),
    5250, 'example 1' );
is( special_average( ( 100_000, 80_000, 110_000, 90_000 ) ),
    95_000, 'example 2' );
is( special_average( ( 2500, 2500, 2500, 2500 ) ), 0, 'example 3' );
is( special_average( (2500) ),                     0, 'example 4' );
is( special_average( ( 1000, 2000, 3000, 4000, 5000, 6000 ) ),
    3500, 'example 5' );
