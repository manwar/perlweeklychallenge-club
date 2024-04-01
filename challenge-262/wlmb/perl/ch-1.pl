#!/usr/bin/env perl
# Perl weekly challenge 262
# Task 1:  Max Positive Negative
#
# See https://wlmb.github.io/2024/03/24/PWC262/#task-1-max-positive-negative
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find the maximum number of equally signed numbers N_i
    FIN
my @count=(0,0);
$count[$_>=0//0]++ for @ARGV;
say "@ARGV -> ", max @count;
