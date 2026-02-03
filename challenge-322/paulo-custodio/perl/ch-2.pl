#!/usr/bin/env perl

# Challenge 322
#
# Task 2: Rank Array
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers.
#
# Write a script to return an array of the ranks of each element: the lowest value has rank 1, next lowest rank 2, etc. If two elements are the same then they share the same rank.
#
#
# Example 1
# Input: @ints = (55, 22, 44, 33)
# Output: (4, 1, 3, 2)
#
# Example 2
# Input: @ints = (10, 10, 10)
# Output: (1, 1, 1)
#
# Example 3
# Input: @ints = (5, 1, 1, 4, 3)
# Output: (4, 1, 1, 3, 2)

use Modern::Perl;
use List::Util qw(uniq);

@ARGV or die "usage $0 nums...\n";
say join ", ", rank(@ARGV);

sub rank {
    my(@nums) = @_;
    my @uniq = uniq sort {$a<=>$b} @nums;
    my %rank;
    for my $i (0 .. $#uniq) {
        $rank{$uniq[$i]} = $i+1;
    }
    my @rank = map {$rank{$_}} @nums;
    return @rank;
}
