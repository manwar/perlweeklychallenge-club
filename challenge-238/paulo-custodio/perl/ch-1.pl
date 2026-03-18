#!/usr/bin/env perl

# Perl Weekly Challenge 238 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-238/

use Modern::Perl;

my @n = @ARGV;
my $sum = 0;
say "(", join(", ", map {$sum += $_} @n), ")";
