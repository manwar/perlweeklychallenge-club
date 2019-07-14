#!/bin/env perl

use Modern::Perl;

my @N = (1) x 225;

for my $i (2..14) {
    if ($N[$i]) {
        for (my $j = $i * 2; $j < 225; $j += $i) {
            $N[$j] = 0;
        }
    }
}

my @p = grep { $N[$_] } 2..224;

my (@sp, @wp);

for my $n (1 .. scalar @p - 1) {
    my $avg = ($p[$n - 1] + $p[$n + 1]) / 2;
    if ($p[$n] > $avg) {
        push @sp, $p[$n];
    } elsif ($p[$n] < $avg) {
        push @wp, $p[$n];
    }

    last if scalar @sp >= 10 && scalar @wp >= 10;
}

say 'first 10 strong primes: ', join ' ', @sp[0..9];
say 'first 10 weak   primes: ', join ' ', @wp[0..9];
