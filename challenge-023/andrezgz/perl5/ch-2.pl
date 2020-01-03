#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-023/
# Task #2
# Create a script that prints Prime Decomposition of a given number.
# The prime decomposition of a number is defined as a list of prime numbers which when all multiplied together,
# are equal to that number. For example, the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

use strict;
use warnings;

die "Usage: $0 <number>" if @ARGV == 0;
my $number = shift;

my @prime_decomp;

foreach my $prime (prime_factors($number)){
    do {
        $number /= $prime;
        push @prime_decomp, $prime;
    } until ($number % $prime != 0);
}

print join ',', @prime_decomp;

sub prime_factors {
    my $n = shift;
    return if $n <= 1;
    my @r = grep {$n % $_ == 0 && is_prime($_)} (2 .. $n/2); #get prime divisors
    return @r ? @r : ($n); # number is prime if no prime divisors were found
}

sub is_prime {
    my $n = shift;
    return if $n <= 1;
    #every composite number has a prime factor less than or equal to its square root.
    return 1 == grep {$n % $_ == 0} (1 .. sqrt $n);
}
