#!/usr/bin/env raku

=begin pod

Week 172:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-172

Task #1: Prime Partition

    You are given two positive integers, $m and $n.

    Write a script to find out the Prime Partition of the given
    number. No duplicates allowed.

=end pod

use Test;

is prime-partition(18, 2), [5, 13],    'Example 1';
is prime-partition(19, 3), [3, 5, 11], 'Example 2';

done-testing;

#
#
# METHOD

sub prime-partition(Int $m, Int $n) {
    my @primes = (2 .. $m).grep: { .is-prime };
    for @primes.combinations: $n -> $combination {
        return $combination if ([+] $combination) == $m;
    }
    return;
}
