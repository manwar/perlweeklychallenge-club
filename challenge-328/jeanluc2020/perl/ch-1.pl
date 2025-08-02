#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-328/#TASK1
#
# Task 1: Replace all ?
# =====================
#
# You are given a string containing only lower case English letters and ?.
#
# Write a script to replace all ? in the given string so that the string
# doesn’t contain consecutive repeating characters.
#
## Example 1
##
## Input: $str = "a?z"
## Output: "abz"
##
## There can be many strings, one of them is "abz".
## The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'.
#
#
## Example 2
##
## Input: $str = "pe?k"
## Output: "peak"
#
#
## Example 3
##
## Input: $str = "gra?te"
## Output: "grabte"
#
############################################################
##
## discsussion
##
############################################################
#
# Starting from left to right, we pick each "?" and try to replace it.
# For that, we walk the characters from a to z, and if we find one that
# works, we use it right away.

use v5.36;

replace_all("a?z");
replace_all("pe?k");
replace_all("gra?te");
replace_all("gra?te");
replace_all("?bc");
replace_all("ab?");
replace_all("ab?a");
replace_all("ab???");
replace_all("???a");

sub replace_all($str) {
    say "Input: $str";
    my @chars = split //, $str;
    foreach my $i (0..$#chars) {
        if($chars[$i] eq "?") {
            foreach my $c ("a".."z") {
                my $ok = 1;
                if($i != 0) {
                    if($chars[$i-1] eq $c) {
                        $ok = 0;
                    }
                }
                if($i != $#chars) {
                    if($chars[$i+1] eq $c) {
                        $ok = 0;
                    }
                }
                if($ok) {
                    $chars[$i] = $c;
                    last;
                }
            }
        }
    }
    my $output = join("",@chars);
    say "Output: $output";
}
