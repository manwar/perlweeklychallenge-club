#!/usr/bin/env perl
# Perl weekly challenge 265
# Task 1:  33% Appearance
#
# See https://wlmb.github.io/2024/04/16/PWC265/#task-1-33%-appearance
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the smallest of the numbers N1... that appears
    with a frequency of at least a third.
    FIN
my %frequencies;
$frequencies{$_}++ for @ARGV;
say "@ARGV -> ", (min grep {3*$frequencies{$_}>=@ARGV} keys %frequencies) // "undef";
