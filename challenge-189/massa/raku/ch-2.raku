#!/usr/bin/env raku

=begin pod

Week 189:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #2: Array Degree

    You are given an array of 2 or more non-negative integers.

    Write a script to find out the smallest slice, i.e. contiguous subarray of
    the original array, having the degree of the given array.

    The degree of an array is the maximum frequency of an element in the array.

    The degree of the given array is 2.
    The possible subarrays having the degree 2 are as below:
    (3, 3)
    (1, 3, 3)
    (3, 3, 2)
    (1, 3, 3, 2)

=end pod

use Test;

is-deeply (3, 3),        array-degree (1, 3, 3, 2);
is-deeply (1, 2, 1),     array-degree (1, 2, 1, 3);
is-deeply (2, 1, 2),     array-degree (1, 3, 2, 1, 2);
is-deeply (1, 1),        array-degree (1, 1, 2, 3, 2);
is-deeply (1, 2, 1, 1),  array-degree (2, 1, 2, 1, 1);

done-testing;

subset NonNegatives of List where .elems ≥ 2 && .all ~~ UInt;

sub degree-of(NonNegatives $_) {
    .Bag.values.max
}

sub array-degree(NonNegatives $_) {
    my \d = .&degree-of;
    for 2 .. .elems -> $n {
        .return with .rotor($n => -( $n - 1 )).grep({.&degree-of == d}).head
    }
}

