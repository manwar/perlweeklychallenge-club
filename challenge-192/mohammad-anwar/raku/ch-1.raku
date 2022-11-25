#!/usr/bin/env raku

=begin pod

Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

Task #1: Binary Flip

    You are given a positive integer, $n.

    Write a script to find the binary flip.

=end pod

use Test;

is binary-flip(5), 2, 'Example 1';
is binary-flip(4), 3, 'Example 2';
is binary-flip(6), 1, 'Example 3';

done-testing;

#
#
# METHOD

sub binary-flip(Int $n is copy --> Int) {
    return $n.base(2)
             .comb()
             .map(-> $v { ($v == 0)??(1)!!(0) })
             .join(q{})
             .parse-base(2);
}
