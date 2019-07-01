#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

# Write a script to generate first 10 strong and weak prime numbers.

# https://en.wikipedia.org/wiki/Strong_prime
#  (which contains a list of strong primes to ensure things are correct)

#   For example, the nth prime number is represented by p(n).

#   p(1) = 2
#   p(2) = 3
#   p(3) = 5
#   p(4) = 7
#   p(5) = 11

#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

my @primes;
my @strong;
my @weak;

# create list of primes to judge strong, weak or balanced
while ( @strong < 10 && @weak < 10 ) {
    state $c += 1;
    if ( is_prime($c) ) { push @primes, $c }
    last if scalar @primes > 100;
}

for my $n ( 1 .. @primes ) {
    my $swb = is_strong($n);
    my $o   = $primes[$n];
    push @strong, $o if $swb == 1;
    push @weak,   $o if $swb == -1;
    last if @weak > 10 && @strong > 10;
    say $swb;
}
say 'strong:  ' . join ", ",  @strong[0..9];
say 'weak:    ' . join ", ",  @weak[0..9];
exit;

#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

# 1 if strong
# -1 if weak
# 0 if balanced
sub is_strong ( $n ) {
    my $o = $primes[$n];
    return 3 if $n <= 0;    # no n-1 -- look up this special case
    return 4
        if !$primes[ $n + 1 ];  # no n+1 -- we should be done well before then
    my $p = ( $primes[ $n - 1 ] + $primes[ $n + 1 ] ) / 2;
    return 1  if $o > $p;
    return -1 if $o < $p;
    return 0;
}

# this one again
sub is_prime ( $n ) {
    my @factors = factor($n);
    return scalar @factors == 1 ? 1 : 0;
}

# this has a slight modification, going only to sqrt $n, because
# there can't be a factor above that. Duh.
sub factor ( $n ) {
    my @factors;
    for my $i ( 1 .. sqrt $n ) {
        push @factors, $i if $n % $i == 0;
    }
    return @factors;
}
