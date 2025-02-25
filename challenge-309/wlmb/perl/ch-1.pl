#!/usr/bin/env perl
# Perl weekly challenge 309
# Task 1:  Min Gap
#
# See https://wlmb.github.io/2025/02/16/PWC309/#task-1-min-gap
use v5.36;
use List::UtilsBy qw(min_by);
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 N0 N1...
    to find the element that is closest to its predecessor in the ordered list N0 N1...
    FIN
say "@ARGV -> ", (min_by {$_->[0]} map{[$ARGV[$_]-$ARGV[$_-1], $ARGV[$_]]} 1..@ARGV-1)->[1];
