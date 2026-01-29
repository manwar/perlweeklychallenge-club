#!/usr/bin/env perl

# Challenge 318
#
# Task 2: Reverse Equals
# Submitted by: Roger Bell_West
# You are given two arrays of integers, each containing the same elements as the other.
#
# Write a script to return true if one array can be made to equal the other by reversing exactly one contiguous subarray.
#
#
# Example 1
# Input: @source = (3, 2, 1, 4)
#        @target = (1, 2, 3, 4)
# Output: true
#
# Reverse elements: 0-2
#
# Example 2
# Input: @source = (1, 3, 4)
#        @target = (4, 1, 3)
# Output: false
#
# Example 3
# Input: @source = (2)
#        @target = (2)
# Output: true

use Modern::Perl;

my @source = split ' ', <>;
my @target = split ' ', <>;
say is_reverse_equal(\@source, \@target) ? "true" : "false";

sub is_reverse_equal {
    my($n1, $n2) = @_;
    my @n1 = @$n1;
    my @n2 = @$n2;
    return 1 if "@n1" eq "@n2";
    for my $i (0 .. $#n1) {
        for my $len (1 .. @n1 - $i) {
            my @tmp1 = @n1;
            @tmp1[$i .. $i+$len-1] = reverse @tmp1[$i .. $i+$len-1];
            return 1 if "@tmp1" eq "@n2";
        }
    }
    return 0;
}
