#!/usr/bin/env perl
# Perl weekly challenge 258
# Task 1:  Count Even Digits Number
#
# See https://wlmb.github.io/2024/02/26/PWC258/#task-1-count-even-digits-number
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to count how many input numbers have an even number of digits.
    FIN
die "Only digits allowed" unless all {/^\d+$/} @ARGV;
say "@ARGV -> ", 0+grep {(split "")%2==0}@ARGV;
