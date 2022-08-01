#!/usr/bin/env raku

=begin pod

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task #1: Permuted Multiples

    Write a script to find the smallest integer x such that x, 2x,
    3x, 4x, 5x and 6x are permuted multiples of each other.

=end pod

use Test;

is 142857, smallest-permuted-multiples();

done-testing;

#
#
# METHODS

sub has-same-digits(Int $m, Int $n --> Bool) {
    return $m.comb.sort.join("") eq $n.comb.sort.join("");
}

sub smallest-permuted-multiples() {
    my $i = 10;
    while (True) {
        my $found = True;
        for 2..6 -> $j {
            if not has-same-digits($i, $i * $j) {
                $found = False;
                last;
            }
        }

        return $i if $found;
        $i += 1;
    }
}
