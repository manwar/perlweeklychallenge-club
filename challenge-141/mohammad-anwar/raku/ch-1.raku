#!/usr/bin/env raku

=begin pod

Week 141:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-141

Task #1: Number Divisors

    Write a script to find lowest 10 positive integers having exactly 8 divisors.

=end pod

use Test;

is-deeply
    number-divisors(10, 8),
    [24, 30, 40, 42, 54, 56, 66, 70, 78, 88],
    'Example 1';

done-testing;

#
#
# METHODS

sub number-divisors(Int $count, Int $number) {

    my @numbers = ();
    my Int $i = 1;
    while @numbers.elems < $count {

        my @divisors = [];
        for 1 .. $i -> $j {
            if $i mod $j == 0 {
                push @divisors: $j;
            }
        }

        if @divisors.elems == $number {
            push @numbers: $i;
        }

        $i++;
    }

    return @numbers;
}
