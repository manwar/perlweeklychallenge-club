#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/#TASK1
#
# Task 1: Missing Integers
# ========================
#
# You are given an array of n integers.
#
# Write a script to find all the missing integers in the range 1..n in the
# given array.
#
## Example 1
##
## Input: @ints = (1, 2, 1, 3, 2, 5)
## Output: (4, 6)
##
## The given array has 6 elements.
## So we are looking for integers in the range 1..6 in the given array.
## The missing integers: (4, 6)
#
#
## Example 2
##
## Input: @ints = (1, 1, 1)
## Output: (2, 3)
#
#
## Example 3
##
## Input: @ints = (2, 2, 1)
## Output: (3)
#
############################################################
##
## discussion
##
############################################################
#
# We turn each element in the input into a key of a hash. Then
# we walk from 1 to n, and if that number is not in the hash,
# we simply add it to the output list.

use v5.36;

missing_integers(1, 2, 1, 3, 2, 5);
missing_integers(1, 1, 1);
missing_integers(2, 2, 1);

sub missing_integers (@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my @output = ();
    my %map = map { $_ => 1 } @ints;
    foreach my $i (1..$#ints+1) {
        push @output, $i unless $map{$i};
    }
    say "Output: (" . join(", ", @output) . ")";
}
