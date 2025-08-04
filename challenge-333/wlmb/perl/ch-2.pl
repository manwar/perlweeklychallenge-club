#!/usr/bin/env perl
# Perl weekly challenge 333
# Task 2:  Duplicate Zeros
#
# See https://wlmb.github.io/2025/08/04/PWC333/#task-2-duplicate-zeros
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to duplicate zeroes in the list N1 N2..., keeping the length.
    FIN
    say "@ARGV -> ", join " ", (
	map{$_||(0,0)} @ARGV) # duplicate zeros
        [0..@ARGV-1];         # keep size of input
