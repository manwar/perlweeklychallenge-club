#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-009/
# Challenge #1
# Write a script that finds the first square number that has at least 5 distinct digits.
# This was proposed by Laurent Rosenfeld.

use strict;
use warnings;

my $n = 100; #any less won't give a 5 digit number when squared
my @digits;
do {
    @digits = ();
    map { $digits[$_] = 1 } split //, ++$n**2;
} until ( 5 == grep $_, @digits);
print $n**2; #12769
