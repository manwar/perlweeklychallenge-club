#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/#TASK2
#
# Task 2: Nice String
# ===================
#
# You are given a string made up of lower and upper case English letters only.
#
# Write a script to return the longest substring of the give string which is
# nice. A string is nice if, for every letter of the alphabet that the string
# contains, it appears both in uppercase and lowercase.
#
## Example 1
##
## Input: $str = "YaaAho"
## Output: "aaA"
#
#
## Example 2
##
## Input: $str = "cC"
## Output: "cC"
#
#
## Example 3
##
## Input: $str = "A"
## Output: ""
##
## No nice string found.
#
############################################################
##
## discussion
##
############################################################
#
# For each character in $str, we use the lowercase character of it
# as the key in a hash. There we keep track of each character that
# we have seen so far whether it was in lower, upper or both cases.
# In the end, we walk the characters from $str again and just keep
# the ones for which we have seen both the lower and upper case
# variant.

use v5.36;

nice_string("YaaAho");
nice_string("cC");
nice_string("A");

sub nice_string($str) {
    say "Input: \"$str\"";
    my @chars = split //, $str;
    my $seen = {};
    my $result = "";
    foreach my $char (@chars) {
        if($char =~ m/[a-z]/) {
            $seen->{$char}->{lc} = 1;
        } else {
            $seen->{lc($char)}->{uc} = 1;
        }
    }
    foreach my $char (@chars) {
        if($seen->{lc($char)}->{lc} && $seen->{lc($char)}->{uc}) {
            $result .= $char;
        }
    }
    say "Output: \"$result\"";
}

