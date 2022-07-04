#!/usr/bin/env perl
use v5.36;
use builtin qw(floor ceil);
no warnings 'experimental::builtin';

# Task 2: Five-number Summary
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to compute the five-number summary of the given set
# of integers.

# returns the median of a sorted list
sub median_sorted(@a) {
    say "@a";
    my $len = @a;
    return $len % 2 == 1 ?
        $a[$len/2] :
        ($a[$len/2-1] + $a[$len/2]) / 2;
}

# returns the 5 number summary of a list: minimum, lower quartile,
# median, upper quartile, maximum
sub fivenum(@a) {
    my @sorted = sort {$a <=> $b} @a;
    my $min = $sorted[0];
    my $max = $sorted[-1];
    my $median = median_sorted(@sorted);
    my ($lower, $upper);
    my $len = @sorted;
    if ($len % 2 == 1) { # odd number of elements
        $lower = median_sorted(@sorted[0..floor($len)]);
        $upper = median_sorted(@sorted[ceil($len)..$#sorted]);
    } else {
        $lower = median_sorted(@sorted[0..($len/2-1)]);
        $upper = median_sorted(@sorted[($len/2)..$#sorted]);
    }
    return ($min, $lower, $median, $upper, $max);
}

$, = " ";
say fivenum(@ARGV);
