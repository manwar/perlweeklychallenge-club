#!/usr/bin/env raku

=begin pod

Week 150:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-150

Task #1: Fibonacci Words

    You are given two strings having same number of digits, $a and $b.

    Write a script to generate Fibonacci Words by concatenation of the previous two strings. Finally print 51st digit of the first term having at least 51 digits.

=end pod

use Test;

my Str $term1 = '1234';
my Str $term2 = '5678';
my Int $index = 51;

is(fibonacci-words($term1, $term2, $index), '7', 'Example');

done-testing;

#
#
# METHOD

sub fibonacci-words(Str $term1 is rw,
                    Str $term2 is rw,
                    Int $index is rw --> Str) {

    while ($term1 ~ $term2).codes <= $index {
        ($term1, $term2) = ($term2, $term1 ~ $term2);
    }

    return ($term1 ~ $term2).substr(--$index,1);
}
