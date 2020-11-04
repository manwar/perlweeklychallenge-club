#!/usr/bin/env perl6
use v6;

sub prime_pow_fact($p,$n) {
    ($p, $p ** 2, $p ** 3 ...^ * > $n).map({ Int($n/$_) }).sum
}

my $n=@*ARGS[0].Int;
say min(prime_pow_fact(2,$n),prime_pow_fact(5,$n));

# run as <script> <number>
