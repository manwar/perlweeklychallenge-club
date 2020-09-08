#!/usr/bin/env raku

#
# Perl Weekly Challenge - 077
#
# Task #1: Fibonacci Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077
#

use Test;

is-deeply fibonacci-sum(6), ((1,5), (1,2,3)), "fibonacci sum = 6";
is-deeply fibonacci-sum(9), ((1,8), (1,3,5)), "fibonacci sum = 9";

done-testing;

#
#
# METHODS

sub fibonacci-sum(Int $sum where $sum > 0) {

    my @fibonacci     = fibonacci-series-upto($sum);
    my @fibonacci_sum = Empty;
    for 1 .. $sum -> $i {
        last if $i > @fibonacci.elems;
        for @fibonacci.combinations: $i -> $comb {
            my $_sum = [+] $comb;
            @fibonacci_sum.push: $comb if $_sum == $sum;
        }
    }

    return |@fibonacci_sum;
}

sub fibonacci-series-upto(Int $num where $num > 0) {

    my @fibonacci = (1, 2);
    while @fibonacci.[*-1] + @fibonacci.[*-2] <= $num {
        @fibonacci.push: @fibonacci.[*-1] + @fibonacci.[*-2];
    }

    return @fibonacci;
}
