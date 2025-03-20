#!/usr/bin/env perl

# Challenge 312
#
# Task 2: Balls and Boxes
# Submitted by: Mohammad Sajid Anwar
#
# There are $n balls of mixed colors: red, blue or green. They are all
# distributed in 10 boxes labelled 0-9.
#
# You are given a string describing the location of balls.
#
# Write a script to find the number of boxes containing all three colors.
# Return 0 if none found.
# Example 1
#
# Input: $str = "G0B1R2R0B0"
# Output: 1
#
# The given string describes there are 5 balls as below:
# Box 0: Green(G0), Red(R0), Blue(B0) => 3 balls
# Box 1: Blue(B1) => 1 ball
# Box 2: Red(R2) => 1 ball
#
# Example 2
#
# Input: $str = "G1R3R6B3G6B1B6R1G3"
# Output: 3
#
# The given string describes there are 9 balls as below:
# Box 1: Red(R1), Blue(B1), Green(G1) => 3 balls
# Box 3: Red(R3), Blue(B3), Green(G3) => 3 balls
# Box 6: Red(R6), Blue(B6), Green(G6) => 3 balls
#
# Example 3
#
# Input: $str = "B3B2G1B3"
# Output: 0
#
# Box 1: Green(G1) => 1 ball
# Box 2: Blue(B2)  => 1 ball
# Box 3: Blue(B3)  => 2 balls

use Modern::Perl;

say box_with_3_colors(shift // "");

sub box_with_3_colors {
    my($spec) = @_;
    my %boxes;
    while ($spec =~ /([RGB])(\d)/gc) {
        $boxes{$2}{$1}++;
    }

    my $count = 0;
    for my $box (keys %boxes) {
        if ($boxes{$box}{R} && $boxes{$box}{G} && $boxes{$box}{B}) {
            $count++;
        }
    }
    return $count;
}
