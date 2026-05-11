#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-373/#TASK1
#
# Task 1: Equal List
# ==================
#
# You are given two arrays of strings.
#
# Write a script to return true if the two given array represent the same
# strings otherwise false.
#
## Example 1
##
## Input: @arr1 = ("a", "bc")
##        @arr2 = ("ab", "c")
## Output: true
##
## Array 1: "a" + "bc" = "abc"
## Array 2: "ab" + "c" = "abc"
#
## Example 2
##
## Input: @arr1 = ("a", "b", "c")
##        @arr2 = ("a", "bc")
## Output: true
##
## Array 1: "a" + "b" + "c" = "abc"
## Array 2: "a" + "bc" = "abc"
#
## Example 3
##
## Input: @arr1 = ("a", "bc")
##        @arr2 = ("a", "c", "b")
## Output: false
##
## Array 1: "a" + "bc" = "abc"
## Array 2: "a" + "c" + "b" = "acb"
#
## Example 4
##
## Input: @arr1 = ("ab", "c", "")
##        @arr2 = ("", "a", "bc")
## Output: true
##
## Array 1: "ab" + "c" + "" = "abc"
## Array 2: ""  + "a" + "bc" = "abc"
#
## Example 5
##
## Input: @arr1 = ("p", "e", "r", "l")
##        @arr2 = ("perl")
## Output: true
##
## Array 1: "p" + "e" + "r" + "l" = "perl"
## Array 2: "perl"
#
############################################################
##
## discussion
##
############################################################
#
# We just need to join the elements of each array into a string. Then
# we compare the strings to see whether they are the same.
#
use v5.36;

equal_list(["a", "bc"], ["ab", "c"]);
equal_list(["a", "b", "c"], ["a", "bc"]);
equal_list(["a", "bc"], ["a", "c", "b"]);
equal_list(["ab", "c", ""], ["", "a", "bc"]);
equal_list(["p", "e", "r", "l"], ["perl"]);

sub equal_list($arr1, $arr2) {
    say "Input: (\"" . join("\", \"", @$arr1) . "\"), (\"" . join("\", \"", @$arr2) . "\")";
    my $str1 = join("", @$arr1);
    my $str2 = join("", @$arr2);
    if($str1 eq $str2) {
        say "Output: true";
    } else {
        say "Output: false";
    }
}
