#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Majority Element
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers of size $N.
#
# Write a script to find the majority element. If none found then print -1.
#
#     Majority element in the list is the one that appears more than floor(size_of_list/2).
#
# Example 1
# Input: @A = (1, 2, 2, 3, 2, 4, 2)
# Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
#
# Example 2
# Input: @A = (1, 3, 1, 2, 4, 5)
# Output: -1 as none of the elements appears more than floor(6/2).

my @a = @ARGV;
my $target = @a / 2;
my $result = -1;
my %cnt;

for my $x (@a) {
    if (++$cnt{$x} > $target) {
        $result = $x;
        last;
    }
}

say $result;
