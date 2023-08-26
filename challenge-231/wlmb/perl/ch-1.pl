#!/usr/bin/env perl
# Perl weekly challenge 231
# Task 1:  Min Max
#
# See https://wlmb.github.io/2023/08/20/PWC231/#task-1-min-max
use v5.36;
use List::MoreUtils qw(minmax);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find all numbers Ni that are not minimum nor maximum.
    FIN
my @in=@ARGV;
my ($low,$high)=minmax(@in);
my @out=grep {$_!=$low && $_!=$high} @in;
say "(@in) -> ", join " ", @out?"(@out)":-1
