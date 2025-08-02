#!/usr/bin/env perl
# Perl weekly challenge 320
# Task 2:  Sum Difference
#
# See https://wlmb.github.io/2025/05/05/PWC320/#task-2-sum-difference
use v5.36;
use List::Util qw(sum0 all);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to compute the absolute value between the sum of the positive
    intengers N1 N2... and the sum of their digits.
    FIN
my @digits = map {split ""} @ARGV;
die "Only digits allowed" unless all {/[0-9]/} @digits;
say "@ARGV -> ", sum0(@ARGV)-sum0(@digits);
