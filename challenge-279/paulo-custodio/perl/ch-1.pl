#!/usr/bin/env perl

# Perl Weekly Challenge 279 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/

use Modern::Perl;

@ARGV > 2 or die "Usage: $0 LETTTERS WEIGHTS...\n";
my($letters, @weights) = @ARGV;
my @letters = split //, $letters;
say join('',
        map {$_->[0]}
        sort {$a->[1] <=> $b->[1]}
        map {[$letters[$_], $weights[$_]]} 0..$#letters);
