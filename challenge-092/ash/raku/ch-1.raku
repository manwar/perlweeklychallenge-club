#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-092/

# Comments: https://andrewshitov.com/2020/12/21/raku-challenge-week-92-issue-1/

use Test;

unit sub MAIN(Str $a, Str $b);

sub is-isomorphic($a, $b) {
    +(([==] ($a, $b)>>.chars) && ([==] ($a.comb, $b.comb, ($a.comb Z~ $b.comb))>>.unique));
}

is(is-isomorphic('abc', 'def'), 1);
is(is-isomorphic('abb', 'xyy'), 1);
is(is-isomorphic('sum', 'add'), 0);

is(is-isomorphic('ACAB', 'XCXY'), 1);
is(is-isomorphic('AAB', 'XYZ'), 0);
is(is-isomorphic('AAB', 'XXZ'), 1);

is(is-isomorphic('abc', 'abc'), 1);
is(is-isomorphic('abc', 'ab'), 0);

is(is-isomorphic('aeiou', 'bcdfg'), 1);
is(is-isomorphic('aeiou', 'gxypq'), 1);
is(is-isomorphic('aaeeiioouu', 'bbccddffgg'), 1);
is(is-isomorphic('aeaieoiuo', 'gxgyxpyqp'), 1);

is(is-isomorphic('aeiou', 'bcdtg'), 1);
is(is-isomorphic('aeiou', 'qpyxg'), 1);
is(is-isomorphic('aaeeiioouu', 'bbccdxffgg'), 0);
is(is-isomorphic('aeaieoiuo', 'gxgyxpaejrkeruqp'), 0);
