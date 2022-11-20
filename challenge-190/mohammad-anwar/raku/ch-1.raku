#!/usr/bin/env raku

=begin pod

Week 190:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-190

Task #1: Capital Detection

    You are given a string with alphabetic characters only:
    A..Z and a..z.

    Write a script to find out if the usage of Capital is appropriate
    if it satisfies at least one of the following rules:

    1) Only first letter is capital and all others are small.
    2) Every letter is small.
    3) Every letter is capital.

=end pod

use Test;

ok  capital_detection('Perl'),   'Example 1';
ok  capital_detection('TPF'),    'Example 2';
ok !capital_detection('PyThon'), 'Example 3';
ok  capital_detection('raku'),   'Example 4';

done-testing;

#
#
# METHOD

sub capital_detection(str $str) {
    return ($str ~~ /^<[A..Za..z]>+$/)
           && (($str ~~ /^<[A..Z]><[a..z]>+$/)
               ||
               ($str ~~ /^<[a..z]>+$/)
               ||
               ($str ~~ /^<[A..Z]>+$/));
}
