#!/usr/bin/env perl

# Perl Weekly Challenge 264 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/

use Modern::Perl;

my($source, $indices) = split /,/, "@ARGV";
my @source = split ' ', $source;
my @indices = split ' ', $indices;

my @result;
for (0 .. $#source) {
    splice(@result, $indices[$_], 0, $source[$_]);
}

say "(", join(", ", @result), ")";
