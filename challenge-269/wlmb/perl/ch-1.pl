#!/usr/bin/env perl
# Perl weekly challenge 269
# Task 1:  Bitwise OR
#
# See https://wlmb.github.io/2024/05/13/PWC269/#task-1-bitwise-or
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find if there are two or more numbers Ni whose bitwise
    or has the zeroth bit turned off.
    FIN
say "@ARGV -> ", (my @x=grep {($_&1)==0} @ARGV)>=2?"True":"False";
