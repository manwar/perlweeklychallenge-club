#!/usr/bin/env perl

# Task 1: Same String
# Submitted by: Mohammad S Anwar
# 
# You are given two arrays of strings.
# Write a script to find out if the word created by concatenating the array elements is the same.
#
# Example 1
# Input: @arr1 = ("ab", "c")
#        @arr2 = ("a", "bc")
# Output: true
# 
# Using @arr1, word1 => "ab" . "c" => "abc"
# Using @arr2, word2 => "a" . "bc" => "abc"
# 
# Example 2
# Input: @arr1 = ("ab", "c")
#        @arr2 = ("ac", "b")
# Output: false
# 
# Using @arr1, word1 => "ab" . "c" => "abc"
# Using @arr2, word2 => "ac" . "b" => "acb"
# 
# Example 3
# Input: @arr1 = ("ab", "cd", "e")
#        @arr2 = ("abcde")
# Output: true
# 
# Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
# Using @arr2, word2 => "abcde"

use strict;
use warnings;

my @strings = ([ ["ab", "c"],
                 ["a", "bc"]
               ],
               [ ["ab", "c"],
                 ["ac", "b"]
               ],
               [ ["ab", "cd", "e"],
                 ["abcde"]
               ]
              );
            

foreach my $arr (@strings) {
    my $str1 = join '', map { $_ }
                            @{$arr->[0]};
    my $str2 = join '', map { $_ }
                            @{$arr->[1]};
    printf "[%s] =? [%s] -> %s\n", (join ', ', map { sprintf '"%s"', $_ }
                                                 @{$arr->[0]}
                                   ),
                                   (join ', ', map { sprintf '"%s"', $_ }
                                                 @{$arr->[1]}
                                   ),
        ($str1 eq $str2)
            ? 'true'
            : 'false';
}
