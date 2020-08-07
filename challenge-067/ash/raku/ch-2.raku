#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-067/

# Comments: https://andrewshitov.com/2020/06/29/combinations-in-raku/

my @keypad = 
    ' ',
    < _ , @>,
    < a b c >,
    < d e f >,
    < g h i >,
    < j k l >,
    < m n o >,
    < p q r s >,
    < t u v >,
    < w x y z >;

my $n = 35;

say [X~] @keypad[$n.comb];
