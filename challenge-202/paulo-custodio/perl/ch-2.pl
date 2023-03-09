#!/usr/bin/perl

# Challenge 202
#
# Task 2: Widest Valley
# Submitted by: E. Choroba
#
# Given a profile as a list of altitudes, return the leftmost widest valley.
# A valley is defined as a subarray of the profile consisting of two parts:
# the first part is non-increasing and the second part is non-decreasing.
# Either part can be empty.
#
# Example 1
#
# Input: 1, 5, 5, 2, 8
# Output: 5, 5, 2, 8
#
# Example 2
#
# Input: 2, 6, 8, 5
# Output: 2, 6, 8
#
# Example 3
#
# Input: 9, 8, 13, 13, 2, 2, 15, 17
# Output: 13, 13, 2, 2, 15, 17
#
# Example 4
#
# Input: 2, 1, 2, 1, 3
# Output: 2, 1, 2
#
# Example 5
#
# Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
# Output: 3, 3, 2, 1, 2, 3, 3

use Modern::Perl;

sub largest_valey {
    my(@in) = @_;
    my @valey;
    for my $c (0 .. $#in) {     # center of valey
        my $l = $c;             # left
        while ($l > 0 && $in[$l-1] >= $in[$l]) {
            $l--;
        }
        my $r = $c;             # right
        while ($r < $#in && $in[$r+1] >= $in[$r]) {
            $r++;
        }
        if ($r-$l+1 > @valey) {
            @valey = @in[$l..$r];
        }
    }
    return @valey;
}

say join(" ", largest_valey(@ARGV));
