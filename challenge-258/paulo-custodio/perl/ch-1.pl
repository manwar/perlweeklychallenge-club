#!/usr/bin/env perl

# Perl Weekly Challenge 258 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/

use Modern::Perl;

my @ints = @ARGV;
say scalar grep {length($_) % 2 == 0} @ints;
