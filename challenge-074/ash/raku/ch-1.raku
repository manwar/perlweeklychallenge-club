#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/

# Comments: https://andrewshitov.com/2020/08/18/the-weekly-challenge-for-74/

my @a = 1, 2, 2, 3, 2, 4, 2;
# my @a = 1, 3, 1, 2, 4, 5;

my $most-frequent = (@a.Bag.sort: -*.value)[0];

say $most-frequent.value > @a.elems / 2 ?? $most-frequent.key !! -1;

# Output: 
# $ raku ch-1.raku 
# 2
# 
# For the second @a:
# $ raku ch-1.raku 
# -1
