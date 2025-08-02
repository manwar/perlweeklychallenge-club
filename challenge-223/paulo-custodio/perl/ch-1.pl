#!/usr/bin/env perl

# Challenge 223
#
# Task 1: Count Primes
# Submitted by: Mohammad S Anwar
# You are given a positive integer, $n.
#
# Write a script to find the total count of primes less than or equal to the
# given integer.
#
#
# Example 1
# Input: $n = 10
# Output: 4
#
# Since there are 4 primes (2,3,5,7) less than or equal to 10.
# Example 2
# Input: $n = 1
# Output: 0
# Example 3
# Input: $n = 20
# Output: 8
#
# Since there are 4 primes (2,3,5,7,11,13,17,19) less than or equal to 20.

use Modern::Perl;

my $n = shift || 0;
my $count = 0;
for (2..$n) {
    $count++ if is_prime($_);
}
say $count;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}
