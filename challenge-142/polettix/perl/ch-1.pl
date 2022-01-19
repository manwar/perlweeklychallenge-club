#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub divisors_for ($n) {
   keys %{{map { $_ => 1, int($n / $_) => 1 } grep { !($n % $_) }
     1 .. sqrt($n)}};
}

my $m = shift // 24;
my $n = shift // 2;
say scalar [grep { substr($_, -1, 1) == $n } divisors_for($m)]->@*;
