#!/usr/bin/env perl

# Challenge 296
#
# Task 2: Matchstick Square
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to find if it is possible to make one square using the sticks as in the given array @ints where $ints[ì] is the length of ith stick.
#
# Example 1
# Input: @ints = (1, 2, 2, 2, 1)
# Output: true
#
# Top: $ints[1] = 2
# Bottom: $ints[2] = 2
# Left: $ints[3] = 2
# Right: $ints[0] and $ints[4] = 2
# Example 2
# Input: @ints = (2, 2, 2, 4)
# Output: false
# Example 3
# Input: @ints = (2, 2, 2, 2, 4)
# Output: false
# Example 4
# Input: @ints = (3, 4, 1, 4, 3, 1)
# Output: true

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
say can_make_square(@ARGV) ? "true" : "false";

sub can_make_square {
    my @sticks = sort { $b <=> $a } @_;   # largest first
    my $sum = sum(@sticks);

    return 0 if $sum % 4 != 0;  # must use all sticks
    my $side = $sum / 4;

    return 0 if $sticks[0] > $side;

    my @sides = (0, 0, 0, 0);

    my $dfs;   # declare first so recursion works
    $dfs = sub {
        my ($i) = @_;
        return 1 if $i == @sticks;   # all sticks placed

        my $len = $sticks[$i];

        for my $s (0..3) {
            next if $sides[$s] + $len > $side;

            # symmetry pruning: skip identical states
            next if $s > 0 && $sides[$s] == $sides[$s-1];

            $sides[$s] += $len;
            return 1 if $dfs->($i+1);
            $sides[$s] -= $len;

            # if we tried an empty side and failed, don't try other empty sides
            last if $sides[$s] == 0;
        }

        return 0;
    };

    return $dfs->(0);
}
