#!/usr/bin/env perl
# Perl weekly challenge 243
# Task 1:  Reverse Pairs
#
# See https://wlmb.github.io/2023/11/13/PWC243/#task-1-reverse-pairs
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find how many reversed pairs are in the array N1 N2...
    FIN
my $matrix=pdl(@ARGV)->dummy(1,0+@ARGV);
say "@ARGV ->",
    (($matrix->xvals < $matrix->yvals) & ($matrix > 2*$matrix->transpose))->sum;
