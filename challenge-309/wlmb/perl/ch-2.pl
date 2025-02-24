#!/usr/bin/env perl
# Perl weekly challenge 309
# Task 2:  Min Diff
#
# See https://wlmb.github.io/2025/02/16/PWC309/#task-2-min-diff
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV >= 2;
    Usage: $0 N0 N1...
    to find the minimum difference between the numbers N0, N1...
    FIN
my @sorted=sort {$a<=>$b} @ARGV;
say "@ARGV -> ", min map{$sorted[$_]-$sorted[$_-1]}(1..@sorted-1);
