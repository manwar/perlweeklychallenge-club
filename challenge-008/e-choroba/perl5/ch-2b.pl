#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use constant COUNT => 5;

my @primes = (2, 3);


sub add_primes {
    my ($upto) = @_;

  PRIME:
    for my $n ($primes[-1] + 2 .. $upto) {
        for my $p (@primes) {
            next PRIME if 0 == $n % $p;

            last if $p > sqrt $n;
        }
        push @primes, $n;
    }
}


sub is_prime {
    my ($n) = @_;
    return if $n == 1;

    add_primes($n) if $n > $primes[-1];

    for my $p (@primes) {
        return 1 if $p >= $n;

        return if 0 == $n % $p;
    }
}

my $n = 1;
my $tally = 0;
while ($tally < COUNT) {
    if (is_prime($n) && is_prime(2 ** $n - 1)) {
        say +(2 ** $n - 1) * 2 ** ($n - 1);
        ++$tally;
    }
    ++$n;
}


