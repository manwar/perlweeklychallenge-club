#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-328/#TASK2
#
# Task 2: Good String
# ===================
#
# You are given a string made up of lower and upper case English letters only.
#
# Write a script to return the good string of the given string. A string is
# called good string if it doesn’t have two adjacent same characters, one in
# upper case and other is lower case.
#
## Example 1
##
## Input: $str = "WeEeekly"
## Output: "Weekly"
##
## We can remove either, "eE" or "Ee" to make it good.
#
#
## Example 2
##
## Input: $str = "abBAdD"
## Output: ""
##
## We remove "bB" first: "aAdD"
## Then we remove "aA": "dD"
## Finally remove "dD".
#
#
## Example 3
##
## Input: $str = "abc"
## Output: "abc"
#
############################################################
##
## discussion
##
############################################################
#
# As long as we have two adjacent same characters, one in upper and
# one in lower case, we remove that part from the string. What remains
# in the end is the good string.

use v5.36;

good_string("WeEeekly");
good_string("abBAdD");
good_string("abc");

sub good_string($str) {
    say "Input: $str";
    my $found = 1;
    while($found) {
        $found = 0;
        foreach my $c ("a".."z") {
            my $C = uc($c);
            if($str =~ m/$c$C/) {
                $str =~ s/$c$C//;
                $found = 1;
            }
            if($str =~ m/$C$c/) {
                $str =~ s/$C$c//;
                $found = 1;
            }
        }
    }
    say "Output: $str";
}
