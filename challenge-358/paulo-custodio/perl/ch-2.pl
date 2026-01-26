#!/usr/bin/env perl

# Challenge 358
#
# Task 2: Encrypted String
# Submitted by: Mohammad Sajid Anwar
# You are given a string $str and an integer $int.
#
# Write a script to encrypt the string using the algorithm - for each character $char in $str, replace $char with the $int th character after $char in the alphabet, wrapping if needed and return the encrypted string.
#
# Example 1
# Input: $str = "abc", $int = 1
# Output: "bcd"
#
# Example 2
# Input: $str = "xyz", $int = 2
# Output: "zab"
#
# Example 3
# Input: $str = "abc", $int = 27
# Output: "bcd"
#
# Example 4
# Input: $str = "hello", $int = 5
# Output: "mjqqt"
#
# Example 5
# Input: $str = "perl", $int = 26
# Output: "perl"

use Modern::Perl;
@ARGV==2 or die "usage: $0 str num\n";
say encrypt(@ARGV);

sub encrypt {
    my($str, $num) = @_;
    $str = lc($str);
    $str =~ s/[^a-z]//g;
    my @str_codes = map {ord($_) - ord('a')} split(//, $str);
    my @coded = map { ($_ + 26 + $num) % 26 } @str_codes;
    return join '', map {chr($_ + ord('a'))} @coded;
}
