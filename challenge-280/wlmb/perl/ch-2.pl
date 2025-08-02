#!/usr/bin/env perl
# Perl weekly challenge 280
# Task 2:  Count Asterisks
#
# See https://wlmb.github.io/2024/07/29/PWC280/#task-2-count-asterisks
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to count the asterisks in the strings S1 S2... that are not within
    pairs of vertical bars.
    FIN
for(@ARGV){
    print "$_ -> ";
    s/\|.*?\|//g;
    say tr/*//
}
