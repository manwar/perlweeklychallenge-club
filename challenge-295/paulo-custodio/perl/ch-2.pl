#!/usr/bin/env perl

# Challenge 295
#
# Task 2: Jump Game
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to find the minimum number of jumps to reach the last element. $ints[$i] represents the maximum length of a forward jump from the index $i. In case last element is unreachable then return -1.
#
# Example 1
# Input: @ints = (2, 3, 1, 1, 4)
# Output: 2
#
# Jump 1 step from index 0 then 3 steps from index 1 to the last element.
# Example 2
# Input: @ints = (2, 3, 0, 4)
# Output: 2
# Example 3
# Input: @ints = (2, 0, 0, 4)
# Output: -1

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums\n";
say min_jumps(@ARGV);

sub min_jumps {
    my(@jumps) = @_;

    my $min_jumps = 1e10;
    my $found_solution = 0;

    my $try_jump;
    $try_jump = sub {
        my($prev_jumps, $pos) = @_;
        if ($pos == $#jumps) {
            # found the target
            $found_solution = 1;
            $min_jumps = min($min_jumps, $prev_jumps);
        }
        elsif ($pos > $#jumps) {
            # missed the target
        }
        elsif ($prev_jumps > $min_jumps) {
            # path too long
        }
        else {
            # try each jump
            for my $jump (1 .. $jumps[$pos]) {
                $try_jump->($prev_jumps+1, $pos+$jump);
            }
        }
    };

    $try_jump->(0, 0);

    return $found_solution ? $min_jumps : -1;
}
