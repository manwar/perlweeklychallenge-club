#!/usr/bin/env perl

# Challenge 305
#
# Task 1: Binary Prefix
# Submitted by: Mohammad Sajid Anwar
# You are given a binary array.
#
# Write a script to return an array of booleans where the partial binary number up to that point is prime.
#
# Example 1
# Input: @binary = (1, 0, 1)
# Output: (false, true, true)
#
# Sub-arrays (base-10):
# (1): 1 - not prime
# (1, 0): 2 - prime
# (1, 0, 1): 5 - prime
# Example 2
# Input: @binary = (1, 1, 0)
# Output: (false, true, false)
#
# Sub-arrays (base-10):
# (1): 1 - not prime
# (1, 1): 3 - prime
# (1, 1, 0): 6 - not prime
# Example 3
# Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
# Output: (false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)

use Modern::Perl;

@ARGV or die "usage: $0 binary-digits...\n";
say join ", ", map {$_ ? 'true' : 'false'} bin_prefix(@ARGV);

sub is_prime {
    my ($n) = @_;

    return 0 if $n < 2;          # 0 and 1 are not prime
    return 1 if $n == 2;         # 2 is the only even prime
    return 0 if $n % 2 == 0;    # Skip all other even numbers

    # Check odd divisors up to the square root of n
    for (my $i = 3; $i <= sqrt($n); $i += 2) {
        return 0 if $n % $i == 0;
    }

    return 1; # If no divisors were found, it's prime
}

sub bin_prefix {
    my(@digits) = @_;
    my $n = 0;
    my @out;
    for (@digits) {
        $n = $n * 2 + $_;
        push @out, is_prime($n);
    }
    return @out;
}
