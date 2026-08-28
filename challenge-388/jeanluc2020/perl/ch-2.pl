#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-388/#TASK2
#
# Task 2: Secret Santa
# ====================
#
# A company with $n employees is running a Secret Santa exchange. Each employee
# buys one gift and receives one gift.
#
# Write a script to return the total number of valid gift assignments where no
# employee receives the gift they originally bought (i.e., employee $i must not
# be assigned gift $i).
#
## Example 1
##
## Input: $n = 1
## Output: 0
##
## Only 1 participant exists. They would have to receive their own gift, which is invalid.
#
## Example 2
##
## Input: $n = 2
## Output: 1
##
## Participants 1 and 2 must swap gifts ([2, 1]).
#
## Example 3
##
## Input: $n = 3
## Output: 2
##
## The 2 valid gift arrays where array[i] is who person i+1 receives from:
## [2, 3, 1]
## [3, 1, 2]
#
## Example 4
##
## Input: $n = 4
## Output: 9
##
## The 9 valid arrays are:
## [2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
## [3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
## [4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],
#
## Example 5
##
## Input: $n = 5
## Output: 44
##
## There are 44 valid permutations out of 5! = 120 total possible arrangements.
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible permutations of the numbers 1..$n.
# Then we count the valid ones.

use v5.36;
use Algorithm::Combinatorics qw(permutations);

sub secret_santa($n) {
    say "Input: $n";
    my $result = 0;
    my @input = (1..$n);
    foreach my $permutation (permutations(\@input)) {
        $result += is_valid($permutation);
    }
    say "Output: $result";
}

sub is_valid($permutation) {
    my @p = @$permutation;
    foreach my $i (0..$#p) {
        return 0 if $p[$i] == $i+1;
    }
    return 1;
}

secret_santa(1);
secret_santa(2);
secret_santa(3);
secret_santa(4);
secret_santa(5);
