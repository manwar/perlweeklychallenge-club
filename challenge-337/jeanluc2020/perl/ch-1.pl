#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-337/#TASK1
#
# Task 1: Smaller Than Current
# ============================
#
# You are given an array of numbers, @num1.
#
# Write a script to return an array, @num2, where $num2[i] is the count of all
# numbers less than or equal to $num1[i].
#
## Example 1
##
## Input: @num1 = (6, 5, 4, 8)
## Output: (2, 1, 0, 3)
##
## index 0: numbers <= 6 are 5, 4    => 2
## index 1: numbers <= 5 are 4       => 1
## index 2: numbers <= 4, none       => 0
## index 3: numbers <= 8 are 6, 5, 4 => 3
#
#
## Example 2
##
## Input: @num1 = (7, 7, 7, 7)
## Output: (3, 3, 3, 3)
#
#
## Example 3
##
## Input: @num1 = (5, 4, 3, 2, 1)
## Output: (4, 3, 2, 1, 0)
#
#
## Example 4
##
## Input: @num1 = (-1, 0, 3, -2, 1)
## Output: (1, 2, 4, 0, 3)
#
#
## Example 5
##
## Input: @num1 = (0, 1, 1, 2, 0)
## Output: (1, 3, 3, 4, 1)
#
############################################################
##
## discussion
##
############################################################
#
# First, we generate a descendingly sorted copy of @num1. Then, for
# each element of @num1, we search for the first element inside
# the sorted copy that is equal to the current number. From there we can
# calculate the number of elements that are less than or equal to the
# number by substracting the current index from the index of the last
# element in the sorted list.

use v5.36;
use Data::Dumper;

smaller_than_current(6, 5, 4, 8);
smaller_than_current(7, 7, 7, 7);
smaller_than_current(5, 4, 3, 2, 1);
smaller_than_current(-1, 0, 3, -2, 1);
smaller_than_current(0, 1, 1, 2, 0);

sub smaller_than_current( @num1 ) {
    say "Input: (" . join(", ", @num1) . ")";
    my @numsorted = sort { $b <=> $a } @num1;
    my @num2 = ();
    foreach my $n (@num1) {
        foreach my $i (0..$#numsorted) {
            if($n == $numsorted[$i]) {
                push @num2, $#numsorted-$i;
                last;
            }
        }
    }

    say "Output: (" . join(", ", @num2) . ")";
}

