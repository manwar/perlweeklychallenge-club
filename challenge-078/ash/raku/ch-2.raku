#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/

# Comments: https://andrewshitov.com/2020/09/14/the-weekly-challenge-078/

my @a = 10, 20, 30, 40, 50;
my @b = 3, 4;

say @a.rotate($_) for @b;