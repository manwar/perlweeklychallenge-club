# The numbers formed by adding one to the products
# of the smallest primes are called the Euclid Numbers (see wiki).
# Write a script that finds the smallest Euclid Number that is
# not prime. This challenge was proposed by Laurent Rosenfeld.

use strict;
use warnings;
use v5.10;

# we will need a function to test primality. As this is a
# challenge and so far not very concerned about performance,
# I will go for the "regex" primality test.
# you can find more information at
# https://iluxonchik.github.io/regular-expression-check-if-number-is-prime/
# but let just say that to test if some n number is prime, we build a string
# of n characters (with <char> x n), and let the regex engine try to divide
# it in more than one equal parts of at least 2 chars. So if
# we are not successful on that it means it is prime.
# we use a digit as the char as we don't have to quote it. Any digit will
# do, so we just pick "7"

sub is_prime {
    return ( 7 x shift ) !~ /^(77+)\1+$/;
}

# now we start generating primes from number 2, multiplying all of found
# so far to get next primorial number, add 1 to get the corresponding
# euclid number, check for primality, and loop until we get a non prime one

my $prime  = 2;
my $euclid = 3;
my @primes = ($prime);

while ( is_prime $euclid) {
    while ( !is_prime ++$prime ) { };    # find next prime
    push @primes, $prime;                # add to primes so far
    $euclid = 1;
    $euclid *= $_ for @primes;           # this will be the primorial number
    $euclid++;    # and this is the new euclid number we found
}

say "First not prime Euclid is $euclid";
