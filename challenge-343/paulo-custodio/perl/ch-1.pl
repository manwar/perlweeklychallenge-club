#!/usr/bin/env perl

# Perl Weekly Challenge 343 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say((sort {$a<=>$b} map {abs($_)} @ARGV)[0]);
