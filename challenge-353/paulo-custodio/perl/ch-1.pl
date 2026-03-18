#!/usr/bin/env perl

# Perl Weekly Challenge 353 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/

use Modern::Perl;

@ARGV or die "usage: $0 sentences...\n";
my @words = sort {$a<=>$b} map {scalar @$_} map {[split ' ', $_]} @ARGV;
say $words[-1];
