#!/usr/bin/env perl

# Perl Weekly Challenge 252 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/

use Modern::Perl;

my $n = shift || 0;
die "Usage: ch-2.pl N\n" if $n < 1;

my @half = 1..int($n/2);
my @out = ((reverse map {-$_} @half), (($n % 2 == 1) ? (0) : ()), (@half));
say "(", join(", ", @out), ")";
