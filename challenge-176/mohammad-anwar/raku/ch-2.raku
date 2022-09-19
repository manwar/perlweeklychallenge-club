#!/usr/bin/env raku

=begin pod

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task 2: Reversible Numbers

    Write a script to find out all Reversible Numbers below 100.

=end pod

use Test;

is [
    10, 12, 14, 16, 18, 21, 23, 25, 27,
    30, 32, 34, 36, 41, 43, 45, 50, 52,
    54, 61, 63, 70, 72, 81, 90
], all-reversible-numbers-below(100);

done-testing;

#
#
# METHODS

sub has-all-odd-digits(Int $n --> Bool) {
    for $n.comb -> $i {
        return False if $i %% 2;
    }
    return True;
}

sub all-reversible-numbers-below(Int $n where $n >= 1 --> Array[Int]) {
    my Int @rn = ();
    for 1..100 -> $i {
        @rn.push: $i if has-all-odd-digits($i + $i.flip);
    }

    return @rn;
}
