#!/usr/bin/env perl

# Challenge 355
#
# Task 1: Thousand Separator
# Submitted by: Mohammad Sajid Anwar
# You are given a positive integer, $int.
#
# Write a script to add thousand separator, , and return as string.
#
# Example 1
# Input: $int = 123
# Output: "123"
#
# Example 2
# Input: $int = 1234
# Output: "1,234"
#
# Example 3
# Input: $int = 1000000
# Output: "1,000,000"
#
# Example 4
# Input: $int = 1
# Output: "1"
#
# Example 5
# Input: $int = 12345
# Output: "12,345"

use Modern::Perl;

@ARGV==1 && $ARGV[0] =~ /^\d+$/ or die "Usage: $0 integer\n";
say insert_separators(shift);

sub insert_separators {
    my($num) = @_;
    1 while $num =~ s/(\d)(\d\d\d)((,\d\d\d)*)$/$1,$2$3/;
    return $num;
}
