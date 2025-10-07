#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-342/#TASK1
#
# Task 1: Balance String
# ======================
#
# You are given a string made up of lowercase English letters and digits only.
#
# Write a script to format the give string where no letter is followed by
# another letter and no digit is followed by another digit. If there are
# multiple valid rearrangements, always return the lexicographically smallest
# one. Return empty string if it is impossible to format the string.
#
## Example 1
##
## Input: $str = "a0b1c2"
## Output: "0a1b2c"
#
#
## Example 2
##
## Input: $str = "abc12"
## Output: "a1b2c"
#
#
## Example 3
##
## Input: $str = "0a2b1c3"
## Output: "0a1b2c3"
#
#
## Example 4
##
## Input: $str = "1a23"
## Output: ""
#
#
## Example 5
##
## Input: $str = "ab123"
## Output: "1a2b3"
#
############################################################
##
## discussion
##
############################################################
#
# First, we split $str into its parts. Then we pick all the digits
# into one array and all characters into another one - both of these
# arrays sorted. If one of the arrays is longer by more than 1 than
# the other array, there is no solution, so we return the empty
# string. Otherwise we take turns picking elements from each array.

use v5.36;

balance_string("a0b1c2");
balance_string("abc12");
balance_string("0a2b1c3");
balance_string("1a23");
balance_string("ab123");

sub balance_string($str) {
    say "Input: $str";

    my @parts = split //, $str;
    my @digits = sort grep { m/\d/ } @parts;
    my @chars = sort grep { ! m/\d/ } @parts;
    my (@first, @second);

    my $d = scalar @digits;
    my $c = scalar @chars;
    my $result = "";

    return say "Output: \"\"" if abs($d - $c) > 1;

    # We pick the first element from the longer array first,
    # or a digit if the arrays share the same length
    if($d >= $c) {
        @first = @digits;
        @second = @chars;
    } else {
        @first = @chars;
        @second = @digits;
    }

    # pick one element from each array
    while(@first) {
        $result .= shift @first;
        $result .= shift @second if @second;
    }

    say "Output: $result";
}
