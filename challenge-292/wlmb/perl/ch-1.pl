#!/usr/bin/env perl
# Perl weekly challenge 292
# Task 1:  Twice Largest
#
# See https://wlmb.github.io/2024/10/21/PWC292/#task-1-twice-largest
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find the index of the largest element of the array N0 N1...
    if it is not smaller than twice the second largest.
    FIN
my @sorted = sort {$b->[1] <=> $a->[1]} map {[$_, $ARGV[$_]]} 0..@ARGV-1;
my $result = @sorted <= 1? -1
    : $sorted[0][1] >= 2*$sorted[1][1]? $sorted[0][0]
    : -1;
say "@ARGV -> $result";
