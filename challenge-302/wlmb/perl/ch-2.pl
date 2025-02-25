#!/usr/bin/env perl
# Perl weekly challenge 302
# Task 2:  Step by Step
#
# See https://wlmb.github.io/2024/12/29/PWC302/#task-2-step-by-step
use v5.36;
use List::Util qw(reductions min max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the minimum positive start value S such that step by step
    sum S, S+N1, S+N1+N2... is never less than one.
    FIN
say "@ARGV -> ",max 1,1 - min reductions{$a+$b}@ARGV;
