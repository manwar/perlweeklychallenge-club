#!/usr/bin/env raku

=begin pod

Week 146:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-146

Task #1: 10001st Prime Number

    Write a script to generate the 10001st prime number.

=end pod

use Test;

is find-prime(10_001), 104743, 'Example';

done-testing;

#
#
# METHOD

sub find-prime(Int $count --> Int) {

    my Int $c = 0;
    my Int $n = 2;
    while $c <= $count {
        if $n.is-prime {
            ++$c;
            return $n if $c == $count;
        }
        $n++;
    }
}
