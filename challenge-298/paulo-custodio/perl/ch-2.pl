#!/usr/bin/env perl

# Challenge 298
#
# Task 2: Right Interval
# Submitted by: Mohammad Sajid Anwar
# You are given an array of @intervals, where $intervals[i] = [starti, endi] and each starti is unique.
#
# The right interval for an interval i is an interval j such that startj >= endi and startj is minimized. Please note that i may equal j.
#
# Write a script to return an array of right interval indices for each interval i. If no right interval exists for interval i, then put -1 at index i.
#
# Example 1
# Input: @intervals = ([3,4], [2,3], [1,2])
# Output: (-1, 0, 1)
#
# There is no right interval for [3,4].
# The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start that is >= end1 = 3.
# The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start that is >= end2 = 2.
# Example 2
# Input: @intervals = ([1,4], [2,3], [3,4])
# Output: (-1, 2, -1)
#
# There is no right interval for [1,4] and [3,4].
# The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start that is >= end1 = 3.
# Example 3
# Input: @intervals = ([1,2])
# Output: (-1)
#
# There is only one interval in the collection, so it outputs -1.
# Example 4
# Input: @intervals = ([1,4], [2, 2], [3, 4])
# Output: (-1, 1, -1)

use Modern::Perl;

@ARGV or die "usage: $0 'n n' 'n n'...\n";
my @int = map {[split ' ', $_]} @ARGV;
my @right_int = right_int(@int);
say join ", ", @right_int;

sub right_int {
    my(@int) = @_;
    my @right_int;
    for my $i (0 .. $#int) {
        my @candidates;
        for my $j (0 .. $#int) {
            push @candidates, [$j, @{$int[$j]}] if $int[$j][0] >= $int[$i][1];
        }
        if (@candidates) {
            @candidates = sort {$a->[1] <=> $b->[1]} @candidates;
            push @right_int, $candidates[0][0];
        }
        else {
            push @right_int, -1;
        }
    }
    return @right_int;
}
