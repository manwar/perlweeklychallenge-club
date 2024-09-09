#!/usr/bin/env perl

# Challenge 282
#
# Task 1: Good Integer
# Submitted by: Mohammad Sajid Anwar
#
# You are given a positive integer, $int, having 3 or more digits.
#
# Write a script to return the Good Integer in the given integer or -1
# if none found.
#
#     A good integer is exactly three consecutive matching digits.
#
# Example 1
#
# Input: $int = 12344456
# Output: 444
#
# Example 2
#
# Input: $int = 1233334
# Output: -1
#
# Example 3
#
# Input: $int = 10020003
# Output: 000

use Modern::Perl;

@ARGV==1 or die "Usage: $0 INT\n";
(my $int = shift) =~ /^\d+$/ or die "Usage: $0 INT\n";

if ($int =~ /((\d)\2\2+)/ && length($1) == 3) {
    say $1;
}
else {
    say -1;
}
