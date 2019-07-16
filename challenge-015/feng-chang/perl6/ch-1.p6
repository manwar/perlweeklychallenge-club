#!/bin/env perl6

my @p = (^∞).grep: { $_.is-prime };
my (@sp, @wp);

for 1 .. ∞ -> $n {
    my $avg = (@p[$n - 1] + @p[$n + 1]) / 2;
    if @p[$n] > $avg {
        @sp.push(@p[$n]);
    } elsif @p[$n] < $avg {
        @wp.push(@p[$n]);
    }

    last if @sp.elems ≥ 10 && @wp.elems ≥ 10;
}

say "first 10 strong primes: { @sp[^10] }";
say "first 10 weak   primes: { @wp[^10] }";
