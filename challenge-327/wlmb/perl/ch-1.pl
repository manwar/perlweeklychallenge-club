#!/usr/bin/env perl
# Perl weekly challenge 327
# Task 1:  Missing Integers
#
# See https://wlmb.github.io/2025/06/26/PWC327/#task-1-missing-integers
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2..Nm
    to find the numbers 1..m missing from N1 N2..Nm
    FIN
my %present;
$present{$_}++ for @ARGV;
say "@ARGV -> ", join " ", grep {!$present{$_}} 1..@ARGV
