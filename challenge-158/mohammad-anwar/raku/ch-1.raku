#!/usr/bin/env raku

=begin pod

Week 158:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-158

Task #1: Additive Primes

    Write a script to find out all Additive Primes <= 100.

=end pod

use Test;

is-deeply
    additive-primes(100),
    [ 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89 ],
    'Example';

done-testing;

#
#
# METHOD

sub additive-primes(Int $n) {

    my $i  = 1;
    my $ap = [];

    while ($i <= $n) {
        my $s = 0;

        if ($i > 10) {
            $s += $_ for ($i.split(""));
        }

        if ($i.is-prime) {
            if (($s == 0) || (($s > 0) && $s.is-prime)) {
                $ap.push: $i;
            }
        }

        $i++;
    }

    return $ap;
}
