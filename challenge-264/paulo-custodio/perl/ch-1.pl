#!/usr/bin/env perl

# Challenge 264
#
# Task 1: Greatest English Letter
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, made up of only alphabetic characters [a..zA..Z].
#
# Write a script to return the greatest english letter in the given string.
#
# A letter is greatest if it occurs as lower and upper case. Also letter ‘b’ is
# greater than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.
#
# Example 1
# Input: $str = 'PeRlwEeKLy'
# Output: L
#
# There are two letters E and L that appears as lower and upper.
# The letter L appears after E, so the L is the greatest english letter.
# Example 2
# Input: $str = 'ChaLlenge'
# Output: L
# Example 3
# Input: $str = 'The'
# Output: ''

use Modern::Perl;

say greatest_letter(shift // '');

sub greatest_letter {
    my($word) = @_;
    for my $upper (reverse 'A' .. 'Z') {
        my $lower = lc($upper);
        return $upper if $word =~ /$upper/ && $word =~ /$lower/;
    }
    return "''";
}
