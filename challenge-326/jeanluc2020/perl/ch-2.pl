#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/#TASK2
#
# Task 2: Decompressed List
# =========================
#
# You are given an array of positive integers having even elements.
#
# Write a script to to return the decompress list. To decompress, pick adjacent
# pair (i, j) and replace it with j, i times.
#
## Example 1
##
## Input: @ints = (1, 3, 2, 4)
## Output: (3, 4, 4)
##
## Pair 1: (1, 3) => 3 one time  => (3)
## Pair 2: (2, 4) => 4 two times => (4, 4)
#
#
## Example 2
##
## Input: @ints = (1, 1, 2, 2)
## Output: (1, 2, 2)
##
## Pair 1: (1, 1) => 1 one time  => (1)
## Pair 2: (2, 2) => 2 two times => (2, 2)
#
#
## Example 3
##
## Input: @ints = (3, 1, 3, 2)
## Output: (1, 1, 1, 2, 2, 2)
##
## Pair 1: (3, 1) => 1 three times => (1, 1, 1)
## Pair 2: (3, 2) => 2 three times => (2, 2, 2)
#
############################################################
##
## discussion
##
############################################################
#
# Since perl v5.36 has the possibility to run foreach with two elements
# of a list at once, we use that neat feature to walk all pairs of
# $i and $j. Then we put $j into the result $i times.

use v5.36;
decompressed_list(1, 3, 2, 4);
decompressed_list(1, 1, 2, 2);
decompressed_list(3, 1, 3, 2);

sub decompressed_list( @ints ) {
    say "Input: (" . join(", ", @ints) . ")";
    my @output = ();
    foreach my ($i, $j) (@ints) {
        foreach my $k (1..$i) {
            push @output, $j;
        }
    }
    say "Output: (" . join(", ", @output) . ")";
}
