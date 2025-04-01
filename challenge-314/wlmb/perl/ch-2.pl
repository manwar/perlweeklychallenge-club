#!/usr/bin/env perl
# Perl weekly challenge 314
# Task 2:  Sort Column
#
# See https://wlmb.github.io/2025/03/24/PWC314/#task-2-sort-column
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    $0 S1 S2...
    to count how many columns of a matrix formed by the n-th character
    Cnm of the m-th string Sm has to be deleted so that the remaining columns
    are sorted.
    FIN
die "All strings have to be of the same length" unless pdl(map {length} @ARGV)->uniq->nelem==1;
my $matrix = pdl(map {[map {ord lc} split ""]} @ARGV)->mv(1,0);
my $sorted = $matrix->qsort;
say "@ARGV -> ",($matrix != $sorted)->orover->sum;
