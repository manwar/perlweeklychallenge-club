#!/usr/bin/env perl

# TASK #1 > Middle 3-digits
# Submitted by: Mohammad S Anwar
# You are given an integer.
#
# Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.
#
# Example 1
# Input: $n = 1234567
# Output: 345
# Example 2
# Input: $n = -123
# Output: 123
# Example 3
# Input: $n = 1
# Output: too short
# Example 4
# Input: $n = 10
# Output: even number of digits

use Modern::Perl;

my $n = abs(shift||0);
my $len = length($n);
if ($len%2==0) {
    say "even number of digits";
}
elsif ($len<3) {
    say "too short";
}
else {
    say substr($n, ($len-3)/2, 3);
}
