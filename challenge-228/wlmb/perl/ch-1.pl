#!/usr/bin/env perl
# Perl weekly challenge 228
# Task 1:  Unique Sum
#
# See https://wlmb.github.io/2023/07/31/PWC228/#task-1-unique-sum
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage $0 N1 [N2... ]
    to sum unique elements of the array (N1 N2...)
    FIN
my %count;
++$count{$_} for @ARGV;
say "@ARGV -> ",  sum0 grep {$count{$_}==1} @ARGV
