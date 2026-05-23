#!/usr/bin/env perl
# Perl weekly challenge 374
# Task 2:  Largest Same-digits Number
#
# See https://wlmb.github.io/2026/05/22/PWC374/#task-2-largest-same-digits-number
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the largest number made of repetitions of
    a single digit within the string Sn
    FIN
say "$_ -> ", max /((\d)\2*)/g for(@ARGV);
