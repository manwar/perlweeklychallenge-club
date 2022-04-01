#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ sum };
use Math::Prime::Util qw{ is_prime nth_prime };

sub additive_primes ($n) {
    my @ap;
    my $i = 0;
    while (1) {
        my $p = nth_prime(++$i);
        last if $p > $n;

        push @ap, $p if is_prime(sum(split //, $p));
    }
    return \@ap
}

use Test::More tests => 1;
is_deeply additive_primes(100),
    [2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89],
    'Example';
