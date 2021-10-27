#!/usr/bin/env raku

=begin pod

Week 136:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-136

Task #2: Fibonacci Sequence

    You are given a positive number $n.

    Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.

=end pod

use Test;

#
#
# DISCLAIMER: This is nearly same as Task #1 of Week 77.

is fibonacci-sequence(16), 4, 'Example 1';
is fibonacci-sequence( 9), 2, 'Example 2';;
is fibonacci-sequence(15), 2, 'Example 3';

done-testing;

#
#
# METHODS

sub fibonacci-sequence(Int $sum where $sum > 0) {

    my @fibonacci     = fibonacci-series-upto($sum);
    my @fibonacci_sum = Empty;
    for 1 .. $sum -> $i {
        last if $i > @fibonacci.elems;
        for @fibonacci.combinations: $i -> $comb {
            my $_sum = [+] $comb;
            @fibonacci_sum.push: $comb if $_sum == $sum;
        }
    }

    return @fibonacci_sum.elems;
}

sub fibonacci-series-upto(Int $num where $num > 0) {

    my @fibonacci = (1, 2);
    while @fibonacci.[*-1] + @fibonacci.[*-2] <= $num {
        @fibonacci.push: @fibonacci.[*-1] + @fibonacci.[*-2];
    }

    return @fibonacci;
}
