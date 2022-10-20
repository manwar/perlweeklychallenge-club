#!/usr/bin/env raku

=begin pod

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #2: Magical Triplets

    You are given a list of positive numbers, @n, having at least
    3 numbers.

    Write a script to find the triplets (a, b, c) from the given list
    that satisfies the following rules.

    1. a + b > c
    2. b + c > a
    3. a + c > b
    4. a + b + c is maximum.

    In case, you end up with more than one triplets having the maximum
    then pick the triplet where a >= b >= c.

=end pod

use Test;

magical-triplets(<1 2 3 2>);

is magical-triplets(<1 2 3 2>), (3, 2, 2), 'Example 1';
is magical-triplets(<1 3 2>),   (),        'Example 2';
is magical-triplets(<1 1 2 3>), (),        'Example 3';
is magical-triplets(<2 4 3>),   (4, 3, 2), 'Example 4';

done-testing;

#
#
# METHOD

sub magical-triplets(@list) {
    my %entries = ();
    for @list.sort.combinations(3) -> ($x, $y, $z) {
        if $x + $y > $z &&
           $y + $z > $x &&
           $x + $z > $y {
            %entries{"$x:$y:$z"} = $x + $y + $z;
        }
    }

    return () if %entries.keys.elems == 0;

    return %entries
           .sort(*.values)
           .tail
           .key
           .split(":")
           .sort: { $^b leg $^a };
}
