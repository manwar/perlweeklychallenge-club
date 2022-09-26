#!/usr/bin/env raku

=begin head1

Week 184:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-184

Task #2: Split Array

    You are given list of strings containing 0-9 and a-z separated by
    space only.

    Write a script to split the data into two arrays, one for integers
    and one for alphabets only.

=end head1

use v6;
use Test;

is-deeply split-array('a 1 2 b 0', '3 c 4 d'),
   ( [[1,2,0], [3,4]], [['a','b'], ['c','d']] ),
   'Example 1';

is-deeply split-array('1 2', 'p q r', 's 3', '4 5 t'),
   ( [[1,2], [3], [4,5]], [['p','q','r'], ['s'], ['t']] ),
   'Example 2';

done-testing;

sub split-array(+@list) {
    .map({.{0} or Empty})».map(+ *)».Array.Array, .map({.{1} or Empty}).Array with [ @list.map: { .split(/\s+/).categorize({+ !m/\d/}) } ]
}
