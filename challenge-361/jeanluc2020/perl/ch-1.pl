#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK1
#
# Task 1: Zeckendorf Representation
# =================================
#
# You are given a positive integer (<= 100).
#
# Write a script to return Zeckendorf Representation of the given integer.
#
### Every positive integer can be uniquely represented as sum of
### non-consecutive Fibonacci numbers.
#
## Example 1
##
## Input: $int = 4
## Output: 3,1
##
## 4 => 3 + 1 (non-consecutive fibonacci numbers)
#
#
## Example 2
##
## Input: $int = 12
## Output: 8,3,1
##
## 12 => 8 + 3 + 1
#
#
## Example 3
##
## Input: $int = 20
## Output: 13,5,2
##
## 20 => 13 + 5 + 2
#
#
## Example 4
##
## Input: $int = 96
## Output: 89,5,2
##
## 96 => 89 + 5 + 2
#
#
## Example 5
##
## Input: $int = 100
## Output: 89,8,3
##
## 100 => 89 + 8 + 3
#
############################################################
##
## discussion
##
############################################################
#
# We precalculate the necessary fibonacci numbers. Then we start
# at the higher end, and remove the biggest possible fibonacci number,
# skip one of the numbers, and continue there, until the remainder
# is zero.

use v5.36;

zeckendorf_representation(4);
zeckendorf_representation(12);
zeckendorf_representation(20);
zeckendorf_representation(96);
zeckendorf_representation(100);

sub zeckendorf_representation($int) {
    say "Input: $int";
    my @fib = fib(100);
    my $i = $#fib;
    my @elems = ();
    while($fib[$i] > $int) {
        $i--;
        if($fib[$i] <= $int) {
            push @elems, $fib[$i];
            $int -= $fib[$i];
            last if $int == 0;
            $i--;
        }
    }
    say "Output: (" . join(", ", @elems) . ")";
}

sub fib($max) {
    my @numbers = (1, 1);
    my $i = 1;
    while($numbers[$i] < $max) {
        push @numbers, $numbers[$i-1] + $numbers[$i];
        $i++;
    }
    return @numbers;
}
