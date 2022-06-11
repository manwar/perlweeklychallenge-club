#!/usr/bin/env perl
# Perl weekly challenge 163
# Task 1: Sum bitwise operator
#
# See https://wlmb.github.io/2022/05/02/PWC163/#task-1-sum-bitwise-operator
use v5.12;
use warnings;
use PDL;
die "Usage: ./ch-1.pl n1 [n2....] ...\n",
    "to calculate the sum of n_i&n_j for all unique non-repeating pairs n_i, n_j\n"
    unless @ARGV;
my $in=pdl(@ARGV);
my $n=$in->uniq; # filter out repeated elements
my $r=where($n&$n->dummy(0), $n^$n->dummy(0))->sum/2;
say "Input: $in Output: $r";
