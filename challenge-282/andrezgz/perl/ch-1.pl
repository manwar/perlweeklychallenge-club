#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
# Task #1 > Good Integer
#
# You are given a positive integer, $int, having 3 or more digits.
#
# Write a script to return the Good Integer in the given integer or -1 if none found.
#
# A good integer is exactly three consecutive matching digits.

# Example 1
# Input: $int = 12344456
# Output: "444"
# Example 2
# Input: $int = 1233334
# Output: -1
# Example 3
# Input: $int = 10020003
# Output: "000"

use strict;
use warnings;
use feature 'say';

use constant N => 3;

my $str = shift;
say good_integer($str);
exit 0;

sub good_integer {
    my $int = shift;
    # match a sequence of consecutive equal digits,
    # capturing the first one, and the one after the sequence
    while ($int =~ /(\d)\1+(\d?)/) {
        # distance between the captured digits
        my $d = $-[2] - $-[1];
        # if the distance is N, return the sequence
        return $1 x N if $d == N;
        # otherwise, remove these digits and try again
        $int = substr $int, $d;
    }
    return -1;
}
