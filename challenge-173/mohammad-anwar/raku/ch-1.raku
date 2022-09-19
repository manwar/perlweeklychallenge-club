#!/usr/bin/env raku

=begin pod

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #1: Esthetic Number

    You are given a positive integer, $n.

    Write a script to find out if the given number is Esthetic Number.

=end pod

use Test;

ok  esthetic-number(5456), 'Example 1';
ok !esthetic-number(120),  'Example 2';

done-testing;

#
#
# METHOD

sub esthetic-number(Int $n where $n > 0 --> Bool) {
    my @n = $n.comb;
    for 1 .. @n.end -> $i {
        return False if abs(@n[$i-1] - @n[$i]) != 1;
    }
    return True;
}
