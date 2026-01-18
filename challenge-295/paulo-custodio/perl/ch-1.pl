#!/usr/bin/env perl

# Challenge 295
#
# Task 1: Word Break
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, and list of words, @words.
#
# Write a script to return true or false whether the given string can be segmented into a space separated sequence of one or more words from the given list.
#
# Example 1
# Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
# Output: true
# Example 2
# Input: $str = "perlrakuperl", @words = ("raku", "perl")
# Output: true
# Example 3
# Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
# Output: false

use Modern::Perl;
@ARGV>2 or die "usage: $0 string words...\n";
my($string, @words) = @ARGV;
say word_break($string, @words) ? "true" : "false";

sub word_break {
    my($string, @words) = @_;
    while ($string ne '') {
        my $found;
        for my $word (@words) {
            if (substr($string, 0, length($word)) eq $word) {
                $string = substr($string, length($word));
                $found = 1;
                last;
            }
        }
        return unless $found;
    }
    return 1;
}
