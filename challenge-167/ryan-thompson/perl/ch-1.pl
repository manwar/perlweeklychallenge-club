#!/usr/bin/env perl
#
# ch-1.pl - Circular primes (OEIS A016114)
#
# Specifically, the lowest circular prime in each group. So, for example,
# 113 is a circular prime, as are the rotations 131 and 311, but only 113
# would be included in the output.
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# Just built a sieve a few weeks ago.
# I have a 3-month Eratosthenes cooldown.
use Math::Prime::Util qw< primes is_prime >;

my $target = 13; # How many circular primes we want
my %circ;        # $circ{n} = 1 if n is a circular prime

for (my $digits = 3; ; $digits++) {
    last if scalar keys %circ >= $target;

    my ($lo, $hi) = (10**($digits-1), 10**$digits-1);

    # All circular primes > 6 digits are repunits
    if ($digits > 6) {
        my $n = 1 x $digits;
        say "R_$digits" if is_prime($n);
        $circ{$n} = 1;
        next;
    }

    my @primes = @{ primes($lo, $hi) };     # All $digits length primes
    my %prime  = map { $_ => 1 } @primes;

    # Now check every $digits-digit prime for circularity
N:  for my $n (@primes) {
        my $rot = $n;
        for (1..$digits-1) {
            $rot = chop($rot) . $rot;
            next N if $circ{$rot} or not $prime{$rot};
        }
        say $n;
        $circ{$n} = 1;
    }
}
