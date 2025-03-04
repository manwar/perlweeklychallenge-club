#!/usr/bin/env perl
# Perl weekly challenge 311
# Task 1:  Upper Lower
#
# See https://wlmb.github.io/2025/03/03/PWC311/#task-1-upper-lower
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to change upper<->lower case in the strings Sn
    FIN
for(@ARGV){
    say "$_ -> ", tr/a-zA-Z/A-Za-z/r;
}
