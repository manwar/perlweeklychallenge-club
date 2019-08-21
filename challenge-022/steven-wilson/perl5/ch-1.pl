#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-08-21
# Week: 022
#
# Task #1
# Write a script to print first 10 Sexy Prime Pairs. Sexy primes are
# prime numbers that differ from each other by 6. For example, the
# numbers 5 and 11 are both sexy primes, because 11 - 5 = 6. The term
# “sexy prime” is a pun stemming from the Latin word for six: sex. For
# more information, please checkout wiki page.
# https://en.wikipedia.org/wiki/Sexy_prime

use strict;
use warnings;
use feature qw/ say /;

use Math::Primality qw/ next_prime /;

my @primes;
my @sexy_prime_pairs;
my $next_prime = 2;

while ( scalar @sexy_prime_pairs < 10 ) {
    if ( grep { $_ == ( $next_prime - 6 ) } @primes ) {
        push @sexy_prime_pairs, [ ( $next_prime - 6 ), $next_prime ];
    }
    $next_prime = next_prime($next_prime);
    push @primes, $next_prime;
}

say "First 10 Sexy Prime Pairs are:";
for (@sexy_prime_pairs) {
    say @{$_}[0], " ", @{$_}[1];
}
