#!/usr/bin/env perl

# Perl Weekly Challenge 332 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/

use Modern::Perl;

@ARGV==1 or die "usage: $0 yyyy-mm-dd\n";
my($y, $m, $d) = split /-/, $ARGV[0];
printf("%b-%b-%b\n", $y, $m, $d);
