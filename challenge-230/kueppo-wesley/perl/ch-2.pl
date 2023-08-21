#!/usr/bin/env perl

# You are given an array of words made up of alphabetic characters and a prefix.
# 
# Write a script to return the count of words that starts with the given prefix.
# 
# Example 1
# Input: @words  = ("pay", "attention", "practice", "attend")
#        $prefix = "at"
#        Ouput: 2
# 
# Two words "attention" and "attend" starts with the given prefix "at".
#
# Example 2
#  Input: @words  = ("janet", "julia", "java", "javascript")
#         $prefix = "ja"
#         Ouput: 3
# 
# Three words "janet", "java" and "javascripr" starts with the given prefix "ja".

use strict;
use warnings;
use feature qw(signatures);

use Test::More;

sub match($words, $prefix) {
   return scalar grep { /^\Q$prefix\E/ } @$words;
}

is(match(["pay", "attention", "practice", "attend"], "at"), 2, "ok?");
is(match(["janet", "julia", "java", "javascript"], "ja"), 3, "ok?");

done_testing(2);
