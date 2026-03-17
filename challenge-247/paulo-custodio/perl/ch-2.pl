#!/usr/bin/env perl

# Perl Weekly Challenge 247 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/

use Modern::Perl;

my($word) = @ARGV;
my %pairs;
for my $i (0 .. length($word)-1) {
    $pairs{substr($word, $i, 2)}++;
}
my($pair) = sort {$pairs{$b} <=> $pairs{$a}} sort keys %pairs;
say $pair;
