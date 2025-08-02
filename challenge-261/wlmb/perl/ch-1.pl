#!/usr/bin/env perl
# Perl weekly challenge 261
# Task 1:  Element Digit Sum
#
# See https://wlmb.github.io/2024/03/18/PWC261/#task-1-element-digit-sum
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    usage: $0 N1 [N2...]
    to find the diference between the sum of the numbers N1+N2+...
    and the sum of their digits
    FIN
say "@ARGV -> ", sum0 map {$_-sum0 split""} @ARGV;
