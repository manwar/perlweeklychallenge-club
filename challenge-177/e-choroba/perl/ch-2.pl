#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Prime::Util qw{ next_prime };

sub palindromic_prime_cyclops ($count) {
    my @ppc;
    my $n = 0;
    while (@ppc < $count) {
        $n = next_prime($n);
        push @ppc, $n if $n == reverse($n) && $n =~ /^[^0]+0[^0]+$/;
    }
    return \@ppc
}

use Test2::V0;
plan 1;

is palindromic_prime_cyclops(20),
    [101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
     1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
     1360631, 1390931, 1490941, 1520251];
