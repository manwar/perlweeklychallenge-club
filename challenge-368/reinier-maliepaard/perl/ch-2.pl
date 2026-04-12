#!/usr/bin/perl
use strict;
use warnings;

# In this challenge, we've to compute the number of prime factors
# of a given integer. Prime factors are prime numbers (numbers divisible
# only by 1 and themselves) whose product equals the original number.
#
# Example:
# 12 = 2 × 2 × 3
# Here, 2 and 3 are prime numbers.
#
# In exponent form:
# 12 = 2² × 3¹
#
# Distinct prime factors: {2, 3} -> ω(12) = 2 (i.e. little omega)
# Total prime factors (sum exponents): 2 + 1 -> Ω(12) = 3 (i.e. big omega)
#
# Back to the task description:
# If $mode == 0, it returns ω(n): the number of distinct prime factors.
# If $mode == 1, it returns Ω(n): the total number of prime factors
# counting multiplicities.
#
# My solution uses the CPAN module Math::Prime::Util, which provides fast
# and efficient number-theoretic routines. The function factor_exp()
# returns the prime factorization as (prime, exponent) pairs, making it
# easy to compute both ω and Ω.
#
# Example: factor_exp(12) gives:
# [ [2,2], [3,1] ]
# Each pair is: [prime, exponent]
# So:
# ω = number of pairs -> 2
# Ω = sum of exponents -> 2+1 = 3

use Math::Prime::Util qw(factor_exp);

sub omega {
    my ($n, $mode) = @_;
    my @fe = factor_exp($n);

    return $mode == 0
        ? scalar @fe                     # ω (distinct)
        : do {
            my $sum = 0;
            $sum += $_->[1] for @fe;     # Ω (total)
            $sum;
        };
}

# Tests

my $number;
my $mode;

# Example 1
$number = 100061;
$mode = 0;
print omega($number, $mode), "\n"; # Output: 3

# Example 2
$number = 971088;
$mode = 0;
print omega($number, $mode), "\n"; # Output: 3

# Example 3
$number = 63640;
$mode = 1;
print omega($number, $mode), "\n"; # Output: 6

# Example 4
$number = 988841;
$mode = 1;
print omega($number, $mode), "\n"; # Output: 2

# Example 5
$number = 211529;
$mode = 0;
print omega($number, $mode), "\n"; # Output: 2
