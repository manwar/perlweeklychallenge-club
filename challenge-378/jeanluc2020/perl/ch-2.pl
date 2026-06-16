#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-378/#TASK2
#
# Task 2: Sum of Words
# ====================
#
# You are given three strings consisting of lower case English letters ‘a’ to
# ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.
#
# Write a script to find if sum of first two strings return the third string.
#
## Example 1
##
## Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
## Output: true
##
## $str1 = "acb" = 021
## $str2 = "cba" = 210
## $str3 = "cdb" = 231
## $str1 + $str2 = $str3
#
## Example 2
##
## Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
## Output: true
##
## $str1 = "aab" = 001
## $str2 = "aac" = 002
## $str3 = "ad"  = 03
#
## Example 3
##
## Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
## Output: false
##
## $str1 = "bc" = 12
## $str2 = "je" = 94
## $str3 = "jg" = 96
#
## Example 4
##
## Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
## Output: true
##
## $str1 = "a"    = 0
## $str2 = "aaaa" = 0000
## $str3 = "aa"   = 00
#
## Example 5
##
## Input: $str1 = "c", $str2 = "d", $str3 = "h"
## Output: false
##
## $str1 = "c" = 2
## $str2 = "d" = 3
## $str3 = "h" = 7
#
## Example 6
##
## Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
## Output: true
##
## $str1 =  "gfi" =  658
## $str2 =  "hbf" =  715
## $str3 = "bdhd" = 1373
#
############################################################
##
## discussion
##
############################################################
#
# We are bold enough to just skip leading 0's by turning a
# simple string->number conversion into a "for each digit,
# multiply by 10, then add the next digit" loop that starts
# with 0. That also avoids accidental interpretation of a
# number with leading zeroes as octal.

use v5.36;

sum_of_words("acb", "cba", "cdb");
sum_of_words("aab", "aac", "ad");
sum_of_words("bc", "je", "jg");
sum_of_words("a", "aaaa", "aa");
sum_of_words("c", "d", "h");
sum_of_words("gfi", "hbf", "bdhd");

sub sum_of_words($str1, $str2, $str3) {
    say "Input: \"$str1\", \"$str2\", \"$str3\"";
    my $num1 = str_to_num($str1);
    my $num2 = str_to_num($str2);
    my $num3 = str_to_num($str3);
    if ($num1 + $num2 == $num3) {
        say "Output: true";
    } else {
        say "Output: false";
    }
}

sub str_to_num($str) {
    my $num = 0;
    foreach my $char (split //, $str) {
        $num *= 10;
        $num += (ord($char) - 97);
    }
    return $num;
}
