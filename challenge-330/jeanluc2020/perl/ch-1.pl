#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/#TASK1
#
# Task 1: Clear Digits
# ====================
#
# You are given a string containing only lower case English letters and digits.
#
# Write a script to remove all digits by removing the first digit and the
# closest non-digit character to its left.
#
## Example 1
##
## Input: $str = "cab12"
## Output: "c"
##
## Round 1: remove "1" then "b" => "ca2"
## Round 2: remove "2" then "a" => "c"
#
#
## Example 2
##
## Input: $str = "xy99"
## Output: ""
##
## Round 1: remove "9" then "y" => "x9"
## Round 2: remove "9" then "x" => ""
#
#
## Example 3
##
## Input: $str = "pa1erl"
## Output: "perl"
#
############################################################
##
## discussion
##
############################################################
#
# Long description short, as long as there is still a non-digit
# before a digit, remove those two characters.
# Note: If the string starts with a digit, but then has other characters before
# other digits, this will still remove the later digit. It's not 100% clear
# whether this is an allowed input though.

use v5.36;

clear_digits("cab12");
clear_digits("xy99");
clear_digits("pa1erl");

sub clear_digits($str) {
    say "Input: \"$str\"";
    while($str =~ s/[^\d]\d//) {
    }
    say "Output: \"$str\"";
}
