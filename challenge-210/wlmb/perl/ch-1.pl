#!/usr/bin/env perl
# Perl weekly challenge 210
# Task 1:  Kill and Win
#
# See https://wlmb.github.io/2023/03/27/PWC210/#task-1-kill-and-win
use v5.36;
use List::Util qw(sum);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to get the maximum points when killing the numbers N1 N2...
    FIN
say "(@ARGV) -> ", sum @ARGV;
