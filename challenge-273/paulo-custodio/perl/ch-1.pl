#!/usr/bin/env perl

# Challenge 273
#
# Task 1: Percentage of Character
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str and a character $char.
#
# Write a script to return the percentage, nearest whole, of given character in
# the given string.
#
# Example 1
# Input: $str = "perl", $char = "e"
# Output: 25
# Example 2
# Input: $str = "java", $char = "a"
# Output: 50
# Example 3
# Input: $str = "python", $char = "m"
# Output: 0
# Example 4
# Input: $str = "ada", $char = "a"
# Output: 67
# Example 5
# Input: $str = "ballerina", $char = "l"
# Output: 22
# Example 6
# Input: $str = "analitik", $char = "k"
# Output: 13

use Modern::Perl;

say percent_char(@ARGV);

sub percent_char {
    my($str, $ch) = @_;
    my $percent = 100 * ($str =~ s/$ch/$ch/g) / length($str);
    return int($percent+0.5);
}
