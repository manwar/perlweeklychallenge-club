#!/usr/bin/env raku

=begin pod

Week 145:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-145

Task #1: Dot Product

    You are given 2 arrays of same size, @a and @b.

    Write a script to implement Dot Product.

=end pod

use Test;

is dot-product([1,2,3], [4,5,6]), 32, 'Example';

done-testing;

#
#
# METHODS

sub dot-product($a, $b --> Int) {

    if $a.elems == $b.elems {
        my Int $dp = 0;
        for 0 .. $a.elems-1 -> $i {
            $dp += $a[$i] * $b[$i];
        }

        return $dp;
    }
}
