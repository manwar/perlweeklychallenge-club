#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/#TASK1
#
# Task 1: Straight Line
# =====================
#
# You are given a list of co-ordinates.
#
# Write a script to find out if the given points make a straight line.
#
## Example 1
##
## Input: @list = ([2, 1], [2, 3], [2, 5])
## Output: true
#
#
## Example 2
##
## Input: @list = ([1, 4], [3, 4], [10, 4])
## Output: true
#
#
## Example 3
##
## Input: @list = ([0, 0], [1, 1], [2, 3])
## Output: false
#
#
## Example 4
##
## Input: @list = ([1, 1], [1, 1], [1, 1])
## Output: true
#
#
## Example 5
##
## Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# Basically we need to calculate the slope of the potential straight line
# from the first two points in the list. Then we need to calculate the slope
# from the first point to each other point in the list and compare that to
# the first slope. If it's always the same all points are on a straight line.
# If it isn't then we found a point that isn't on the same straight line as
# the first two points so we can return "false".
# The rest is special case handling: If a point is the same as the first point
# in the list it's on every straight line that crosses this point, so we are
# fine. And if the x values are the same but the y values aren't then we are
# on a vertical line so we can't calculate the slope due to division by zero.
# While at it, we also do special handling for the case of a horizontal line
# even though that wouldn't be necessary as the slope would just be 0.

use v5.36;

straight_line([2, 1], [2, 3], [2, 5]);
straight_line([1, 4], [3, 4], [10, 4]);
straight_line([0, 0], [1, 1], [2, 3]);
straight_line([1, 1], [1, 1], [1, 1]);
straight_line([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]);

sub straight_line(@list) {
    say "Input: (" . join(", ", map { "[$_->[0], $_->[1]]" } @list) . ")";
    my $direction = "";
    my $start = shift @list;
    my $slope;
    foreach my $point (@list) {
        if($point->[0] == $start->[0] and $point->[1] == $start->[1]) {
            # the same point again - it's always on the same line
            next;
        }
        if(defined($slope)) {
            if($slope eq "v" and $point->[0] == $start->[0]) {
                # x value is the same for a vertical slope
                next;
            }
            if($slope eq "h" and $point->[1] == $start->[1]) {
                # y value is the same for a horizontal slope
                next;
            }
            if($slope == ($point->[1] - $start->[1])/($point->[0] - $start->[0]) ) {
                # slope to this point is the same as before, so we're on the same straight line
                next;
            }
            return say "Output: false";
        } else {
            if($point->[0] == $start->[0]) {
                $slope = "v";
            } elsif($point->[1] == $start->[1]) {
                $slope = "h";
            } else {
                $slope = ($point->[1] - $start->[1])/($point->[0] - $start->[0]);
            }
        }
    }
    say "Output: true";
}

