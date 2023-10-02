#!/usr/bin/env perl

use v5.26;

say "challenge-222-task1";

# Task 1: Matching Members
# You are given a list of positive integers, @ints.
# Write a script to find the total matching members after sorting the list increasing order.

# Example 1
# Input: @ints = (1, 1, 4, 2, 1, 3)
# Output: 3
# Original list: (1, 1, 4, 2, 1, 2)
# Sorted list  : (1, 1, 1, 2, 3, 4)
# Compare the two lists, we found 3 matching members (1, 1, 2).

# Example 2
# Input: @ints = (5, 1, 2, 3, 4)
# Output: 0
# Original list: (5, 1, 2, 3, 4)
# Sorted list  : (1, 2, 3, 4, 5)
# Compare the two lists, we found 0 matching members.

# Example 3
# Input: @ints = (1, 2, 3, 4, 5)
# Output: 5
# Original list: (1, 2, 3, 4, 5)
# Sorted list  : (1, 2, 3, 4, 5)
# Compare the two lists, we found 5 matching members.

sub matching_nembers {
    my @ints = @{+shift};
    $" = ', ';
    say "Input: \@ints = (@ints)";
    my @s_ints = sort @ints;
    say "Sorted: list = (@s_ints)";
    my $match = 0;
    # foreach my $i (0..$#ints) {
    #     $match++ if $ints[$i] == $s_ints[$i];
    # }
    $ints[$_] == $s_ints[$_] && $match++ for 0 .. $#ints;
    say "Output: $match\n";
    return $match;
}


while (<DATA>) {
    chomp;
    my @ints = split /\s*,\s*/;
    matching_nembers(\@ints);
}


__DATA__
1, 1, 4, 2, 1, 3
5, 1, 2, 3, 4
1, 2, 3, 4, 5
