#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-021/
# Task #1
# Write a script to calculate the value of e, also known as Euler's number and Napier's constant.
# Please checkout wiki page for more information.
# https://en.wikipedia.org/wiki/E_(mathematical_constant)

use strict;
use warnings;

my $e_aprox = 0;
my $fact = 1;
for (1, 1 .. 100) {
    $fact *= $_;
    $e_aprox += 1/$fact;
}

print $e_aprox;
