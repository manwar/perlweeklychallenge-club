#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069/

# Comments: https://andrewshitov.com/2020/07/15/use-sequences-in-raku/

my @s = '', {
    $^a ~ 0 ~ $^a.flip.trans('01' => '10')
} ... *;

.say for @s[^9];
