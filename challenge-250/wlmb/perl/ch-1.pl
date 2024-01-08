#!/usr/bin/env perl
# Perl weekly challenge 250
# Task 1:  Smallest Index
#
# See https://wlmb.github.io/2024/01/01/PWC250/#task-1-smallest-index
use v5.36;
use List::Util qw(first);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 [N1...]
    to find first index i for which N_i%10==i
    FIN
say "@ARGV -> ", (first {$ARGV[$_]%10==$_} @ARGV)//-1;
