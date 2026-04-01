#!/usr/bin/env perl

# Perl Weekly Challenge 182 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-182/

use Modern::Perl;

my @in = @ARGV;
say((map {$_->[0]} sort {$b->[1] <=> $a->[1]} map {[$_, $in[$_]]} 0..$#in)[0]);
