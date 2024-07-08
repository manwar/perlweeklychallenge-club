#!/usr/bin/env perl
# Perl weekly challenge 277
# Task 2:  Strong Pair
#
# See https://wlmb.github.io/2024/07/08/PWC277/#task-2-strong-pair
use v5.36;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(min uniqnum);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to count the number of strong pairs of numbers N1 N2...
    FIN
my @uniq=uniqnum(@ARGV);
say "@ARGV -> ", 0+grep {0<abs($_->[1]-$_->[0])<min(@$_)}combinations(\@uniq,2);
