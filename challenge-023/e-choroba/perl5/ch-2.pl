#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use List::Util qw{ any };

sub prime_decomposition {
    my ($n) = @_;
    my %primes;
    for my $i (2 .. $n) {
        next if any { 0 == $i % $_ } keys %primes;

        $primes{$i} = 0;
        until ($n % $i) {
            ++$primes{$i};
            $n /= $i;
        }
        last if 1 == $n;
    }
    return map +($_) x $primes{$_}, sort { $a <=> $b } keys %primes
}

say join ' ', prime_decomposition(shift);
