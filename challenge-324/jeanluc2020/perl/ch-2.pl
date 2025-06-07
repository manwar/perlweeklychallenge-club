#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/#TASK2
#
# Task 2: Total XOR
# =================
#
# You are given an array of integers.
#
# Write a script to return the sum of total XOR for every subset of given
# array.
#
## Example 1
##
## Input: @ints = (1, 3)
## Output: 6
##
## Subset [1],    total XOR = 1
## Subset [3],    total XOR = 3
## Subset [1, 3], total XOR => 1 XOR 3 => 2
##
## Sum of total XOR => 1 + 3 + 2 => 6
#
#
## Example 2
##
## Input: @ints = (5, 1, 6)
## Output: 28
##
## Subset [5],       total XOR = 5
## Subset [1],       total XOR = 1
## Subset [6],       total XOR = 6
## Subset [5, 1],    total XOR => 5 XOR 1 => 4
## Subset [5, 6],    total XOR => 5 XOR 6 => 3
## Subset [1, 6],    total XOR => 1 XOR 6 => 7
## Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2
##
## Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28
#
#
## Example 3
##
## Input: @ints = (3, 4, 5, 6, 7, 8)
## Output: 480
#
############################################################
##
## discussion
##
############################################################
#
# First, we make sure that we have a set of unique elements,
# eliminating duplicates using List::Util's uniq().
# Then we create all possible subsets using Algorithm::Combinatorics'
# subsets() - we use the iterator interface so we don't eat
# unnecessary memory.
# For each subset, we then calculate the xor of this subset. For
# that, we start with 0, then we xor each element of the array to
# the current value until there are no more elements. Then we add
# that result to our current total value.
#

use v5.36;
use List::Util qw( uniq );
use Algorithm::Combinatorics qw( subsets );

total_xor(1, 3);
total_xor(5, 1, 6);
total_xor(3, 4, 5, 6, 7, 8);

sub total_xor( @ints ) {
    say "Input: (" . join(", ", @ints) . ")";
    my @set = uniq @ints;
    my $iter = subsets( \@ints );
    my $result = 0;
    while ( my $set = $iter->next ) {
        my $tmp = 0;
        foreach my $elem (@$set) {
            $tmp = $tmp ^ $elem;
        }
        $result += $tmp;
    }
    say "Output: $result";
}

