#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-008/
# Challenge #1
# Write a script that computes the first five perfect numbers.
# A perfect number is an integer that is the sum of its positive proper divisors (all divisors except itself).
# Please check Wiki for more information. This challenge was proposed by Laurent Rosenfeld.
# https://en.wikipedia.org/wiki/Perfect_number

use strict;
use warnings;

# Using Euclid-Euler theorem (https://en.wikipedia.org/wiki/Euclid%E2%80%93Euler_theorem)
# we can create an even perfect number from a Mersenne prime (2^n - 1), for prime n

my $perfect = 0;
my $n = 2;

while ($perfect < 5) {
    if (is_prime($n) && is_prime(2**$n-1)) {
        print 2**($n-1) * (2**$n - 1).$/;
        $perfect++;
    }
    $n++;
}

sub is_prime {
    my $n = shift;
    return 1 == grep {$n % $_ == 0} (1 .. $n-1);
}
