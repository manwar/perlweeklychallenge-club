#!/usr/bin/env perl

# Challenge 229
#
# Task 1: Lexicographic Order
# Submitted by: Mohammad S Anwar
#
# You are given an array of strings.
#
# Write a script to delete element which is not lexicographically sorted
# (forwards or backwards) and return the count of deletions.
# Example 1
#
# Input: @str = ("abc", "bce", "cae")
# Output: 1
#
# In the given array "cae" is the only element which is not lexicographically sorted.
#
# Example 2
#
# Input: @str = ("yxz", "cba", "mon")
# Output: 2
#
# In the given array "yxz" and "mon" are not lexicographically sorted.

use Modern::Perl;

my @words = @ARGV;
my $count = scalar grep {!is_sorted($_)} @words;
say $count;

sub is_sorted {
    my($str) = @_;
    my $forwards = join '', sort split //, $str;
    my $backwards = join '', reverse sort split //, $str;
    return $str eq $forwards || $str eq $backwards;
}
