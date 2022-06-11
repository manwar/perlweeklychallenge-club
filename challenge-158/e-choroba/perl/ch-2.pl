#!/usr/bin/perl
use warnings;
use strict;

use experimental 'signatures';
use Math::Prime::Util qw{ is_prime };

sub cuban_primes ($n) {
    my @c;
    my $y = 0;
    while (1) {
        # centered hexagonal number
        my $chn = 3 * $y * $y + 3 * $y + 1;
        last if $chn > $n;

        push @c, $chn if is_prime($chn);
        ++$y;
    }
    return \@c
}

use Test::More tests => 1;

is_deeply cuban_primes(1000),
    [7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919],
    'Example';
