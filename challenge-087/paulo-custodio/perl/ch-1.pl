#!/usr/bin/perl

# Challenge 087
#
# TASK #1 › Longest Consecutive Sequence
# Submitted by: Mohammad S Anwar
# You are given an unsorted array of integers @N.
#
# Write a script to find the longest consecutive sequence. Print 0 if none sequence found.
#
# Example 1:
# Input: @N = (100, 4, 50, 3, 2)
# Output: (2, 3, 4)
# Example 2:
# Input: @N = (20, 30, 10, 40, 50)
# Output: 0
# Example 3:
# Input: @N = (20, 19, 9, 11, 10)
# Output: (9, 10, 11)

use strict;
use warnings;
use 5.030;

my @seq = longest_seq(@ARGV);
if (@seq) {
    say "(", join(", ", @seq), ")";
}
else {
    say 0;
}

sub longest_seq {
    my(@n) = @_;
    my @seq;

    # sort the sequence
    @n = sort {$a<=>$b} @n;

    # look for sequences of consecutive numbers
    while (@n) {
        my $i = 0;
        while ($i < @n && $n[$i] == $n[0]+$i) {
            $i++;
        }
        my @got = splice(@n, 0, $i);    # [0..i[ is a sequence
        if (@got > 1 && @got > @seq) {
            @seq = @got;                # found a longer sequence
        }
    }

    return @seq;
}
