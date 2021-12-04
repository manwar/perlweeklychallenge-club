#!/usr/bin/env raku

=begin pod

Week 141:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-141

Task #2: Like Numbers

    You are given positive integers, $m and $n.

    Write a script to find total count of integers created using the digits of $m which is also divisible by $n.

=end pod

use Test;

is-deeply(
    like-numbers(1234, 2),
    [2, 4, 12, 14, 24, 34, 124, 134, 234],
    'Example 1'
);

is-deeply(
    like-numbers(768, 4),
    [8, 76, 68],
    'Example 2'
);

done-testing;

#
#
# METHODS

sub like-numbers(Int $m, Int $n) {

    my @numbers = ();
    for $m.comb.combinations -> $i {
        my Int $j = $i.join('').Int;
        next if $j == 0;
        next if $j.chars == $m.chars;

        if $j mod $n == 0 {
            push @numbers: $j;
        }
    }

    return @numbers;
}
