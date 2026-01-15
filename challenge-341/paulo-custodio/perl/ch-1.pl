#!/usr/bin/env perl

# Challenge 341
#
# Task 1: Broken Keyboard
# Submitted by: Mohammad Sajid Anwar
# You are given a string containing English letters only and also you are given broken keys.
#
# Write a script to return the total words in the given sentence can be typed completely.
#
#
# Example 1
# Input: $str = 'Hello World', @keys = ('d')
# Output: 1
#
# With broken key 'd', we can only type the word 'Hello'.
#
# Example 2
# Input: $str = 'apple banana cherry', @keys = ('a', 'e')
# Output: 0
#
# Example 3
# Input: $str = 'Coding is fun', @keys = ()
# Output: 3
#
# No keys broken.
#
# Example 4
# Input: $str = 'The Weekly Challenge', @keys = ('a','b')
# Output: 2
#
# Example 5
# Input: $str = 'Perl and Python', @keys = ('p')
# Output: 1

use Modern::Perl;

@ARGV==2 or die "usage: $0 'sentence' keys\n";
my @words = split ' ', $ARGV[0];
my $keys = $ARGV[1];
if ($keys eq '') {
    say scalar(@words);
}
else {
    my @can_type = grep {eval "!/[$keys]/i"} @words;
    say scalar(@can_type);
}
