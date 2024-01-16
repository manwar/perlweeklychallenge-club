#!/usr/bin/env perl
# Perl weekly challenge 251
# Task 1:  Concatenation Value
#
# See https://wlmb.github.io/2024/01/08/PWC251/#task-1-concatenation-value
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to concatenate and add the numbers N_1 . N_k + N_2 . N_{k-1} +...
    FIN
my $tot=0;
my @ints=@ARGV;
$tot += shift(@ints).(pop(@ints)//"") while(@ints);
say "@ARGV -> $tot";
