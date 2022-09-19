#!/usr/bin/env raku

=begin pod

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #2: Trim List

    You are given list of numbers, @n and an integer $i.

    Write a script to trim the given list where element is less than
    or equal to the given integer.

=end pod

use Test;

is trim-list(3, [1, 4, 2, 3, 5]),       [4, 5],       'Example 1';
is trim-list(4, [9, 0, 6, 2, 3, 8, 5]), [9, 6, 8, 5], 'Example 2';

done-testing;

#
#
# METHOD

sub trim-list(Int $i, @n --> Array[Int]) {
    my Int @l = ();
    for @n -> $l {
        @l.push: $l if $l > $i;
    }

    return @l;
}
