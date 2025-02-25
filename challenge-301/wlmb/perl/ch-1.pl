#!/usr/bin/env perl
# Perl weekly challenge 301
# Task 1:  Largest Number
#
# See https://wlmb.github.io/2024/12/23/PWC301/#task-1-largest-number
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 I1 I2...
    to produce the largest number by joining
    the integers I1 I2... in the best order.
    FIN
say "@ARGV -> ", join "", sort {$b.$a <=> $a.$b} @ARGV;
