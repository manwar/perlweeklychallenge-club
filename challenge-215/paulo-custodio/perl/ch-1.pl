#!/usr/bin/perl

# Challenge 215
#
# Task 1: Odd one Out
# Submitted by: Mohammad S Anwar
#
# You are given a list of words (alphabetic characters only) of same size.
#
# Write a script to remove all words not sorted alphabetically and print
# the number of words in the list that are not alphabetically sorted.
#
# Example 1
#
# Input: @words = ('abc', 'xyz', 'tsu')
# Output: 1
#
# The words 'abc' and 'xyz' are sorted and can't be removed.
# The word 'tsu' is not sorted and hence can be removed.
#
# Example 2
#
# Input: @words = ('rat', 'cab', 'dad')
# Output: 3
#
# None of the words in the given list are sorted.
# Therefore all three needs to be removed.
#
# Example 3
#
# Input: @words = ('x', 'y', 'z')
# Output: 0

use Modern::Perl;

sub is_sorted {
    my($str) = @_;
    my $sorted = join '', sort {$a cmp $b} split //, $str;
    return $str eq $sorted;
}

sub odd_out {
    my(@in) = @_;
    return scalar(grep {!is_sorted($_)} @in);
}

say odd_out(@ARGV);
