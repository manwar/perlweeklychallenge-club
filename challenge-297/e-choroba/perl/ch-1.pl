#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub contiguous_array(@binary) {
    # @score says how many 0s are needed to get the same number of 0s and 1s
    # starting from the current position. Therefore, $target in score means we
    # have a contiguous subarray.
    my @score = ($binary[0] ? 1 : -1);
    my $target = 0;
    push @score, $score[ $_ - 1 ] + ($binary[$_] ? 1 : -1)
        for 1 .. $#binary;

    my $max_length = 0;
    while (@score) {
        my $last_target
            = 1 + ((grep $target == $score[$_], 0 .. $#score)[-1] // -1);
        $max_length = $last_target if $last_target > $max_length;

    } continue {
        shift @score;
        last if $max_length > @score;  # We can't improve anymore.

        $target += $binary[ -@score - 1 ] ? 1 : -1;
    }
    return $max_length
}

use Test::More tests => 4 + 1;

is contiguous_array(1, 0), 2, 'Example 1';
is contiguous_array(0, 1, 0), 2, 'Example 2';
is contiguous_array(0, 0, 0, 0, 0), 0, 'Example 3';
is contiguous_array(0, 1, 0, 0, 1, 0), 4, 'Example 4';

is contiguous_array(qw( 0 0 1 0 1 0 0 0 1 1 0 1 )), 10, 'Longer example';
