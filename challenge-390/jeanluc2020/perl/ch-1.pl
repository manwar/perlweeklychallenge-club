#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-390/#TASK1
#
# Task 1: Decode String
# =====================
#
# You are given an encoded string.
#
# Write a script to return the decoded string of the given encoded string.
#
##    The encoding rule is: K[encoded_string], where the encoded_string inside
##    the square brackets is repeated exactly K > 0 times.
#
## Example 1
##
## Input: $str = "2[3[a]]"
## Output: "aaaaaa"
##
## 3[a]    => aaa
## 2[3[a]] => aaa aaa
#
## Example 2
##
## Input: $str = "10[a]"
## Output: "aaaaaaaaaa"
#
## Example 3
##
## Input: $str = "a2[b]c3[d]e"
## Output: "abbcddde"
#
## Example 4
##
## Input: $str = "2[a2[b]c]"
## Output: "abbcabbc"
#
## Example 5
##
## Input: $str = "1[a]2[b3[c]]"
## Output: "abcccbccc"
#
############################################################
##
## discussion
##
############################################################
#
# We replace all K[str] parts from the inside out by making sure
# we have only strings without any [ or ] inside. The rest is
# just perl's amazing s///e in action so we can call a function
# to calculate the replacement in each step.

use v5.36;

decode_string("2[3[a]]");
decode_string("10[a]");
decode_string("a2[b]c3[d]e");
decode_string("2[a2[b]c]");
decode_string("1[a]2[b3[c]]");

sub decode_string($str) {
    say "Input: \"$str\"";
    while($str =~ m/\[/) {
        $str =~ s/(\d+)\[([^\[\]]*)\]/dec("$1","$2")/e;
    }
    say "Output: \"$str\"";
}

sub dec($count, $str) {
    my $result = "";
    while($count-- > 0) {
        $result .= $str;
    }
    return $result;
}
