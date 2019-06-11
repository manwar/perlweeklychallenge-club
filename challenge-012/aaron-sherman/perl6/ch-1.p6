#!/usr/bin/env perl6

use v6.c;

#Perl weekly challenge 012.1:

# The numbers formed by adding one to the products of the smallest primes
# are called the Euclid Numbers (see wiki). Write a script that finds the
# smallest Euclid Number that is not prime. This challenge was proposed
# by Laurent Rosenfeld.

# This solution serves two purposes. It both addresses the problem asked
# and demonstrates two sequences appropriate for inclusion in the
# Perl 6 OEIS library Math::Sequences

#= OEIS sequence A010051: the primes
sub primes() { (2,3,*+2...*).grep: *.is-prime }
# Math::Sequences entry for the primes:
our @A010051 = lazy primes;

#= OEIS sequence A057588: the Euclid numbers
sub euclids() {
    gather for primes() -> $p {
        take ((state $t=1) *= $p) + 1;
    }
}
# Math::Sequences entry for the Euclids:
our @A057588 = lazy euclids;

# Show the first non-prime Euclid number.
say euclids.grep(not *.is-prime).first;
