#!/usr/bin/env raku

=begin pod

Week 149:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-149

Task #1: Fibonacci Digit Sum

    Given an input $N, generate the first $N numbers for which the sum of their digits is a Fibonacci number.

=end pod

use Test;

is-deeply
    fibonacci-digit-sum(20),
    [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44],
    'Example';

done-testing;

#
#
# METHOD

sub fibonacci-digit-sum(Int $count) {

    my $fibonacci = [0, 1];
    my $digit_sum = [0, 1];
    my Int $index = 2;
    while $digit_sum.elems < $count {
        while $fibonacci.tail <= $index {
            $fibonacci.push: [+] $fibonacci.tail(2);
        }

        my Int $sum = 0;
        if $index < 10 {
            $sum = $index;
        }
        else {
            $sum = [+] $index.split('');
        }

        if $sum ~~ any |$fibonacci {
            $digit_sum.push: $index;
        }

        $index++;
    }

    return $digit_sum;
}
