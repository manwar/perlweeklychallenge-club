#!/usr/bin/env perl
# Perl weekly challenge 225
# Task 1:  Max Words
#
# See https://wlmb.github.io/2023/07/09/PWC225/#task-1-max-words
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to count the maximum number of space separated words in sentences S1 S2...
    FIN
say join "\n", @ARGV, " -> ", max map {0+@{[split " "]}} @ARGV;
