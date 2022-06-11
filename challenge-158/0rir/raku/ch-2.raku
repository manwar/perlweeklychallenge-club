#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;

# TASK #2 › First Series Cuban Primes

my $want = 1000;

my @expect;
my @correct = 7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919,
        1657, 1801, 1951, 2269, 2437, 2791, 3169, 3571, 4219, 4447,
        5167, 5419, 6211, 7057, 7351, 8269, 9241,
        10267, 11719, 12097, 13267, 13669,
        16651, 19441, 19927, 22447, 23497, 24571, 25117, 26227;

my @cuban-prime;
 for 1 .. ∞ {
    my $cp =  ($_+1)³ - $_³;
    last if $cp > $want;
    if $cp.is-prime {
        @cuban-prime.push: $cp;
        @expect.push: @correct.shift;
    }
};

die 'Logic error.' unless @cuban-prime eqv @expect;
say @cuban-prime.join( ', '), '.';
