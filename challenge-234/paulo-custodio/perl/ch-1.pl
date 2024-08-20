#!/usr/bin/env perl

# Challenge 234
#
# Task 1: Common Characters
# Submitted by: Mohammad S Anwar
#
# You are given an array of words made up of alphabetic characters only.
#
# Write a script to return all alphabetic characters that show up in all words
# including duplicates.
# Example 1
#
# Input: @words = ("java", "javascript", "julia")
# Output: ("j", "a")
#
# Example 2
#
# Input: @words = ("bella", "label", "roller")
# Output: ("e", "l", "l")
#
# Example 3
#
# Input: @words = ("cool", "lock", "cook")
# Output: ("c", "o")

use Modern::Perl;
use List::Util 'all';

my @words = @ARGV;
say join " ", find_common_chars(@words);

sub find_common_chars {
    my(@words) = @_;
    my @result;

    while (all {$_ ne ''} @words) {
        my $ch = substr($words[0],0,1);
        my $count;
        for (@words) {
            $count += s/$ch//i;
        }
        push @result, $ch if $count == @words;
    }
    return @result;
}
