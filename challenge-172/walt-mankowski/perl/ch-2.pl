#!/usr/bin/env perl
use v5.36;

# Task 2: Five-number Summary
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to compute the five-number summary of the given set
# of integers.

# returns the median of a sorted list
sub median_sorted(@a) {
    my $len2 = int(@a / 2);
    return @a % 2 == 1 ? $a[$len2] : ($a[$len2-1] + $a[$len2]) / 2;
}

# returns the 5 number summary of a list: minimum, lower quartile,
# median, upper quartile, maximum
sub fivenum(@a) {
    my @sorted = sort {$a <=> $b} @a;
    my $min = $sorted[0];
    my $max = $sorted[-1];
    my $median = median_sorted(@sorted);

    my $len2 = int(@sorted / 2);
    my $lower = median_sorted(@sorted[0..$len2-1]);
    my $upper;
    if (@sorted % 2 == 1) { # odd number of elements
        $upper = median_sorted(@sorted[$len2+1..$#sorted]);
    } else {
        $upper = median_sorted(@sorted[$len2..$#sorted]);
    }
    return ($min, $lower, $median, $upper, $max);
}

$, = " ";
say fivenum(@ARGV);
