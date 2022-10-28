#!/usr/bin/env raku

=begin pod

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #2: Total Zero

    You are given two positive integers $x and $y.

    Write a script to find out the number of operations needed to
    make both ZERO. Each operator is made up either of the following:

        $x = $x - $y if $x >= $y

        or

        $y = $y - $x if $y >= $x

=end pod

use Test;

my Int $x; my Int $y;

($x, $y) = (5, 4);
is total-zero($x, $y), 5, 'Example 1';
($x, $y) = (4, 6);
is total-zero($x, $y), 3, 'Example 2';
($x, $y) = (2, 5);
is total-zero($x, $y), 4, 'Example 3';
($x, $y) = (3, 1);
is total-zero($x, $y), 3, 'Example 4';
($x, $y) = (7, 4);
is total-zero($x, $y), 5, 'Example 5';

done-testing;

#
#
# METHOD

sub total-zero(Int $x is rw, Int $y is rw --> Int) {
    my Int $count = 0;
    while $x > 0 && $y > 0 {
        ($x >= $y)??($x = $x - $y)!!($y = $y - $x);
        $count++;
    }

    return $count;
}
