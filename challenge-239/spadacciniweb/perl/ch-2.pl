#!/usr/bin/env perl

# You are given an array of strings and allowed string having distinct characters.
# 
#     A string is consistent if all characters in the string appear in the string allowed.
# 
# Write a script to return the number of consistent strings in the given array.
# 
# Example 1
# Input: @str = ("ad", "bd", "aaab", "baa", "badab")
#        $allowed = "ab"
# Output: 2
# 
# Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.
# 
# Example 2
# Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
#        $allowed = "abc"
# Output: 7
# 
# Example 3
# Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
#        $allowed = "cad"
# Output: 4
# 
# Strings "cc", "acd", "ac", and "d" are consistent.


use strict;
use warnings;
no warnings 'experimental::smartmatch';

my @strings = ([ ["ad", "bd", "aaab", "baa", "badab"],
                 "ab",
               ],
               [ ["a", "b", "c", "ab", "ac", "bc", "abc"],
                 "abc"
               ],
               [ ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"],
                 "cad"
               ]
              );
foreach my $arr (@strings) {
    my $times = 0;
    my @allowed = split //, $arr->[1];
    foreach my $word (@{$arr->[0]}) {
        my $right = 1;
        foreach my $letter (split //, $word) {
            unless ($letter ~~ @allowed) {
                $right = 0;
                last;
            }
        }
        $times++
            if $right;
    }
    printf "strings (%s) -> allowed %s \nOutput: %d\n",
        (join ', ', @{$arr->[0]}),
        $arr->[1],
        $times;
}
