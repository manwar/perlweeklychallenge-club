#!/usr/bin/env perl

use v5.36;

say "challenge-213-task1";

# Task 1: Fun Sort
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in ascending order.

while (<DATA>) {
    chomp;
    my @list = sort { $a <=> $b } split /,/;
    my @even = grep { ! ($_ % 2) } @list;
    my @odd = grep { $_ % 2 } @list;
    my @out = (@even, @odd);
    print "@out\n";
}


__DATA__
3,6,1,4,5,2
1,2
1
