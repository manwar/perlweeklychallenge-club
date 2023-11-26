#!/usr/bin/env perl
# Perl weekly challenge 238
# Task 1:  Running Sum
#
# See https://wlmb.github.io/2023/10/09/PWC238/#task-1-running-sum
use v5.36;
use List::Util qw(reductions);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to return the running sum N1, N1+N2, N1+N2+N3...
    of the numbers N1, N2...
    FIN
say "@ARGV -> ", join " ", reductions {$a+$b} @ARGV
