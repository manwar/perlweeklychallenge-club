#!/usr/bin/env perl

# Challenge 270
#
# Task 2: Equalize Array
# Submitted by: Mohammad Sajid Anwar
# You are give an array of integers, @ints and two integers, $x and $y.
#
# Write a script to execute one of the two options:
#
# Level 1:
# Pick an index i of the given array and do $ints[i] += 1
#
# Level 2:
# Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.
# You are allowed to perform as many levels as you want to make every elements
# in the given array equal. There is cost attach for each level, for Level 1,
# the cost is $x and $y for Level 2.
#
# In the end return the minimum cost to get the work done.
#
# Example 1
# Input: @ints = (4, 1), $x = 3 and $y = 2
# Output: 9
#
# Level 1: i=1, so $ints[1] += 1.
# @ints = (4, 2)
#
# Level 1: i=1, so $ints[1] += 1.
# @ints = (4, 3)
#
# Level 1: i=1, so $ints[1] += 1.
# @ints = (4, 4)
#
# We perforned operation Level 1, 3 times.
# So the total cost would be 3 x $x => 3 x 3 => 9
# Example 2
# Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
# Output: 6
#
# Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
# @ints = (3, 4, 3, 3, 5)
#
# Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
# @ints = (4, 4, 4, 3, 5)
#
# Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
# @ints = (5, 4, 4, 4, 5)
#
# Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
# @ints = (5, 5, 5, 4, 5)
#
# Level 1: i=3, so $ints[3] += 1
# @ints = (5, 5, 5, 5, 5)
#
# We perforned operation Level 1, 1 time and Level 2, 4 times.
# So the total cost would be (1 x $x) + (4 x $y) => (1 x 2) + (4 x 1) => 6

use Modern::Perl;

my($x, $y, @ints) = @ARGV;

say equalize($x, $y, @ints);

sub equalize {
    my($x, $y, @ints) = @_;

    my $cost = 0;
    @ints = sort {$a <=> $b} @ints;
    return $cost if !@ints;
    my $max = $ints[-1];

    while (@ints) {
        @ints = sort {$a <=> $b} @ints;
        @ints = grep {$_ != $max} @ints;
        last if !@ints;

        if (@ints == 1) {
            $ints[0]++;
            $cost += $x;
        }
        else {
            $ints[0]++;
            $ints[1]++;
            $cost += $y;
        }
    }

    return $cost;
}
