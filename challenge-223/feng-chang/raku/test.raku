#!/bin/env raku

# The Weekly Challenge 223
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Count Primes
pwc-test './ch-1.raku', 10, 4, 'Count Primes: 10 => 4';
pwc-test './ch-1.raku',  7, 4, 'Count Primes:  7 => 4';
pwc-test './ch-1.raku',  0, 0, 'Count Primes:  0 => 0';
pwc-test './ch-1.raku', 20, 8, 'Count Primes: 20 => 8';

# Task 2, Max Coins
pwc-test './ch-2.raku', |<3 1 5 8>, 167, 'Max Coins: (3, 1, 5, 8) => 167';
pwc-test './ch-2.raku', |<1 5>, 10, 'Max Coins: (1, 5) => 10';
pwc-test './ch-2.raku', |<3 8>, 32, 'Max Coins: (3, 8) => 32';

done-testing;
