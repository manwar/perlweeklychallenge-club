#!/usr/bin/env perl

# Challenge 248
#
# Task 1: Shortest Distance
# Submitted by: Mohammad S Anwar
#
# You are given a string and a character in the given string.
#
# Write a script to return an array of integers of size same as length of
# the given string such that:
#
# distance[i] is the distance from index i to the closest occurence of
# the given character in the given string.
#
# The distance between two indices i and j is abs(i - j).
#
# Example 1
#
# Input: $str = "loveleetcode", $char = "e"
# Output: (3,2,1,0,1,0,0,1,2,2,1,0)
#
# The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
# The closest occurrence of 'e' for index 0 is at index 3, so the distance is abs(0 - 3) = 3.
# The closest occurrence of 'e' for index 1 is at index 3, so the distance is abs(1 - 3) = 2.
# For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
# but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
# The closest occurrence of 'e' for index 8 is at index 6, so the distance is abs(8 - 6) = 2.
#
# Example 2
#
# Input: $str = "aaab", $char = "b"
# Output: (3,2,1,0)

use Modern::Perl;
use List::Util 'min';

my @dists = calc_dists(@ARGV);
say "(", join(",", @dists), ")";

sub calc_dists {
    my($str, $char) = @_;
    my @str = split //, $str;
    my @dist = ((1e10) x @str);
    for my $i (0 .. $#str) {
        if ($str[$i] eq $char) {
            $dist[$i] = 0;
            for my $j (1 .. $i) {
                $dist[$i-$j] = min($dist[$i-$j], $j);
            }
            for my $j (1 .. $#str-$i) {
                $dist[$i+$j] = min($dist[$i+$j], $j);
            }
        }
    }
    return @dist;
}
