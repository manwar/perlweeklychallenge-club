#!/usr/bin/env perl

# Challenge 064
#
# TASK #2 › Word Break
# Submitted by: Mohammad S Anwar
#
# You are given a string $S and an array of words @W.
#
# Write a script to find out if $S can be split into sequence of one or more
# words as in the given @W.
#
# Print the all the words if found otherwise print 0.
#
# Example 1:
# Input:
#
# $S = "perlweeklychallenge"
# @W = ("weekly", "challenge", "perl")
#
# Output:
#
# "perl", "weekly", "challenge"
# Example 2:
# Input:
#
# $S = "perlandraku"
# @W = ("python", "ruby", "haskell")
#
# Output:
#
# 0 as none matching word found.

use Modern::Perl;
use Math::Combinatorics 'combine';
use Test::More;

is word_break("perlweeklychallenge", "weekly", "challenge", "perl"),
              "weekly challenge perl";
is word_break("perlandraku", "python", "ruby", "haskell"),
              "0";
done_testing;


sub word_break {
    my($S, @W) = @_;
    my $k = scalar(@W);
    for (combine($k, @W)) {
        my @words = @$_;
        if (join('', @words) eq $S) {
            return "@W";
        }
    }
    return "0";
}
