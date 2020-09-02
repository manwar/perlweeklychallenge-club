#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Prime Sum
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# You are given a number $N. Write a script to find the minimum number
# of prime numbers required, whose summation gives you $N.
#
# For the sake of this task, please assume 1 is not a prime number.
# Example:
#
# Input:
#     $N = 9
#
# Ouput:
#     2 as sum of 2 prime numbers i.e. 2 and 7 is same as the input number.
#     2 + 7 = 9.

# compute primes up to $n using the Sieve of Eratosthenes
sub primes_upto($n) {
    my @is_prime = map {1} (0..$n);
    $is_prime[0] = $is_prime[1] = 0;

    for my $i (2..$n) {
        if ($is_prime[$i]) {
            for (my $j = $i * 2; $j <= $n; $j += $i) {
                $is_prime[$j] = 0;
            }
        }
    }
    return grep {$is_prime[$_]} 2..$n;
}

my $n = shift @ARGV;
my @primes = primes_upto($n);
