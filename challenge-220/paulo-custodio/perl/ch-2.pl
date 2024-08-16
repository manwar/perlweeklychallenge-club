#!/usr/bin/env perl

# Challenge 220
#
# Task 2: Squareful
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers, @ints.
#
#     An array is squareful if the sum of every pair of adjacent elements is
#     a perfect square.
#
# Write a script to find all the permutations of the given array that are squareful.
# Example 1:
#
# Input: @ints = (1, 17, 8)
# Output: (1, 8, 17), (17, 8, 1)
#
# (1, 8, 17) since 1 + 8 => 9, a perfect square and also 8 + 17 => 25 is perfect square too.
# (17, 8, 1) since 17 + 8 => 25, a perfect square and also 8 + 1 => 9 is perfect square too.
#
# Example 2:
#
# Input: @ints = (2, 2, 2)
# Output: (2, 2, 2)
#
# There is only one permutation possible.

use Modern::Perl;
use Math::Combinatorics;

my @ints = @ARGV;

my $combinat = Math::Combinatorics->new(count => scalar(@ints), data => [@ints]);
my @result;
my %found;

while(my @permu = $combinat->next_permutation) {
    next if $found{"@permu"}++;
    next unless is_squareful(@permu);
    push @result, \@permu;
}

say join(", ", sort map {"(" . join(", ", @$_) . ")"} @result);

sub is_squareful {
    my(@ints) = @_;
    for (0..$#ints-1) {
        my $sum = $ints[$_]+$ints[$_+1];
        my $sq = sqrt($sum);
        return 0 unless int($sq) == $sq;
    }
    return 1;
}
