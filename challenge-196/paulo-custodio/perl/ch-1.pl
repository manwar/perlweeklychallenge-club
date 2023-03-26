#!/usr/bin/perl

# Challenge 197
#
# Task 1: Pattern 132
# Submitted by: Mohammad S Anwar
# You are given a list of integers, @list.
#
# Write a script to find out subsequence that respect Pattern 132. Return empty array if none found.
#
#
# Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].
#
#
# Example 1
# Input:  @list = (3, 1, 4, 2)
# Output: (1, 4, 2) respect the Pattern 132.
# Example 2
# Input: @list = (1, 2, 3, 4)
# Output: () since no susbsequence can be found.
# Example 3
# Input: @list = (1, 3, 2, 4, 6, 5)
# Output: (1, 3, 2) if more than one subsequence found then return the first.
# Example 4
# Input: @list = (1, 3, 4, 2)
# Output: (1, 3, 2)

use Modern::Perl;

sub pattern132 {
    my(@n)=@_;
    for my $i (0..$#n-2) {
        for my $j ($i+1..$#n-1) {
            for my $k ($j+1..$#n) {
                if ($n[$i]<$n[$k] && $n[$k]<$n[$j]) {
                    return ($n[$i],$n[$j],$n[$k]);
                }
            }
        }
    }
    return ();
}

@ARGV or die "usage: ch-1.pl nums...\n";
my @n=@ARGV;
my @pattern132=pattern132(@n);
say "(@pattern132)";
