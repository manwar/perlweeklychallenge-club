#!/usr/bin/env perl

# Challenge 300
#
# Task 2: Nested Array
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints of length n containing permutation of the numbers in the range [0, n - 1].
#
# Write a script to build a set, set[i] = ints[i], ints[ints[i]], ints[ints[ints[i]]], ..., subjected to the following rules:
#
# 1. The first element in set[i] starts with the selection of elements ints[i].
# 2. The next element in set[i] should be ints[ints[i]], and then ints[ints[ints[i]]], and so on.
# 3. We stop adding right before a duplicate element occurs in set[i].
# Return the longest length of a set set[i].
#
# Example 1
# Input: @ints = (5, 4, 0, 3, 1, 6, 2)
# Output: 4
#
# ints[0] = 5
# ints[1] = 4
# ints[2] = 0
# ints[3] = 3
# ints[4] = 1
# ints[5] = 6
# ints[6] = 2
#
# One of the longest sets set[k]:
# set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}
# Example 2
# Input: @ints = (0, 1, 2)
# Output: 1

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums...\n";

my @nested = nested(@ARGV);
my @length = map {scalar(@$_)} @nested;
say max(@length);

sub nested {
    my(@nums) = @_;
    my @nested;
    for my $i (0 .. $#nums) {
        my %seen;
        my @seq;
        my $idx = $i;
        while (1) {
            my $next = $nums[$idx];
            last if $seen{$next}++;
            push @seq, $next;
            $idx = $next;
        }
        push @nested, \@seq;
    }
    return @nested;
}
