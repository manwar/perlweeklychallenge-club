#!/usr/bin/perl

# Perl Weekly Challenge - 090
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-090/
#
# Task 1 - DNA Sequence
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

# Unbuffered STDOUT
$|++;

my %dnaMapping = (qw(T A A T G C C G));

@ARGV = (qw(GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG))
  unless (@ARGV);

my ($D) = @ARGV;

die "Not a valid DNA sequence"
  if ($D =~ m#[^ATCG]#);

printf "Input:  %s\n", $D;

$D =~ s#(.)#$dnaMapping{$1}#g;

printf "Output: %s\n", $D;

