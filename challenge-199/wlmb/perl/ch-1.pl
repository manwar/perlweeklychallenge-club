#!/usr/bin/env perl
# Perl weekly challenge 199
# Task 1:  Good Pairs. Searching all combinations
#
# See https://wlmb.github.io/2023/01/09/PWC199/#task-1-good-pairs
use v5.36;
use Algorithm::Combinatorics qw(combinations);
say(<<~"FIN"), exit unless @ARGV >= 2;
    Usage: $0 N1 N2 [N3...]
    to find all good pairs from the set N1 N2...
    FIN
say join " ", @ARGV, "->", 0+grep{$ARGV[$_->[0]]==$ARGV[$_->[1]]} combinations(\@ARGV, 2)
