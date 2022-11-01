#!/usr/bin/env raku

=begin pod

Week 189:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #1: Greater Character

    You are given an array of characters (a..z) and a target character.

    Write a script to find out the smallest character in the given
    array lexicographically greater than the target character.

=end pod

use Test;

is greater-character('b', qw/e m u g/), 'e', 'Example 1';
is greater-character('a', qw/d c e f/), 'c', 'Example 2';
is greater-character('o', qw/j a r/  ), 'r', 'Example 3';
is greater-character('a', qw/d c a f/), 'c', 'Example 4';
is greater-character('v', qw/t g a l/), 'v', 'Example 5';

done-testing;

#
#
# METHOD

subset Char of Str where { $_.chars == 1 };
sub greater-character(
    Char $target, @chars where all(@chars) ~~ Char --> Char) {
    my Int $ord_target = $target.ord;
    for @chars.sort -> $char {
        return $char if $char.ord > $ord_target;
    }

    return $target;
}
