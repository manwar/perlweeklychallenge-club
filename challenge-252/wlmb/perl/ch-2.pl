#!/usr/bin/env perl
# Perl weekly challenge 252
# Task 2:  Unique Sum Zero
#
# See https://wlmb.github.io/2024/01/15/PWC252/#task-2-unique-sum-zero
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to obtain arrays of N_j numbers that add up to zero.
    FIN
for(@ARGV){
    warn("Input must be greater than one"), next unless $_>=1;
    say "$_ -> [", join(" ", -$_/2..-1, $_%2?(0):(), 1..$_/2), "]";
}
