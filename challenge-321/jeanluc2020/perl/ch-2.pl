#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/#TASK2
#
# Task 2: Backspace Compare
# =========================
#
# You are given two strings containing zero or more #.
#
# Write a script to return true if the two given strings are same by treating #
# as backspace.
#
## Example 1
##
## Input: $str1 = "ab#c"
##        $str2 = "ad#c"
## Output: true
##
## For first string,  we remove "b" as it is followed by "#".
## For second string, we remove "d" as it is followed by "#".
## In the end both strings became the same.
#
#
## Example 2
##
## Input: $str1 = "ab##"
##        $str2 = "a#b#"
## Output: true
#
#
## Example 3
##
## Input: $str1 = "a#b"
##        $str2 = "c"
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# As long as there's a # in the word following another character, we replce
# both the # character and the character before it. Once done on both characters,
# a simple string comparison shows whether the two strings are equal.

use v5.36;

backspace_compare( "ab#c", "ad#c" );
backspace_compare( "ab##", "a#b#" );
backspace_compare( "a#b", "c");

sub backspace_compare($str1, $str2) {
    say "\$str1 = $str1, \$str2 = $str2";
    while($str1 =~ m/[^#]#/) {
        $str1 =~ s/[^#]#//;
    }
    while($str2 =~ m/[^#]#/) {
        $str2 =~ s/[^#]#//;
    }
    if($str1 eq $str2) {
        say "Output: true";
    } else {
        say "Output: false";
    }
}
