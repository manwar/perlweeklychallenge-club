#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK1
#
# Task 1: Echo Chamber
# ====================
#
## Example 1
##
## Input: "abca"
## Output: "abbcccaaaa"
##
## Index 0: "a" -> repeated 1 time  -> "a"
## Index 1: "b" -> repeated 2 times -> "bb"
## Index 2: "c" -> repeated 3 times -> "ccc"
## Index 3: "a" -> repeated 4 times -> "aaaa"
#
#
## Example 2
##
## Input: "xyz"
## Output: "xyyzzz"
##
## Index 0: "x" -> "x"
## Index 1: "y" -> "yy"
## Index 2: "z" -> "zzz"
#
#
## Example 3
##
## Input: "code"
## Output: "coodddeeee"
##
## Index 0: "c" -> "c"
## Index 1: "o" -> "oo"
## Index 2: "d" -> "ddd"
## Index 3: "e" -> "eeee"
#
#
## Example 4
##
## Input: "hello"
## Output: "heelllllllooooo"
##
## Index 0: "h" -> "h"
## Index 1: "e" -> "ee"
## Index 2: "l" -> "lll"
## Index 3: "l" -> "llll"
## Index 4: "o" -> "ooooo"
#
#
## Example 5
##
## Input: "a"
## Output: "a"
##
## Index 0: "a" -> "a"
#
############################################################
##
## discussion
##
############################################################
#
# We pick every character and add it to the output the appropriate
# amount of times.

use v5.36;

echo_chamber("abca");
echo_chamber("xyz");
echo_chamber("code");
echo_chamber("hello");
echo_chamber("a");

sub echo_chamber($str) {
    say "Input: $str";
    my @chars = split //, $str;
    my $out = "";
    foreach my $i (1..$#chars+1) {
        $out .= $chars[$i-1] x $i;
    }
    say "Output: $out";
}

