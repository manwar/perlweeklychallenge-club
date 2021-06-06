#!/usr/bin/perl

# Challenge 106
#
# TASK #1 › Maximum Gap
# Submitted by: Mohammad S Anwar
# You are given an array of integers @N.
#
# Write a script to display the maximum difference between two successive
# elements once the array is sorted.
#
# If the array contains only 1 element then display 0.
#
# Example
# Input: @N = (2, 9, 3, 5)
# Output: 4
#
# Input: @N = (1, 3, 8, 2, 0)
# Output: 5
#
# Input: @N = (5)
# Output: 0

use Modern::Perl;

my @N = @ARGV;
say max_gap(@N);

sub max_gap {
    my(@n) = @_;
    return 0 if @n < 2;
    @n = sort @n;

    my $max_gap = 0;
    for my $i (0..$#n-1) {
        my $gap = $n[$i+1] - $n[$i];
        $max_gap = $gap if $gap > $max_gap;
    }
    return $max_gap;
}
