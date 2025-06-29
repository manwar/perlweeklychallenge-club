#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/#TASK2
#
# Task 2: MAD
# ===========
#
# You are given an array of distinct integers.
#
# Write a script to find all pairs of elements with minimum absolute difference
# (MAD) of any two elements.
#
## Example 1
##
## Input: @ints = (4, 1, 2, 3)
## Output: [1,2], [2,3], [3,4]
##
## The minimum absolute difference is 1.
## Pairs with MAD: [1,2], [2,3], [3,4]
#
#
## Example 2
##
## Input: @ints = (1, 3, 7, 11, 15)
## Output: [1,3]
#
#
## Example 3
##
## Input: @ints = (1, 5, 3, 8)
## Output: [1,3], [3,5]
#
############################################################
##
## discussion
##
############################################################
#
# We take two walks of the array. First, we find the MAD by calculating
# all absolute distances, keeping track of the minimum. Then, we keep all
# pairs of numbers where the absolute distance matches the minimum. For
# a nicer output, we sort the pairs that we keep by size, and in the end
# we sort the output by size as well.

use v5.36;

mad(4, 1, 2, 3);
mad(1, 3, 7, 11, 15);
mad(1, 5, 3, 8);

sub mad(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my $mad = abs($ints[0] - $ints[1]);
    my @output = ();
    foreach my $i (0..$#ints) {
        foreach my $j ($i+1..$#ints) {
            my $ad = abs($ints[$i] - $ints[$j]);
            $mad = $ad if $mad > $ad;
        }
    }
    foreach my $i (0..$#ints) {
        foreach my $j ($i+1..$#ints) {
            my $ad = abs($ints[$i] - $ints[$j]);
            if($ad == $mad) {
                push @output, $ints[$i] > $ints[$j] ? [$ints[$j], $ints[$i]] : [$ints[$i], $ints[$j]];
            }
        }
    }
    say "Output: " . join(", ", map { "[$_->[0], $_->[1]]" } sort { $a->[0] <=> $b->[0] } @output);
}
