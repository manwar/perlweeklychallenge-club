#!/usr/bin/env perl
# Perl weekly challenge 249
# Task 1:  Equal Pairs
#
# See https://wlmb.github.io/2023/12/25/PWC249/#task-1-equal-pairs
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find pairs of equal numbers N_i == N_j
    FIN
my %count;
$count{$_}++ for @ARGV;
say "(@ARGV) => ",
    (all {$_%2==0} values %count)
    ? map {("($_ $_) ") x ($count{$_}/2)} sort {$a<=>$b} keys %count:"()"
