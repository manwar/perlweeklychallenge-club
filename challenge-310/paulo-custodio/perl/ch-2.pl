#!/bin/env perl

# Challenge 310
#
# Task 2: Sort Odd Even
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers.
#
# Write a script to sort odd index elements in decreasing order and even index
# elements in increasing order in the given array.
# Example 1
#
# Input: @ints = (4, 1, 2, 3)
# Output: (2, 3, 4, 1)
#
# Even index elements: 4, 2 => 2, 4 (increasing order)
# Odd index elements : 1, 3 => 3, 1 (decreasing order)
#
# Example 2
#
# Input: @ints = (3, 1)
# Output: (3, 1)
#
# Example 3
#
# Input: @ints = (5, 3, 2, 1, 4)
# Output: (2, 3, 4, 1, 5)
#
# Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
# Odd index elements : 3, 1 => 3, 1 (decreasing order)

use Modern::Perl;

my @list = @ARGV;
my @sorted = sort_odd_even(@list);
say "(", join(", ", @sorted), ")";

sub sort_odd_even {
    my(@list) = @_;

    my @even, my @odd;
    while (@list) {
        my($a, $b) = splice(@list, 0, 2);
        push @even, $a if defined $a;
        push @odd, $b if defined $b;
    }

    @even = sort {$a <=> $b} @even;
    @odd = sort {$b <=> $a} @odd;

    my @zip;
    while (@even || @odd) {
        push @zip, shift(@even), shift(@odd);
    }
    @zip = grep {defined} @zip;

    return @zip;
}
