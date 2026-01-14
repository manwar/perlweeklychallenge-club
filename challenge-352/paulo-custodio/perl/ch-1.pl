#!/usr/bin/env perl

# Challenge 352
#
# Task 1: Match String
# Submitted by: Mohammad Sajid Anwar
# You are given an array of strings.
#
# Write a script to return all strings that are a substring of another word in the given array in the order they occur.
#
# Example 1
# Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
# Output: ("cat", "dog", "dogcat", "rat")
#
# Example 2
# Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
# Output: ("hell", "world", "wor", "ellow")
#
# Example 3
# Input: @words = ("a", "aa", "aaa", "aaaa")
# Output: ("a", "aa", "aaa")
#
# Example 4
# Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
# Output: ("flow", "fl", "fli", "ig", "ght")
#
# Example 5
# Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
# Output: ("car", "pet", "enter", "pen", "pent")

use Modern::Perl;

@ARGV or die "usage: $0 strings...\n";
my @match = find_match(@ARGV);
say join ", ", @match;

sub find_match {
    my(@in) = @_;
    my @out;
    my %found;
    for my $word (@in) {
        if (grep {$_ ne $word && /$word/} @in) {
            push @out, $word unless $found{$word}++;
        }
    }
    return @out;
}
