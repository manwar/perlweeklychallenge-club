#!/usr/bin/perl
use warnings;
use strict;

use Math::Prime::Util qw{ next_prime is_prime };

sub is_circular {
    my ($p) = @_;
    my $c = $p;

    # Start from 2, we don't need to check the number itself.
    for (2 .. length $p) {
        substr $c, 0, 0, substr $c, -1, 1, "";
        return if $c < $p || ! is_prime($c);
    }
    return 1
}

sub circular_prime {
    my ($tally, $min_digits) = @_;
    my @primes;
    my $from = '1' x $min_digits - 1;
    my $p = next_prime($from);
    while (@primes < $tally) {
        push @primes, $p
            if ($p < 10 || $p !~ /[024568]/)  # This speeds the code slightly.
            && is_circular($p);
        $p = next_prime($p);
    }
    return \@primes
}

use Test::More tests => 3;

is_deeply circular_prime(10, 3),
    [113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933],
    'Example';

is_deeply circular_prime(10, 1),
    [2, 3, 5, 7, 11, 13, 17, 37, 79, 113],
    'Shorter CPs';

is_deeply circular_prime(1, 19),
    [1111111111111111111],
    'Longer CP';
