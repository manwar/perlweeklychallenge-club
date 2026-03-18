#!/usr/bin/env perl

# Perl Weekly Challenge 244 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

use Modern::Perl;

@ARGV or die "Usage: $0 n n n...\n";

my @nums = @ARGV;
my @smaller;

for my $i (0..$#nums) {
    $smaller[$i] = 0;
    for my $j (0..$#nums) {
        $smaller[$i]++ if $nums[$j] < $nums[$i];
    }
}

say "@smaller";
