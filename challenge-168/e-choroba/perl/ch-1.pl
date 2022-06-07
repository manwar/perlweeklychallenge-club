#!/usr/bin/perl
use warnings;
use strict;
use Syntax::Construct qw{ // };

use Math::Prime::Util qw{ is_prime };

sub perrin_prime {
    my ($length) = @_;
    my @perrin_sliding = (3, 0, 2);
    my @perrin_primes;
    while (@perrin_primes < $length) {
        push @perrin_sliding, shift(@perrin_sliding) + $perrin_sliding[0];
        push @perrin_primes, $perrin_sliding[1]
            if $perrin_sliding[1] > ($perrin_primes[-1] // 0)
            && is_prime($perrin_sliding[1]);
    }
    return @perrin_primes
}

use Test::More tests => 1;

is_deeply [perrin_prime(13)], [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197,
                               43721, 1442968193, 792606555396977];
