#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-012/
# Challenge #1
# The numbers formed by adding one to the products of the smallest primes are called the Euclid Numbers
# (see wiki). https://en.wikipedia.org/wiki/Euclid_number
# Write a script that finds the smallest Euclid Number that is not prime.
# This challenge was proposed by Laurent Rosenfeld.

use strict;
use warnings;

my $n = 0;
my $mult = 1;

while(++$n){
    if ( is_prime($n) ) {
        $mult *= $n;
        last unless(is_prime($mult + 1));
    }
}
print $mult+1;

sub is_prime {
    my $n = shift;
    my $upto = int($n / 2); #Divisors are <= n/2
    return 1 == grep {$n % $_ == 0} (1 .. $upto);
}
