#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-311/#TASK1
#
# Task 1: Upper Lower
# ===================
#
# You are given a string consists of english letters only.
#
# Write a script to convert lower case to upper and upper case to lower in the
# given string.
#
## Example 1
##
## Input: $str = "pERl"
## Output: "PerL"
#
## Example 2
##
## Input: $str = "rakU"
## Output: "RAKu"
#
## Example 3
##
## Input: $str = "PyThOn"
## Output: "pYtHoN"
#
############################################################
##
## discussion
##
############################################################
#
# The tr/// operator allows us to swap in one step, so let's
# just use that.


use v5.36;

foreach ( qw(pERl rakU PyThOn) ) {
        say "Input: $_, Output: " . upper_lower($_);
}

sub upper_lower {
        my $str = shift;
        $str =~ tr/a-zA-Z/A-Za-z/;
        return $str;
}

