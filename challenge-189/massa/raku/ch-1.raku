#!/usr/bin/env raku

=begin pod

Week 189:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #1: Greater Character
    You are given an array of characters (`a`..`z`) and a target character.

    Write a script to find out the smallest character in the given array lexicographically greater than the target character.

=end pod

use Test;

is 'e', greater-character <e m u g>, 'b';
is 'c', greater-character <d c e f>, 'a';
is 'r', greater-character <j a r>,   'o';
is 'c', greater-character <d c a f>, 'a';
is 'v', greater-character <t g a l>, 'v';

done-testing;

subset OneLetter of Str where / ^ <[a..z]> $/;
subset Letters of List where .all ~~ OneLetter;

sub greater-character(Letters $_, OneLetter \l --> OneLetter) {
    .grep(* gt l).sort.head // l
}

