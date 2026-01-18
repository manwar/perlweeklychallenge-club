#!/usr/bin/env perl

# Challenge 342
#
# Task 2: Max Score
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, containing 0 and 1 only.
#
# Write a script to return the max score after splitting the string into two non-empty substrings. The score after splitting a string is the number of zeros in the left substring plus the number of ones in the right substring.
#
#
# Example 1
# Input: $str = "0011"
# Output: 4
#
# 1: left = "0", right = "011" => 1 + 2 => 3
# 2: left = "00", right = "11" => 2 + 2 => 4
# 3: left = "001", right = "1" => 2 + 1 => 3
#
# Example 2
# Input: $str = "0000"
# Output: 3
#
# 1: left = "0", right = "000" => 1 + 0 => 1
# 2: left = "00", right = "00" => 2 + 0 => 2
# 3: left = "000", right = "0" => 3 + 0 => 3
#
# Example 3
# Input: $str = "1111"
# Output: 3
#
# 1: left = "1", right = "111" => 0 + 3 => 3
# 2: left = "11", right = "11" => 0 + 2 => 2
# 3: left = "111", right = "1" => 0 + 1 => 1
#
# Example 4
# Input: $str = "0101"
# Output: 3
#
# 1: left = "0", right = "101" => 1 + 2 => 3
# 2: left = "01", right = "01" => 1 + 1 => 2
# 3: left = "010", right = "1" => 2 + 1 => 3
#
# Example 5
# Input: $str = "011101"
# Output: 5
#
# 1: left = "0", right = "11101" => 1 + 4 => 5
# 2: left = "01", right = "1101" => 1 + 3 => 4
# 3: left = "011", right = "101" => 1 + 2 => 3
# 4: left = "0111", right = "01" => 1 + 1 => 2
# 5: left = "01110", right = "1" => 2 + 1 => 3

use Modern::Perl;

@ARGV==1 or die "usage: $0 101010\n";
say max_score($ARGV[0]);

sub max_score {
    my($str) = @_;
    my $max_score = 0;
    for my $len (1 .. length($str)-1) {
        my $s1 = substr($str, 0, $len);
        my $s2 = substr($str, $len);
        my $score = ($s1 =~ tr/0/0/) + ($s2 =~ tr/1/1/);
        $max_score = $score if $max_score < $score;
    }
    return $max_score;
}
