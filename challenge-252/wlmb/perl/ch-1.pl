#!/usr/bin/env perl
# Perl weekly challenge 252
# Task 1:  Special Numbers
#
# See https://wlmb.github.io/2024/01/15/PWC252/#task-1-special-numbers
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to sum the squares of the special elements of N1 N2...
    FIN
say "@ARGV -> ", sum0 map {$ARGV[$_-1]**2} grep {@ARGV%$_==0} 1..@ARGV;
