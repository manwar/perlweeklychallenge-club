#!/usr/bin/env perl
# Perl weekly challenge 215
# Task 1:  Odd one Out
#
# See https://wlmb.github.io/2023/05/01/PWC215/#task-1-odd-one-out
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 [W2...]
    to count words whose letters are not sorted
    FIN
say "@ARGV -> ", 0+grep {(join "", sort {$a cmp $b} split "") ne $_} @ARGV;
