#!/usr/bin/env perl

# Challenge 236
#
# Task 2: Array Loops
# Submitted by: Mark Anderson
#
# You are given an array of unique integers.
#
# Write a script to determine how many loops are in the given array.
#
#     To determine a loop: Start at an index and take the number at array[index]
#     and then proceed to that index and continue this until you end up at the
#     starting index.
#
#
# Example 1
#
# Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
# Output: 3
#
# To determine the 1st loop, start at index 0, the number at that index is 4,
# proceed to index 4, the number at that index is 15, proceed to index 15 and
# so on until you're back at index 0.
#
# Loops are as below:
# [4 15 1 6 13 5 0]
# [3 8 7 18 9 16 12 17 2]
# [14 11 19 10]
#
# Example 2
#
# Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
# Output: 6
#
# Loops are as below:
# [0]
# [1]
# [13 9 14 17 18 15 5 8 2]
# [7 11 4 6 10 16 3]
# [12]
# [19]
#
# Example 3
#
# Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
# Output: 1
#
# Loop is as below:
# [9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]

use Modern::Perl;

my @ints = @ARGV;
my @visited = (0) x @ints;
my $loops = 0;

while ((my $start = next_unvisited(@visited)) != -1) {
    do_loop($start, \@ints, \@visited);
    $loops++;
}
say $loops;

sub next_unvisited {
    my(@visited) = @_;
    for my $i (0 .. $#visited) {
        return $i if !$visited[$i];
    }
    return -1;
}

sub do_loop {
    my($start, $ints, $visited) = @_;
    my $i = $start;
    $visited->[$i] = 1;
    while ($ints->[$i] != $start) {
        return if $ints->[$i] == $start;
        $i = $ints->[$i];
        $visited->[$i] = 1;
    }
}
