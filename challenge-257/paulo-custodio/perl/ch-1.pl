#!/usr/bin/env perl

# Perl Weekly Challenge 257 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/

use Modern::Perl;

my(@ints) = @ARGV;
my @smaller;
for my $i (0..$#ints) {
    push @smaller, scalar grep {$ints[$_] < $ints[$i]} 0..$#ints;
}
say "(", join(", ", @smaller), ")";
