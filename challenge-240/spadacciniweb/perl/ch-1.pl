#!/usr/bin/env perl

# Task 1: Acronym
# Submitted by: Mohammad S Anwar
# 
# You are given an array of strings and a check string.
# Write a script to find out if the check string is the acronym of the words in the given array.
# 
# Example 1
# Input: @str = ("Perl", "Python", "Pascal")
#        $chk = "ppp"
# Output: true
# 
# Example 2
# Input: @str = ("Perl", "Raku")
#        $chk = "rp"
# Output: false
# 
# Example 3
# Input: @str = ("Oracle", "Awk", "C")
#        $chk = "oac"
# Output: true

use strict;
use warnings;

my @arrays = ([ ["Perl", "Python", "Pascal"],
                 "ppp"
              ],
              [ ["Perl", "Raku"],
                "rp"
              ],
              [ ["Oracle", "Awk", "C"],
                "oac"
              ]
             );
            

foreach my $strings (@arrays) {
    my $str1 = join '', map { lc(substr $_, 0, 1) }
                            @{$strings->[0]};
    printf "[%s] acronym? '%s' -> %s\n", (join ', ', map { sprintf '"%s"', $_ }
                                                 @{$strings->[0]}
                                         ),
                                         $strings->[1],
        ($str1 eq $strings->[1])
            ? 'true'
            : 'false';
}
