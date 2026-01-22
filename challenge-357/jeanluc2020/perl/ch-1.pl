#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK1
#
# Task 1: Kaprekar Constant
# =========================
#
# Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.
## Example 1
##
## Input: $int = 3524
## Output: 3
##
## Iteration 1: 5432 - 2345 = 3087
## Iteration 2: 8730 - 0378 = 8352
## Iteration 3: 8532 - 2358 = 6174
#
#
## Example 2
##
## Input: $int = 6174
## Output: 0
#
#
## Example 3
##
## Input: $int = 9998
## Output: 5
##
## Iteration 1: 9998 - 8999 = 0999
## Iteration 2: 9990 - 0999 = 8991
## Iteration 3: 9981 - 1899 = 8082
## Iteration 4: 8820 - 0288 = 8532
## Iteration 5: 8532 - 2358 = 6174
#
#
## Example 4
##
## Input: $int = 1001
## Output: 4
##
## Iteration 1: 1100 - 0011 = 1089
## Iteration 2: 9810 - 0189 = 9621
## Iteration 3: 9621 - 1269 = 8352
## Iteration 4: 8532 - 2358 = 6174
#
#
## Example 5
##
## Input: $int = 9000
## Output: 4
##
## Iteration 1: 9000 - 0009 = 8991
## Iteration 2: 9981 - 1899 = 8082
## Iteration 3: 8820 - 0288 = 8532
## Iteration 4: 8532 - 2358 = 6174
#
#
## Example 6
##
## Input: $int = 1111
## Output: -1
##
## The sequence does not converge on 6174, so return -1.
#
############################################################
##
## discussion
##
############################################################
#
# First, we check a few basic parameters and catch the case of
# 6174 as input. Then we run through a loop where we calculate
# the next number until we finally reach 6174, keeping track
# of the amount of steps until we reach that point.
#
use v5.36;

kaprekar_constant(3524);
kaprekar_constant(6174);
kaprekar_constant(9998);
kaprekar_constant(1001);
kaprekar_constant(9000);
kaprekar_constant(1111);

sub kaprekar_constant($int) {
    say "Input: $int";
    return say "Not 4 digits: $int" unless length($int) == 4;
    return say "Output: 0" if $int == 6174;
    my $count = 0;
    while($int != 6174) {
        my @sorted = sort {$a <=> $b} split //, $int;
        my @sorted_r = reverse @sorted;
        my $s = join("", @sorted);
        my $s_r = join("", @sorted_r);
        # by sort order, $s is <= $s_r
        return say "Output: -1: $s = $s_r" if $s eq $s_r;
        $s =~ s/^0*//;
        $int = sprintf("%04d", $s_r - $s);
        $count++;
    }
    say "Output: $count";
}
