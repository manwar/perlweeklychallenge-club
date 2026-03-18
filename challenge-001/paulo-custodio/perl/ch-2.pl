#!/usr/bin/env perl

# Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

use Modern::Perl;

my $n = shift || 20;
for (1 .. $n) {
    say(($_%15)==0 ? "fizzbuzz" : ($_%3)==0 ? "fizz" : ($_%5)==0 ? "buzz" : $_);
}
