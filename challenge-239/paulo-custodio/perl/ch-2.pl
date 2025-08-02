#!/usr/bin/env perl

# Challenge 239
#
# Task 2: Consistent Strings
# Submitted by: Mohammad S Anwar
#
# You are given an array of strings and allowed string having distinct characters.
#
#     A string is consistent if all characters in the string appear in the string
#     allowed.
#
#
# Write a script to return the number of consistent strings in the given array.
# Example 1
#
# Input: @str = ("ad", "bd", "aaab", "baa", "badab")
#        $allowed = "ab"
# Output: 2
#
# Strings "aaab" and "baa" are consistent since they only contain characters
# 'a' and 'b'.
#
# Example 2
#
# Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
#        $allowed = "abc"
# Output: 7
#
# Example 3
#
# Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
#        $allowed = "cad"
# Output: 4
#
# Strings "cc", "acd", "ac", and "d" are consistent.

use Modern::Perl;

my($allowed, @strs) = @ARGV;
say scalar grep {is_consistent($_, $allowed)} @strs;

sub is_consistent {
    my($str, $allowed) = @_;
    for my $ch (split //, $allowed) {
        $str =~ s/$ch//ig;
    }
    return $str eq '';
}
