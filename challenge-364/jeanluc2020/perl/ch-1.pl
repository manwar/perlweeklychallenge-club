#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK1
#
# Task 1: Decrypt String
# ======================
#
# You are given a string formed by digits and ‘#'.
#
# Write a script to map the given string to English lowercase characters
# following the given rules.
#
## - Characters 'a' to 'i' are represented by '1' to '9' respectively.
## - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.
#
## Example 1
##
## Input: $str = "10#11#12"
## Output: "jkab"
##
## 10# -> j
## 11# -> k
## 1   -> a
## 2   -> b
#
## Example 2
##
## Input: $str = "1326#"
## Output: "acz"
##
## 1   -> a
## 3   -> c
## 26# -> z
#
## Example 3
##
## Input: $str = "25#24#123"
## Output: "yxabc"
##
## 25# -> y
## 24# -> x
## 1   -> a
## 2   -> b
## 3   -> c
#
## Example 4
##
## Input: $str = "20#5"
## Output: "te"
##
## 20# -> t
## 5   -> e
#
## Example 5
##
## Input: $str = "1910#26#"
## Output: "aijz"
##
## 1   -> a
## 9   -> i
## 10# -> j
## 26# -> z
#
############################################################
##
## discussion
##
############################################################
#
# As long as we have two digits in front of a "#" at the beginning
# of $str, we pick those two digits, add 96 and call chr() on the
# result (because "a" is ASCII 97 and we start counting at 1). If
# $str doesn't start in two digits and "#", then we pick the first
# digits, add 96 and hand the result to chr(). We do that until
# there is nothing left in $str.

use v5.36;

decrypt_string("10#11#12");
decrypt_string("1326#");
decrypt_string("25#24#123");
decrypt_string("20#5");
decrypt_string("1910#26#");

sub decrypt_string($str) {
    say "Input: \"$str\"";
    my $result = "";
    while(length($str)) {
        if($str =~ m/(^\d\d)#/) {
            $result .= chr(96+$1);
            $str =~ s/...//;
        } else {
            $result .= chr(96+ substr($str,0,1,""));
        }
    }
    say "Output: \"$result\"";
}
