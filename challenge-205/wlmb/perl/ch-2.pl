#!/usr/bin/env perl
# Perl weekly challenge 205
# Task 2:  Maximum XOR
#
# See https://wlmb.github.io/2023/02/20/PWC205/#task-2-maximum-xor
use v5.36;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(max);
die <<~"FIN" unless @ARGV >= 2;
    Usage: $0 N1 N2 [N3...]
    to find the maximum xor of pairs from the list N1 N2 N3...
    FIN
say join " ", @ARGV, "->", max map  {$_->[0] ^ $_->[1]} combinations([@ARGV],2);
