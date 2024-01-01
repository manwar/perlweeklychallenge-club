#!/usr/bin/env perl
# Perl weekly challenge 250
# Task 2:  Alphanumeric String Value
#
# See https://wlmb.github.io/2024/01/01/PWC250/#task-2-alphanumeric-string-value
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 [S1...]
    to find the maximum \"value\" of the strings S0 S1...
    FIN
say "@ARGV -> ", max map {/^[+-]?\d+$/?0+$_:length $_} @ARGV;
