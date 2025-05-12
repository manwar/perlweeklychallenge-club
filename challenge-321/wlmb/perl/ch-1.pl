#!/usr/bin/env perl
# Perl weekly challenge 321
# Task 1:  Distinct Average
#
# See https://wlmb.github.io/2025/05/12/PWC321/#task-1-distinct-average
use v5.36;
use List::Util qw(uniq);
my $N=@ARGV;
die <<~"FIN" unless $N && $N%2==0;
    Usage: $0 N1 N2...N2n
    to remove the smallest and largest value of the list, average them and
    count the distinct values produced.
    FIN
my @sorted = sort {$a <=> $b} @ARGV;
my $N2 = $N/2-1; #
say "@ARGV -> ", scalar uniq map {$sorted[$_]+$sorted[-1-$_]} 0..$N2;
